import 'package:bamtol/src/common/components/app_font.dart';
import 'package:bamtol/src/home/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 왼쪽: 썸네일 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildProductImage(),
            ),
            const SizedBox(width: 16),
            // 오른쪽: 텍스트 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상품 제목
                  AppFont(
                    product.title,
                    size: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  // 판매자 · 등록일
                  AppFont(
                    '${product.sellerName} · ${product.formattedDate}',
                    size: 13,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  // 가격 또는 나눔
                  _buildPriceWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    // imageBytes가 있으면 MemoryImage 사용
    if (product.imageBytes != null) {
      return Image.memory(
        product.imageBytes!,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    }
    
    // imageUrl이 있으면 NetworkImage 사용
    if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
      return Image.network(
        product.imageUrl!,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    }
    
    // 둘 다 없으면 placeholder
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[800],
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildPriceWidget() {
    if (product.isFree) {
      return Row(
        children: [
          AppFont(
            '나눔',
            size: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          const SizedBox(width: 2),
          const Text(
            '🧡',
            style: TextStyle(fontSize: 14),
          ),
        ],
      );
    }
    return AppFont(
      product.priceText,
      size: 15,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
  }
}
