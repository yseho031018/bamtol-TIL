import 'package:bamtol/src/common/components/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String locationName;
  final VoidCallback? onSearchTap;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;

  const CustomAppBar({
    super.key,
    this.locationName = '아라동',
    this.onSearchTap,
    this.onMenuTap,
    this.onNotificationTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff212123),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 왼쪽: 지역명 표시
              Row(
                children: [
                  AppFont(
                    locationName,
                    size: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    'assets/svg/icons/bottom_arrow.svg',
                    width: 6,
                    height: 6,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
              // 오른쪽: 아이콘 버튼들
              Row(
                children: [
                  // 검색 아이콘
                  _buildIconButton(
                    svgPath: 'assets/svg/icons/search.svg',
                    onTap: onSearchTap,
                  ),
                  const SizedBox(width: 8),
                  // 햄버거 메뉴 아이콘
                  _buildIconButton(
                    svgPath: 'assets/svg/icons/list.svg',
                    onTap: onMenuTap,
                  ),
                  const SizedBox(width: 8),
                  // 알림 아이콘
                  _buildIconButton(
                    svgPath: 'assets/svg/icons/bell.svg',
                    onTap: onNotificationTap,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required String svgPath,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset(
          svgPath,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
