import 'package:bamtol/src/common/components/app_font.dart';
import 'package:bamtol/src/home/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;
  
  const ProductDetailPage({
    super.key,
    required this.product,
  });

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
              background: product.imageUrl != null
                  ? Image.network(
                      product.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xff2a2a2c),
                          child: const Center(
                            child: Icon(Icons.image, color: Colors.grey, size: 64),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: const Color(0xff2a2a2c),
                      child: const Center(
                        child: Icon(Icons.image, color: Colors.grey, size: 64),
                      ),
                    ),
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
                            product.sellerName[0],
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
                              product.sellerName,
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
                        product.title,
                        size: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      AppFont(
                        _getTimeAgo(product.createdAt),
                        size: 13,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      const AppFont(
                        '상품 상태가 좋습니다. 구매 후 거의 사용하지 않았어요.\n직거래 가능하며 택배도 가능합니다.\n\n문의 주시면 친절하게 답변 드릴게요!',
                        size: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          AppFont(
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
                                  child: const Row(
                                    children: [
                                      Icon(Icons.location_on, color: Colors.orange, size: 16),
                                      SizedBox(width: 4),
                                      AppFont('아라동', size: 14, fontWeight: FontWeight.w500),
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
                      product.isFree ? '나눔' : '${_formatPrice(product.price ?? 0)}원',
                      size: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    if (!product.isFree)
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
                  Get.snackbar(
                    '채팅',
                    '${product.sellerName}님과 채팅을 시작합니다',
                    backgroundColor: Colors.white24,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
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
}
