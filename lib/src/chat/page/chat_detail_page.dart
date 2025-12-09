import 'dart:typed_data';

import 'package:bamtol/src/common/components/app_font.dart';
import 'package:bamtol/src/home/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailPage extends StatefulWidget {
  final ProductModel product;

  const ChatDetailPage({super.key, required this.product});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = []; // 임시 메시지 리스트

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212123),
      appBar: AppBar(
        backgroundColor: const Color(0xff212123),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            AppFont(
              widget.product.sellerName,
              size: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(width: 6),
            const AppFont(
              '36.5℃',
              size: 13,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xff2a2a2c),
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          // 상품 정보 요약 배너
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xff2a2a2c)),
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildProductImage(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const AppFont(
                            '판매중',
                            size: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: AppFont(
                              widget.product.title,
                              size: 14,
                              color: Colors.grey[400],
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      AppFont(
                        widget.product.isFree
                            ? '나눔'
                            : '${_formatPrice(widget.product.price ?? 0)}원',
                        size: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 채팅 메시지 영역
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),

          // 입력창 영역
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xff212123),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.grey),
                    padding: EdgeInsets.zero,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xff2a2a2c),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: '메시지 보내기',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        onSubmitted: _sendMessage,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _sendMessage(_controller.text),
                    child: const Icon(Icons.send, color: Colors.orange),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(text);
      _controller.clear();
    });
  }

  Widget _buildMessageBubble(String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 4, right: 4),
            child: AppFont('오전 10:48', size: 10, color: Colors.grey),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 240),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12).copyWith(
                bottomRight: const Radius.circular(0),
              ),
            ),
            child: AppFont(
              message,
              color: Colors.white,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    if (widget.product.imageBytesList.isNotEmpty) {
      return Image.memory(
        widget.product.imageBytesList.first,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      );
    }
    if (widget.product.imageBytes != null) {
      return Image.memory(
        widget.product.imageBytes!,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      );
    }
    if (widget.product.imageUrls.isNotEmpty) {
      return Image.network(
        widget.product.imageUrls.first,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      );
    }
    if (widget.product.imageUrl != null) {
      return Image.network(
        widget.product.imageUrl!,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      );
    }
    return Container(
      width: 40,
      height: 40,
      color: Colors.grey[800],
      child: const Icon(Icons.image, size: 20, color: Colors.grey),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
