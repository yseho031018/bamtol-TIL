import 'package:get/get.dart';

class LocationModel {
  final String name;
  final String? fullAddress;
  final double? latitude;
  final double? longitude;

  LocationModel({
    required this.name,
    this.fullAddress,
    this.latitude,
    this.longitude,
  });
}

class LocationController extends GetxController {
  // 내 동네 목록
  final RxList<LocationModel> myLocations = <LocationModel>[
    LocationModel(
      name: '아라동',
      fullAddress: '제주특별자치도 제주시 아라동',
      latitude: 33.4890,
      longitude: 126.4983,
    ),
  ].obs;

  // 현재 선택된 동네 인덱스
  final RxInt selectedIndex = 0.obs;

  // 현재 선택된 동네
  LocationModel get currentLocation => myLocations[selectedIndex.value];

  // 동네 추가
  void addLocation(LocationModel location) {
    // 이미 있는 동네인지 확인
    final exists = myLocations.any((loc) => loc.name == location.name);
    if (!exists) {
      myLocations.add(location);
    }
  }

  // 동네 선택
  void selectLocation(int index) {
    if (index >= 0 && index < myLocations.length) {
      selectedIndex.value = index;
    }
  }

  // 동네 삭제
  void removeLocation(int index) {
    if (myLocations.length > 1 && index >= 0 && index < myLocations.length) {
      myLocations.removeAt(index);
      // 선택된 인덱스 조정
      if (selectedIndex.value >= myLocations.length) {
        selectedIndex.value = myLocations.length - 1;
      }
    }
  }

  // 동네 개수 확인 (최대 2개까지만 허용)
  bool get canAddMore => myLocations.length < 2;
}
