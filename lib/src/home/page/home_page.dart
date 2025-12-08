import 'package:bamtol/src/common/components/app_bar.dart';
import 'package:bamtol/src/common/components/app_font.dart';
import 'package:bamtol/src/common/controller/authentication_controller.dart';
import 'package:bamtol/src/home/model/product_model.dart';
import 'package:bamtol/src/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // 샘플 상품 데이터
  List<ProductModel> get _sampleProducts => [
        ProductModel(
          id: '1',
          title: '애플 맥북 프로 14인치',
          sellerName: '테크러버',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          price: 2500000,
          imageUrl:
              'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800',
        ),
        ProductModel(
          id: '2',
          title: '빈티지 원목 책상',
          sellerName: '인테리어맘',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          price: 150000,
          imageUrl:
              'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=800',
        ),
        ProductModel(
          id: '3',
          title: '아이폰 14 프로 케이스',
          sellerName: '폰케이스샵',
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
          isFree: true,
          imageUrl:
              'https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=800',
        ),
        ProductModel(
          id: '4',
          title: '캠핑용 폴딩 체어 2개',
          sellerName: '캠핑매니아',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          price: 45000,
          imageUrl:
              'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=800',
        ),
        ProductModel(
          id: '5',
          title: '무선 블루투스 이어폰',
          sellerName: '음악사랑',
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
          isFree: true,
          imageUrl:
              'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800',
        ),
        ProductModel(
          id: '6',
          title: '손뜨개 인형 세트',
          sellerName: '핸드메이드',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          price: 25000,
          imageUrl:
              'https://images.unsplash.com/photo-1558679908-541bcf1249ff?w=800',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212123),
      appBar: CustomAppBar(
        locationName: '아라동',
        onSearchTap: () {
          debugPrint('검색 버튼 클릭');
        },
        onMenuTap: () {
          debugPrint('메뉴 버튼 클릭');
        },
        onNotificationTap: () {
          debugPrint('알림 버튼 클릭');
        },
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _sampleProducts.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey.withOpacity(0.1),
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
        itemBuilder: (context, index) {
          final product = _sampleProducts[index];
          return ProductCard(
            product: product,
            onTap: () {
              // 상세 페이지로 이동
              Get.snackbar(
                product.title,
                '상세 페이지로 이동합니다',
                backgroundColor: Colors.white24,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          );
        },
      ),
    );
  }
}