import 'package:bamtol/src/common/components/app_bar.dart';
import 'package:bamtol/src/common/components/app_font.dart';
import 'package:bamtol/src/common/controller/authentication_controller.dart';
import 'package:bamtol/src/common/controller/location_controller.dart';
import 'package:bamtol/src/home/widget/product_card.dart';
import 'package:bamtol/src/home/page/neighborhood_picker_page.dart';
import 'package:bamtol/src/menu/page/menu_page.dart';
import 'package:bamtol/src/notification/page/notification_page.dart';
import 'package:bamtol/src/product/controller/product_controller.dart';
import 'package:bamtol/src/product/page/product_detail_page.dart';
import 'package:bamtol/src/search/page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final LocationController locationController = Get.find<LocationController>();
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: const Color(0xff212123),
      appBar: CustomAppBar(
        locationName: locationController.currentLocation.name,
        onLocationTap: () {
          _showLocationSelector();
        },
        onSearchTap: () {
          Get.to(() => const SearchPage());
        },
        onMenuTap: () {
          Get.to(() => const MenuPage());
        },
        onNotificationTap: () {
          Get.to(() => const NotificationPage());
        },
      ),
      body: productController.products.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, color: Colors.grey, size: 64),
                  SizedBox(height: 16),
                  AppFont('등록된 상품이 없습니다', size: 16, color: Colors.grey),
                  SizedBox(height: 8),
                  AppFont('글쓰기 버튼을 눌러 상품을 등록해보세요', size: 14, color: Colors.grey),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: productController.products.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.withOpacity(0.1),
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                final product = productController.products[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Get.to(() => ProductDetailPage(product: product));
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed('/product/register');
        },
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.add, color: Colors.white, size: 20),
        label: const AppFont(
          '글쓰기',
          size: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        extendedPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    ));
  }

  void _showLocationSelector() {
    Get.bottomSheet(
      Obx(() => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          color: Color(0xff2a2a2c),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AppFont(
                '내 동네 설정',
                size: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            // 동적 동네 목록
            ...List.generate(locationController.myLocations.length, (index) {
              final location = locationController.myLocations[index];
              final isSelected = locationController.selectedIndex.value == index;
              return _buildLocationItem(location.name, isSelected, index);
            }),
            const SizedBox(height: 16),
            // 동네 추가 버튼 (최대 2개까지)
            if (locationController.canAddMore)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () async {
                    Get.back();
                    final result = await Get.to(() => const NeighborhoodPickerPage());
                    if (result != null) {
                      locationController.addLocation(LocationModel(
                        name: result['name'],
                        fullAddress: result['fullAddress'],
                        latitude: result['latitude'],
                        longitude: result['longitude'],
                      ));
                      Get.snackbar(
                        '동네 추가 완료',
                        '${result['name']}이(가) 내 동네로 추가되었습니다',
                        backgroundColor: Colors.white24,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          AppFont('내 동네 추가하기', size: 14),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (!locationController.canAddMore)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: AppFont(
                    '동네는 최대 2개까지 설정할 수 있어요',
                    size: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      )),
    );
  }

  Widget _buildLocationItem(String name, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        locationController.selectLocation(index);
        Get.back();
        Get.snackbar(
          '동네 변경',
          '$name으로 변경되었습니다',
          backgroundColor: Colors.white24,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        color: isSelected ? Colors.orange.withOpacity(0.1) : Colors.transparent,
        child: Row(
          children: [
            AppFont(
              name,
              size: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.orange : Colors.white,
            ),
            if (isSelected) ...[
              const Spacer(),
              const Icon(Icons.check, color: Colors.orange, size: 20),
            ],
            // 삭제 버튼 (동네가 2개 이상일 때만, 선택되지 않은 동네만)
            if (!isSelected && locationController.myLocations.length > 1) ...[
              const Spacer(),
              GestureDetector(
                onTap: () {
                  locationController.removeLocation(index);
                },
                child: const Icon(Icons.close, color: Colors.grey, size: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
