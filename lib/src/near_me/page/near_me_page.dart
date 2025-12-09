import 'package:bamtol/src/common/components/app_font.dart';
import 'package:flutter/material.dart';

class NearMePage extends StatelessWidget {
  const NearMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212123),
      appBar: AppBar(
        title: const AppFont('내 근처', size: 18, fontWeight: FontWeight.bold),
        backgroundColor: const Color(0xff212123),
        elevation: 0,
        actions: [
           IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 검색바
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff2a2a2c),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    AppFont('근처 정보를 찾아보세요', size: 15, color: Colors.grey),
                  ],
                ),
              ),
            ),
            
            // 카테고리 그리드
            SizedBox(
              height: 180,
              child: GridView.count(
                crossAxisCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryIcon(Icons.monitor, '알바'),
                  _buildCategoryIcon(Icons.apartment, '부동산'),
                  _buildCategoryIcon(Icons.directions_car, '중고차'),
                  _buildCategoryIcon(Icons.school, '과외.클래스'),
                  _buildCategoryIcon(Icons.agriculture, '농수산물'),
                  _buildCategoryIcon(Icons.storefront, '지역업체'),
                  _buildCategoryIcon(Icons.local_shipping, '이사/용달'),
                  _buildCategoryIcon(Icons.more_horiz, '전체'),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            Container(height: 8, color: const Color(0xff2a2a2c)),
            
            // 이웃들의 추천 가게
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppFont('이웃들의 추천 가게', size: 18, fontWeight: FontWeight.bold),
                  const SizedBox(height: 16),
                  _buildShopItem('제주 흑돼지 맛집', '음식점 · 아라동', '후기 12 · 단골 54', 
                    'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=800'),
                  const SizedBox(height: 16),
                  _buildShopItem('감성 카페 Aura', '카페 · 이도동', '후기 5 · 단골 12', 
                    'https://images.unsplash.com/photo-1493857676977-67b451672072?w=800'),
                  const SizedBox(height: 16),
                  _buildShopItem('깨끗한 세탁소', '세탁 · 연동', '후기 3 · 단골 8', 
                    'https://images.unsplash.com/photo-1517677208171-0bc6799a423d?w=800'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xff2a2a2c),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        AppFont(label, size: 12, color: Colors.white),
      ],
    );
  }

  Widget _buildShopItem(String title, String subtitle, String info, String imageUrl) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 80, 
              height: 80, 
              color: const Color(0xff2a2a2c), 
              child: const Icon(Icons.store, color: Colors.grey)
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppFont(title, size: 16, fontWeight: FontWeight.bold),
              const SizedBox(height: 4),
              AppFont(subtitle, size: 13, color: Colors.grey),
              const SizedBox(height: 4),
              AppFont(info, size: 13, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}
