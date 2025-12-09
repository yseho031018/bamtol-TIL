import 'dart:typed_data';
import 'package:bamtol/src/common/components/app_font.dart';
import 'package:bamtol/src/product/controller/product_register_controller.dart';
import 'package:bamtol/src/product/page/location_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRegisterPage extends GetView<ProductRegisterController> {
  const ProductRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const AppFont(
          '내 물건 팔기',
          size: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 이미지 업로드 영역
                  _buildImageSection(),
                  
                  const Divider(color: Color(0xff1a1a1a), thickness: 1, height: 1),

                  // 글 제목 입력
                  _buildTitleInput(),
                  
                  const Divider(color: Color(0xff1a1a1a), thickness: 1, height: 1),

                  // 카테고리 선택
                  _buildCategorySelector(),
                  
                  const Divider(color: Color(0xff1a1a1a), thickness: 1, height: 1),

                  // 가격 입력 및 나눔 체크박스
                  _buildPriceSection(),
                  
                  const Divider(color: Color(0xff1a1a1a), thickness: 1, height: 1),

                  // 설명 입력
                  _buildDescriptionInput(),
                  
                  const Divider(color: Color(0xff1a1a1a), thickness: 8, height: 8),

                  // 거래 희망 장소
                  _buildLocationSelector(),
                ],
              ),
            ),
          ),
          // 하단 영역
          _buildBottomSection(),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 80,
        child: Obx(() => ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // 이미지 추가 버튼
                GestureDetector(
                  onTap: _showImagePickerDialog,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[700]!, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                          size: 28,
                        ),
                        const SizedBox(height: 4),
                        AppFont(
                          '${controller.images.length}/10',
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                // 업로드된 이미지들
                ...controller.images.asMap().entries.map((entry) {
                  return _buildImageThumbnail(entry.key, entry.value);
                }),
              ],
            )),
      ),
    );
  }

  Widget _buildImageThumbnail(int index, Uint8List imageBytes) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          margin: const EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: MemoryImage(imageBytes),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 0,
          child: GestureDetector(
            onTap: () => controller.removeImage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showImagePickerDialog() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xff2a2a2c),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title: const AppFont('갤러리에서 선택'),
              onTap: () {
                Get.back();
                controller.pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const AppFont('카메라로 촬영'),
              onTap: () {
                Get.back();
                controller.pickImageFromCamera();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller.titleController,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: '글 제목',
          hintStyle: const TextStyle(color: Color(0x4DFFFFFF), fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return GestureDetector(
      onTap: _showCategoryPicker,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => AppFont(
                  controller.selectedCategory.value.isEmpty
                      ? '카테고리 선택'
                      : controller.selectedCategory.value,
                  size: 16,
                  color: controller.selectedCategory.value.isEmpty
                      ? Colors.grey[500]
                      : Colors.white,
                )),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryPicker() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.6,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          color: Color(0xff2a2a2c),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: AppFont(
                '카테고리 선택',
                size: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return ListTile(
                    title: AppFont(category, size: 16),
                    onTap: () {
                      controller.setCategory(category);
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => TextField(
                  controller: controller.priceController,
                  enabled: !controller.isShareMode.value,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: '₩ 가격 (선택사항)',
                    hintStyle: const TextStyle(color: Color(0x4DFFFFFF), fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                )),
          ),
          // 나눔 체크박스
          Obx(() => GestureDetector(
                onTap: () =>
                    controller.toggleShareMode(!controller.isShareMode.value),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: controller.isShareMode.value
                            ? Colors.orange
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: controller.isShareMode.value
                              ? Colors.orange
                              : Colors.grey[600]!,
                          width: 2,
                        ),
                      ),
                      child: controller.isShareMode.value
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 18)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    const AppFont(
                      '나눔',
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildDescriptionInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller.descriptionController,
        maxLines: 6,
        style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
        decoration: InputDecoration(
          hintText: '아라동에 올릴 게시글 내용을 작성해주세요. (판매 금지 물품은 게시가 제한될 수 있어요.)',
          hintStyle:
              const TextStyle(color: Color(0x4DFFFFFF), fontSize: 16, height: 1.5),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }

  Widget _buildLocationSelector() {
    return GestureDetector(
      onTap: _showLocationPicker,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => AppFont(
                  controller.selectedLocation.value.isEmpty
                      ? '거래 희망 장소'
                      : controller.selectedLocation.value,
                  size: 16,
                  color: controller.selectedLocation.value.isEmpty
                      ? Colors.grey[500]
                      : Colors.white,
                )),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationPicker() async {
    final result = await Get.to(() => const LocationPickerPage());
    if (result != null && result is Map) {
      controller.setLocation(result['address'] as String);
    }
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Obx(() => Row(
                      children: [
                        const Icon(Icons.image_outlined, color: Colors.grey),
                        const SizedBox(width: 8),
                        AppFont(
                          '${controller.images.length}/10',
                          size: 14,
                          color: Colors.grey,
                        ),
                      ],
                    )),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: controller.submitProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const AppFont(
                  '작성 완료',
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
