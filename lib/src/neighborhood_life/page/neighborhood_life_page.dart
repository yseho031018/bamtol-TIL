import 'package:bamtol/src/common/components/app_font.dart';
import 'package:flutter/material.dart';

class NeighborhoodLifePage extends StatelessWidget {
  const NeighborhoodLifePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212123),
      appBar: AppBar(
        title: const AppFont('동네생활', size: 18, fontWeight: FontWeight.bold),
        backgroundColor: const Color(0xff212123),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 8,
          color: Color(0xff2a2a2c),
        ),
        itemBuilder: (context, index) {
          return _buildLifeItem(index);
        },
      ),
    );
  }

  Widget _buildLifeItem(int index) {
    return Container(
      color: const Color(0xff212123),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 카테고리 태그
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xff2a2a2c),
              borderRadius: BorderRadius.circular(4),
            ),
            child: AppFont(
              _getCategory(index),
              size: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // 내용
          AppFont(
            _getContent(index),
            size: 16,
            height: 1.4,
          ),
          const SizedBox(height: 12),
          // 하단 정보 (작성자/시간 + 좋아요/댓글)
          Row(
            children: [
              const AppFont('아라동 · 3시간 전', size: 12, color: Colors.grey),
              const Spacer(),
              const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
              const SizedBox(width: 4),
              const AppFont('공감', size: 13, color: Colors.grey),
              const SizedBox(width: 4),
              const AppFont('3', size: 13, color: Colors.white),
              const SizedBox(width: 12),
              const Icon(Icons.comment_outlined, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              const AppFont('댓글', size: 13, color: Colors.grey),
              const SizedBox(width: 4),
              const AppFont('5', size: 13, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  String _getCategory(int index) {
    final categories = ['우리동네질문', '일상', '동네맛집', '분실/실종 센터', '동네소식'];
    return categories[index % categories.length];
  }

  String _getContent(int index) {
    final contents = [
      '아라동에 맛있는 떡볶이집 추천해주세요!',
      '오늘 날씨가 너무 좋네요. 산책하기 딱 좋은 날씨입니다.',
      '강아지를 찾습니다. 하얀색 말티즈이고 파란 목줄을 하고 있어요 ㅠㅠ',
      '새로 오픈한 베이커리 가보셨나요? 소금빵이 진짜 맛있더라고요.',
      '주말에 같이 배드민턴 치실 분 계신가요? 초보도 환영합니다!',
    ];
    return contents[index % contents.length];
  }
}
