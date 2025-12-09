import 'package:bamtol/src/common/components/app_font.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212123),
      appBar: AppBar(
        title: const AppFont('채팅', size: 18, fontWeight: FontWeight.bold),
        backgroundColor: const Color(0xff212123),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: 5,
        separatorBuilder: (context, index) => const Divider(
          color: Color(0xff2a2a2c),
          thickness: 1,
          height: 1,
        ),
        itemBuilder: (context, index) {
          return _buildChatItem(index);
        },
      ),
    );
  }

  Widget _buildChatItem(int index) {
    final names = ['당근이', '캠핑러', '맥북삽니다', '나눔천사', '직거래만'];
    final messages = [
      '환영합니다! 지금부터 당근마켓을 시작해보세요.',
      '네 그럼 내일 2시에 뵙겠습니다.',
      '혹시 네고 가능할까요?',
      '감사합니다 잘 쓰겠습니다!',
      '도착했습니다 어디세요?',
    ];
    final times = ['1달 전', '2시간 전', '어제', '3일 전', '방금 전'];

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[800],
                  child: Icon(Icons.person, color: Colors.grey[400]),
                ),
                // 온라인/안읽음 표시 (예시)
                if (index % 2 == 0)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xff212123), width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppFont(names[index], size: 15, fontWeight: FontWeight.bold),
                      const SizedBox(width: 4),
                      AppFont('아라동 · ${times[index]}', size: 12, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 4),
                  AppFont(
                    messages[index],
                    size: 14,
                    color: Colors.white,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (index != 0) // 첫번째 공지 빼고 상품 썸네일 예시
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xff2a2a2c),
                ),
                child: const Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
