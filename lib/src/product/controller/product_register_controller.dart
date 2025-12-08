import 'dart:typed_data';
import 'package:bamtol/src/product/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductRegisterController extends GetxController {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  final RxList<Uint8List> images = <Uint8List>[].obs;
  final RxString selectedCategory = ''.obs;
  final RxBool acceptPriceOffer = false.obs;
  final RxBool isShareMode = false.obs;
  final RxString selectedLocation = ''.obs;

  final List<String> categories = [
    '뷰티/미용',
    '디지털기기',
    '가구/인테리어',
    '생활/주방',
    '유아동',
    '여성의류',
    '남성의류',
    '스포츠/레저',
    '취미/게임/음반',
    '도서',
    '반려동물용품',
    '식물',
    '기타 중고물품',
  ];

  final ImagePicker _picker = ImagePicker();

  bool get canAddImage => images.length < 10;

  void toggleShareMode(bool value) {
    isShareMode.value = value;
    if (value) {
      priceController.clear();
    }
  }

  void setLocation(String location) {
    selectedLocation.value = location;
  }


  Future<void> pickImageFromGallery() async {
    if (!canAddImage) {
      Get.snackbar(
        '알림',
        '이미지는 최대 10장까지 등록 가능합니다',
        backgroundColor: Colors.white24,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      images.add(bytes);
    }
  }

  Future<void> pickImageFromCamera() async {
    if (!canAddImage) {
      Get.snackbar(
        '알림',
        '이미지는 최대 10장까지 등록 가능합니다',
        backgroundColor: Colors.white24,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      images.add(bytes);
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
    }
  }

  void setCategory(String? category) {
    if (category != null) {
      selectedCategory.value = category;
    }
  }

  void togglePriceOffer(bool? value) {
    acceptPriceOffer.value = value ?? false;
    if (acceptPriceOffer.value) {
      priceController.clear();
    }
  }

  bool validateForm() {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar(
        '알림',
        '제목을 입력해주세요',
        backgroundColor: Colors.white24,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (!acceptPriceOffer.value && priceController.text.trim().isEmpty) {
      Get.snackbar(
        '알림',
        '가격을 입력해주세요',
        backgroundColor: Colors.white24,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (descriptionController.text.trim().isEmpty) {
      Get.snackbar(
        '알림',
        '게시글 내용을 작성해주세요',
        backgroundColor: Colors.white24,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  void submitProduct() {
    if (!validateForm()) return;

    // ProductController에 상품 추가
    final productController = Get.find<ProductController>();
    productController.addProduct(
      title: titleController.text.trim(),
      category: selectedCategory.value.isNotEmpty ? selectedCategory.value : null,
      price: isShareMode.value ? null : int.tryParse(priceController.text.replaceAll(',', '')),
      isFree: isShareMode.value,
      description: descriptionController.text.trim(),
      location: selectedLocation.value.isNotEmpty ? selectedLocation.value : null,
      images: images.isNotEmpty ? images.toList() : null,
    );

    // 상품 등록 처리
    Get.snackbar(
      '성공',
      '상품이 등록되었습니다!',
      backgroundColor: const Color.fromRGBO(76, 175, 80, 0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    // 이전 페이지로 돌아가기
    Get.back();
  }

  @override
  void onClose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
