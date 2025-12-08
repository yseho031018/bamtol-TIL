import 'package:bamtol/src/common/components/app_font.dart';
import 'package:bamtol/src/search/page/search_result_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Get.to(() => SearchResultPage(searchQuery: query));
    }
  }

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
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xff2a2a2c),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: const InputDecoration(
              hintText: '검색어를 입력해주세요',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
            ),
            onSubmitted: (_) => _performSearch(),
          ),
        ),
        titleSpacing: 0,
        actions: [
          GestureDetector(
            onTap: _performSearch,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: const AppFont(
                '검색',
                size: 16,
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppFont(
              '최근 검색어',
              size: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildRecentSearchChip('맥북'),
                _buildRecentSearchChip('아이폰'),
                _buildRecentSearchChip('자전거'),
                _buildRecentSearchChip('책상'),
              ],
            ),
            const SizedBox(height: 32),
            const AppFont(
              '인기 검색어',
              size: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 16),
            ...List.generate(5, (index) {
              final popularKeywords = ['아이폰 15', '맥북 프로', '에어팟', '갤럭시', '닌텐도 스위치'];
              return GestureDetector(
                onTap: () {
                  _searchController.text = popularKeywords[index];
                  _performSearch();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      AppFont(
                        '${index + 1}',
                        size: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 16),
                      AppFont(
                        popularKeywords[index],
                        size: 14,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearchChip(String text) {
    return GestureDetector(
      onTap: () {
        _searchController.text = text;
        _performSearch();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xff2a2a2c),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppFont(text, size: 14),
            const SizedBox(width: 8),
            const Icon(Icons.close, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
