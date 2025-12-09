import 'package:bamtol/src/common/components/app_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

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
          '알림',
          size: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildNotificationItem(
            icon: Icons.chat_bubble_outline,
            title: '새로운 채팅이 도착했어요',
            subtitle: '"안녕하세요, 아직 판매중인가요?"',
            time: '5분 전',
            isUnread: true,
          ),
          _buildNotificationItem(
            icon: Icons.favorite_border,
            title: '관심 상품 가격이 내려갔어요',
            subtitle: '애플 맥북 프로 14인치',
            time: '1시간 전',
            isUnread: true,
          ),
          _buildNotificationItem(
            icon: Icons.local_offer_outlined,
            title: '가격 제안이 들어왔어요',
            subtitle: '빈티지 원목 책상 - 130,000원',
            time: '3시간 전',
            isUnread: false,
          ),
          _buildNotificationItem(
            icon: Icons.campaign_outlined,
            title: '동네 인기글이 올라왔어요',
            subtitle: '아라동 주민들이 관심있는 상품',
            time: '어제',
            isUnread: false,
          ),
          _buildNotificationItem(
            icon: Icons.handshake_outlined,
            title: '거래가 완료되었어요',
            subtitle: '구매자에게 후기를 남겨보세요',
            time: '3일 전',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xff2a2a2c) : Colors.transparent,
        border: const Border(
          bottom: BorderSide(color: Color(0xff2a2a2c), width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.orange, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppFont(
                        title,
                        size: 14,
                        fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    AppFont(
                      time,
                      size: 12,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                AppFont(
                  subtitle,
                  size: 13,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
