import 'dart:typed_data';
import 'package:bamtol/src/home/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  // 상품 목록
  final RxList<ProductModel> products = <ProductModel>[
    // 샘플 상품 데이터
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
  ].obs;

  // 상품 추가
  void addProduct({
    required String title,
    String? category,
    int? price,
    bool isFree = false,
    String? description,
    String? location,
    List<Uint8List>? images,
  }) {
    final newProduct = ProductModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      sellerName: '나', // 현재 사용자
      createdAt: DateTime.now(),
      price: isFree ? null : price,
      isFree: isFree,
      description: description,
      location: location,
      imageBytes: images?.isNotEmpty == true ? images!.first : null,
    );
    
    // 목록 맨 앞에 추가
    products.insert(0, newProduct);
  }

  // 상품 삭제
  void removeProduct(String id) {
    products.removeWhere((product) => product.id == id);
  }
}
