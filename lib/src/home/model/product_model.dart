class ProductModel {
  final String id;
  final String title;
  final String sellerName;
  final DateTime createdAt;
  final int? price;
  final bool isFree;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.title,
    required this.sellerName,
    required this.createdAt,
    this.price,
    this.isFree = false,
    required this.imageUrl,
  });

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${createdAt.month}월 ${createdAt.day}일';
    }
  }

  String get priceText {
    if (isFree) return '나눔';
    if (price == null) return '가격 미정';
    return '${_formatPrice(price!)}원';
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
