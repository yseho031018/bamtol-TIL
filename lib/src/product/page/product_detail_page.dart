import 'package:bamtol/src/chat/page/chat_detail_page.dart';
import 'dart:typed_data';
import 'package:bamtol/src/common/components/app_font.dart';
import 'package:bamtol/src/home/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _currentPage = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    // 무한 스크롤 효과를 위해 중간 지점부터 시작
    final imageCount = _getImageCount();
    int initialPage = 0;
    if (imageCount > 1) {
      initialPage = imageCount * 1000;
    }
    _pageController = PageController(initialPage: initialPage);
  }

  int _getImageCount() {
    if (widget.product.imageBytesList.isNotEmpty) {
      return widget.product.imageBytesList.length;
    } else if (widget.product.imageUrls.isNotEmpty) {
      return widget.product.imageUrls.length;
    } else if (widget.product.imageBytes != null) {
      return 1;
    } else if (widget.product.imageUrl != null) {
      return 1;
    }
    return 0;
  }

  List<dynamic> get _allImages {
    final images = <dynamic>[];
    if (widget.product.imageBytesList.isNotEmpty) {
      images.addAll(widget.product.imageBytesList);
    } else if (widget.product.imageUrls.isNotEmpty) {
      images.addAll(widget.product.imageUrls);
    } else if (widget.product.imageBytes != null) {
      images.add(widget.product.imageBytes!);
    } else if (widget.product.imageUrl != null) {
      images.add(widget.product.imageUrl!);
    }
    return images;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212123),
      body: CustomScrollView(
        slivers: [
          // 상단 이미지 + 앱바
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: const Color(0xff212123),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, color: Colors.white, size: 20),
                ),
                onPressed: () {
                  Get.snackbar(
                    '공유',
                    '공유 기능입니다',
                    backgroundColor: Colors.white24,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.more_vert, color: Colors.white, size: 20),
                ),
                onPressed: () {
                  _showMoreOptions(context);
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImageSection(),
            ),
          ),

          // 상품 정보
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 판매자 정보
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xff2a2a2c), width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: AppFont(
                            widget.product.sellerName.isNotEmpty
                                ? widget.product.sellerName[0]
                                : '?',
                            size: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppFont(
                              widget.product.sellerName,
                              size: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 4),
                            const AppFont(
                              '아라동',
                              size: 13,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xff2a2a2c),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.thermostat, color: Colors.orange, size: 16),
                            SizedBox(width: 4),
                            AppFont('36.5°C', size: 12, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 상품 제목 및 정보
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.product.imageUrls.isNotEmpty || widget.product.imageBytesList.isNotEmpty) // 카테고리 정보가 없어서 임시로 하드코딩 되어있던 부분 유지
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xff2a2a2c),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const AppFont(
                            '디지털기기',
                            size: 12,
                            color: Colors.grey,
                          ),
                        ),
                      const SizedBox(height: 12),
                      AppFont(
                        widget.product.title,
                        size: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      AppFont(
                        _getTimeAgo(widget.product.createdAt),
                        size: 13,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      AppFont(
                        widget.product.description ?? '내용이 없습니다.',
                        size: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          const AppFont(
                            '관심 12',
                            size: 13,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 1,
                            height: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          const AppFont(
                            '조회 234',
                            size: 13,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 거래 희망 장소
                if (widget.product.location != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color(0xff2a2a2c), width: 8),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppFont(
                          '거래 희망 장소',
                          size: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: double.infinity,
                            height: 150,
                            child: Stack(
                              children: [
                                // 지도
                                FlutterMap(
                                  options: const MapOptions(
                                    initialCenter: LatLng(33.4890, 126.4983),
                                    initialZoom: 15.0,
                                    interactionOptions: InteractionOptions(
                                      flags: InteractiveFlag.none,
                                    ),
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.example.bamtol',
                                    ),
                                    const MarkerLayer(
                                      markers: [
                                        Marker(
                                          point: LatLng(33.4890, 126.4983),
                                          width: 40,
                                          height: 40,
                                          child: Icon(
                                            Icons.location_on,
                                            color: Colors.orange,
                                            size: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // 주소 표시 오버레이
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.8),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on, color: Colors.orange, size: 16),
                                        const SizedBox(width: 4),
                                        AppFont(widget.product.location!, size: 14, fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 100), // 하단 버튼 공간
              ],
            ),
          ),
        ],
      ),

      // 하단 고정 영역
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xff212123),
          border: Border(
            top: BorderSide(color: Color(0xff2a2a2c), width: 1),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              // 하트 버튼
              GestureDetector(
                onTap: () {
                  Get.snackbar(
                    '관심 상품',
                    '관심 목록에 추가되었습니다',
                    backgroundColor: Colors.white24,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff2a2a2c)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.favorite_border, color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              // 가격 및 제안 버튼
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppFont(
                      widget.product.isFree ? '나눔' : '${_formatPrice(widget.product.price ?? 0)}원',
                      size: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    if (!widget.product.isFree)
                      const AppFont(
                        '가격 제안하기',
                        size: 13,
                        color: Colors.orange,
                      ),
                  ],
                ),
              ),
              // 채팅 버튼
              ElevatedButton(
                onPressed: () {
                  Get.to(() => ChatDetailPage(product: widget.product));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const AppFont(
                  '채팅하기',
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    final images = _allImages;

    if (images.isEmpty) {
      return Container(
        color: const Color(0xff2a2a2c),
        child: const Center(
          child: Icon(Icons.image, color: Colors.grey, size: 64),
        ),
      );
    }

    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          // 이미지가 1개보다 많을 때만 무한 스크롤 적용
          itemCount: images.length > 1 ? null : 1,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index % images.length;
            });
          },
          itemBuilder: (context, index) {
            final image = images[index % images.length];
            if (image is Uint8List) {
              return Image.memory(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
              );
            } else if (image is String) {
              return Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildErrorImage(),
              );
            }
            return _buildErrorImage();
          },
        ),
        // 인디케이터 (이미지가 2개 이상일 때만 표시)
        if (images.length > 1) ...[
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                );
              }),
            ),
          ),
          
          // 왼쪽 화살표
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: _buildNavArrow(
                icon: Icons.chevron_left,
                onTap: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
          
          // 오른쪽 화살표
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: _buildNavArrow(
                icon: Icons.chevron_right,
                onTap: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildErrorImage() {
    return Container(
      color: const Color(0xff2a2a2c),
      child: const Center(
        child: Icon(Icons.image_not_supported, color: Colors.grey, size: 64),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          color: Color(0xff2a2a2c),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.report_outlined, color: Colors.white),
              title: const AppFont('신고하기', size: 16),
              onTap: () => Get.back(),
            ),
            ListTile(
              leading: const Icon(Icons.block, color: Colors.white),
              title: const AppFont('이 사용자의 글 숨기기', size: 16),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${dateTime.month}월 ${dateTime.day}일';
    }
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
  Widget _buildNavArrow({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
