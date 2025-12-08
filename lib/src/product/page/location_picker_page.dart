import 'dart:convert';
import 'package:bamtol/src/common/components/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final MapController _mapController = MapController();
  
  // 기본 위치: 제주 아라동
  LatLng _selectedLocation = const LatLng(33.4890, 126.4983);
  String _selectedAddress = '아라동';
  bool _isLoadingAddress = false;
  
  @override
  void initState() {
    super.initState();
    _getAddressFromCoordinates(_selectedLocation);
  }

  Future<void> _getAddressFromCoordinates(LatLng location) async {
    setState(() {
      _isLoadingAddress = true;
    });

    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${location.latitude}&lon=${location.longitude}&accept-language=ko',
      );
      
      final response = await http.get(
        url,
        headers: {'User-Agent': 'BamtolApp/1.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'];
        
        String displayAddress = '';
        if (address != null) {
          // 한국 주소 형식에 맞게 다양한 필드 시도
          final dong = address['quarter'] ?? 
                       address['neighbourhood'] ?? 
                       address['suburb'] ?? 
                       address['village'] ??
                       address['hamlet'] ?? '';
          final gu = address['city_district'] ?? 
                     address['district'] ?? 
                     address['borough'] ?? '';
          final city = address['city'] ?? 
                       address['town'] ?? 
                       address['county'] ?? 
                       address['municipality'] ?? '';
          final road = address['road'] ?? '';
          
          // 우선순위: 동/리 > 도로명 > 구/군 > 시/도
          if (dong.toString().isNotEmpty) {
            displayAddress = dong.toString();
          } else if (road.toString().isNotEmpty) {
            displayAddress = road.toString();
          } else if (gu.toString().isNotEmpty) {
            displayAddress = gu.toString();
          } else if (city.toString().isNotEmpty) {
            displayAddress = city.toString();
          } else {
            // display_name에서 첫 번째 의미있는 부분 추출
            final displayName = data['display_name']?.toString() ?? '';
            if (displayName.isNotEmpty) {
              final parts = displayName.split(',');
              for (var part in parts) {
                final trimmed = part.trim();
                if (trimmed.isNotEmpty && !RegExp(r'^\d').hasMatch(trimmed)) {
                  displayAddress = trimmed;
                  break;
                }
              }
            }
          }
        }
        
        // 여전히 비어있으면 display_name 활용
        if (displayAddress.isEmpty) {
          final displayName = data['display_name']?.toString() ?? '';
          if (displayName.isNotEmpty) {
            displayAddress = displayName.split(',').first.trim();
          }
        }
        
        setState(() {
          _selectedAddress = displayAddress.isNotEmpty ? displayAddress : '주소를 찾을 수 없습니다';
          _isLoadingAddress = false;
        });
      } else {
        setState(() {
          _selectedAddress = '주소를 찾을 수 없습니다';
          _isLoadingAddress = false;
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress = '주소를 찾을 수 없습니다';
        _isLoadingAddress = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 지도 (전체 화면)
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _selectedLocation,
                initialZoom: 15.0,
                onPositionChanged: (position, hasGesture) {
                  if (hasGesture && position.center != null) {
                    setState(() {
                      _selectedLocation = position.center!;
                    });
                  }
                },
                onMapEvent: (event) {
                  if (event is MapEventMoveEnd) {
                    _getAddressFromCoordinates(_selectedLocation);
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.bamtol',
                ),
              ],
            ),
          ),
          
          // 중앙 고정 마커
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.circle,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                  Container(
                    width: 3,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // 상단 헤더
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 20,
                right: 20,
                bottom: 24,
              ),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const AppFont(
                    '이웃과 만나서',
                    size: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  const AppFont(
                    '거래하고 싶은 장소를 선택해주세요.',
                    size: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 10),
                  AppFont(
                    '만나서 거래할 때는 누구나 찾기 쉬운 공공장소가 좋아요.',
                    size: 12,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  // 선택된 주소 표시
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff2a2a2c),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.orange,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _isLoadingAddress
                              ? const AppFont(
                                  '주소 검색 중...',
                                  size: 14,
                                  color: Colors.grey,
                                )
                              : AppFont(
                                  _selectedAddress,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // 현재 위치 버튼
          Positioned(
            right: 16,
            bottom: 100,
            child: GestureDetector(
              onTap: _goToCurrentLocation,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.my_location,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
          ),
          
          // 하단 선택 완료 버튼
          Positioned(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16,
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoadingAddress
                    ? null
                    : () {
                        Get.back(result: {
                          'address': _selectedAddress,
                          'latitude': _selectedLocation.latitude,
                          'longitude': _selectedLocation.longitude,
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  disabledBackgroundColor: Colors.orange.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoadingAddress
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          AppFont(
                            '주소 확인 중...',
                            size: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ],
                      )
                    : const AppFont(
                        '선택 완료',
                        size: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToCurrentLocation() {
    final defaultLocation = const LatLng(33.4890, 126.4983);
    _mapController.move(defaultLocation, 15.0);
    setState(() {
      _selectedLocation = defaultLocation;
    });
    _getAddressFromCoordinates(defaultLocation);
  }
}
