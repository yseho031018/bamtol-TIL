import 'package:bamtol/src/common/components/app_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212123),
      appBar: AppBar(
        backgroundColor: const Color(0xff212123),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const AppFont(
          '카테고리',
          size: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCategoryItem(Icons.devices, '디지털기기'),
          _buildCategoryItem(Icons.chair, '가구/인테리어'),
          _buildCategoryItem(Icons.child_care, '유아동'),
          _buildCategoryItem(Icons.checkroom, '여성의류'),
          _buildCategoryItem(Icons.man, '남성의류'),
          _buildCategoryItem(Icons.face, '뷰티/미용'),
          _buildCategoryItem(Icons.sports_soccer, '스포츠/레저'),
          _buildCategoryItem(Icons.sports_esports, '취미/게임/음반'),
          _buildCategoryItem(Icons.menu_book, '도서'),
          _buildCategoryItem(Icons.pets, '반려동물용품'),
          _buildCategoryItem(Icons.kitchen, '생활/주방'),
          _buildCategoryItem(Icons.local_florist, '식물'),
          _buildCategoryItem(Icons.more_horiz, '기타 중고물품'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          title,
          '$title 카테고리 상품을 보여드릴게요',
          backgroundColor: Colors.white24,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xff2a2a2c), width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xff2a2a2c),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppFont(
                title,
                size: 16,
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
