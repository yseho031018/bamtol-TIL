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
      imageUrls: [
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800',
        'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=800', 
        'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=800'
      ],
      description: '맥북 프로 14인치 m1 pro 모델입니다. 상태 아주 깨끗하고 배터리 효율 95%입니다. 박스 풀셋입니다.',
      location: '아라동',
    ),
    ProductModel(
      id: '2',
      title: '빈티지 원목 책상',
      sellerName: '인테리어맘',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      price: 150000,
      imageUrl: 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=800',
      description: '이사하게 되어 내놓습니다. 원목이라 튼튼하고 디자인이 예뻐요. 직접 가져가셔야 합니다.',
      location: '노형동',
    ),
    ProductModel(
      id: '3',
      title: '아이폰 14 프로 케이스',
      sellerName: '폰케이스샵',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      isFree: true,
      imageUrls: [
        'https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=800',
        'https://images.unsplash.com/photo-1627341355416-d621b33230c1?w=800',
      ],
      description: '기종 변경으로 나눔합니다. 사용감 거의 없어요.',
      location: '연동',
    ),

    ProductModel(
      id: '5',
      title: '무선 블루투스 이어폰',
      sellerName: '음악사랑',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      isFree: true,
      imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800',
      description: '왼쪽 유닛을 잃어버려서 오른쪽이랑 본체만 필요하신 분 가져가세요.',
      location: '삼도동',
    ),
    ProductModel(
      id: '6',
      title: '손뜨개 인형 세트',
      sellerName: '핸드메이드',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      price: 25000,
      imageUrl: 'https://images.unsplash.com/photo-1558679908-541bcf1249ff?w=800',
      description: '직접 만든 손뜨개 인형입니다. 선물용으로 좋아요.',
      location: '화북동',
    ),
    ProductModel(
      id: '7',
      title: '로드 자전거',
      sellerName: '라이더',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      price: 350000,
      imageUrls: [
        'https://images.unsplash.com/photo-1532298229144-0ec0c57515c7?w=800',
        'https://images.unsplash.com/photo-1576435728678-687db3023fd6?w=800',
        'https://images.unsplash.com/photo-1507035895480-08acdf9b7466?w=800',
      ],
      description: '입문용 로드 자전거입니다. 사이즈 M이고 생활 기스 조금 있습니다.',
      location: '오라동',
    ),
    ProductModel(
      id: '8',
      title: '몬스테라 화분',
      sellerName: '식물집사',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      price: 15000,
      imageUrl: 'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?w=800',
      description: '너무 잘 자라서 분양합니다. 수형 예뻐요.',
      location: '외도동',
    ),
    ProductModel(
      id: '9',
      title: '나이키 운동화 270',
      sellerName: '신발수집가',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 10)),
      price: 89000,
      imageUrls: [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
        'https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?w=800',
      ],
      description: '사이즈 미스로 실착 1회 하고 보관만 했습니다. 박스 있어요.',
      location: '연동',
    ),
    ProductModel(
      id: '10',
      title: '게이밍 모니터 27인치',
      sellerName: '겜돌이',
      createdAt: DateTime.now().subtract(const Duration(hours: 20)),
      price: 180000,
      imageUrl: 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=800',
      description: '144hz 지원하는 게이밍 모니터입니다. 불량화소 없습니다.',
      location: '건입동',
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
      imageBytesList: images,
    );
    
    // 목록 맨 앞에 추가
    products.insert(0, newProduct);
  }

  // 상품 삭제
  void removeProduct(String id) {
    products.removeWhere((product) => product.id == id);
  }
}
