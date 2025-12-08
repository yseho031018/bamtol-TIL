import 'package:bamtol/src/common/components/app_font.dart';
import 'package:bamtol/src/home/model/product_model.dart';
import 'package:bamtol/src/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultPage extends StatelessWidget {
  final String searchQuery;
  
  const SearchResultPage({
    super.key,
    required this.searchQuery,
  });

  // 샘플 상품 데이터 (실제로는 서버에서 가져옴)
  List<ProductModel> get _allProducts => [
    ProductModel(
      id: '1',
      title: '애플 맥북 프로 14인치',
      sellerName: '테크러버',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      price: 2500000,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800',
    ),
    ProductModel(
      id: '2',
      title: '빈티지 원목 책상',
      sellerName: '인테리어맘',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      price: 150000,
      imageUrl: 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=800',
    ),
    ProductModel(
      id: '3',
      title: '아이폰 14 프로 케이스',
      sellerName: '폰케이스샵',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      isFree: true,
      imageUrl: 'https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=800',
    ),
    ProductModel(
      id: '4',
      title: '캠핑용 폴딩 체어 2개',
      sellerName: '캠핑매니아',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      price: 45000,
      imageUrl: 'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=800',
    ),
    ProductModel(
      id: '5',
      title: '무선 블루투스 이어폰',
      sellerName: '음악사랑',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      isFree: true,
      imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800',
    ),
    ProductModel(
      id: '6',
      title: '손뜨개 인형 세트',
      sellerName: '핸드메이드',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      price: 25000,
      imageUrl: 'https://images.unsplash.com/photo-1558679908-541bcf1249ff?w=800',
    ),
    ProductModel(
      id: '7',
      title: '맥북 에어 M2 실버',
      sellerName: '애플팬',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      price: 1200000,
      imageUrl: 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=800',
    ),
    ProductModel(
      id: '8',
      title: '아이폰 15 프로맥스 256GB',
      sellerName: '폰마스터',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      price: 1500000,
      imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=800',
    ),
  ];

  List<ProductModel> get _filteredProducts {
    if (searchQuery.isEmpty) return [];
    return _allProducts.where((product) {
      return product.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
             product.sellerName.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredProducts;
    
    return Scaffold(
      backgroundColor: const Color(0xff212123),
      appBar: AppBar(
        backgroundColor: const Color(0xff212123),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: AppFont(
          '"$searchQuery" 검색 결과',
          size: 16,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: results.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_off,
                    color: Colors.grey,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '"$searchQuery"에 대한\n검색 결과가 없습니다',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const AppFont(
                      '다른 검색어로 검색하기',
                      size: 14,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppFont(
                    '${results.length}개의 상품',
                    size: 14,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: results.length,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.withOpacity(0.1),
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                    itemBuilder: (context, index) {
                      final product = results[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
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
                ),
              ],
            ),
    );
  }
}
