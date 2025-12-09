import 'package:bamtol/src/common/components/app_font.dart';
import 'package:flutter/material.dart';

class MyBamtolPage extends StatelessWidget {
  const MyBamtolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212123),
      appBar: AppBar(
        title: const AppFont('나의 밤톨', size: 18, fontWeight: FontWeight.bold),
        backgroundColor: const Color(0xff212123),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 프로필 헤더
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[800],
                        child: const Icon(Icons.person, size: 30, color: Colors.grey),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, size: 12, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         const AppFont('Seho', size: 18, fontWeight: FontWeight.bold),
                         const SizedBox(height: 4),
                         AppFont('#123456', size: 13, color: Colors.grey[400]),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const AppFont('프로필 보기', size: 12),
                  ),
                ],
              ),
            ),
            
            // 밤톨페이 카드
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16),
             child: Container(
               padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(
                 color: const Color(0xff2a2a2c),
                 borderRadius: BorderRadius.circular(8),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Container(
                     padding: const EdgeInsets.all(8),
                     decoration: const BoxDecoration(
                       color: Colors.orange,
                       shape: BoxShape.circle,
                     ),
                     child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 20),
                   ),
                   const SizedBox(width: 12),
                   const Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       AppFont('밤톨페이', size: 13),
                       SizedBox(height: 4),
                       AppFont('0원', size: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                     ],
                   ),
                   const Spacer(),
                   const Icon(Icons.chevron_right, color: Colors.grey),
                 ],
               ),
             ),
           ),
           
           const SizedBox(height: 24),
           
           // 메뉴 리스트
           Column(
             children: [
               _buildMenuItem(Icons.list_alt, '판매내역'),
               _buildMenuItem(Icons.shopping_bag_outlined, '구매내역'),
               _buildMenuItem(Icons.favorite_border, '관심목록'),
               _buildMenuItem(Icons.book_outlined, '밤톨가계부'),
               const Divider(color: Color(0xff2a2a2c), thickness: 8),
               _buildMenuItem(Icons.location_on_outlined, '내 동네 설정'),
               _buildMenuItem(Icons.gps_fixed, '동네 인증하기'),
               _buildMenuItem(Icons.label_outline, '키워드 알림'),
             ],
           ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: AppFont(title, size: 16),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}
