import 'package:flutter/material.dart';

class SearchOverlay extends StatefulWidget {
  const SearchOverlay({super.key});

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _recentSearches = [];

  void _onSearch() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _recentSearches.remove(text);
        _recentSearches.insert(0, text);
        _controller.clear();
      });
    }
  }

  void _removeSearch(String item) {
    setState(() {
      _recentSearches.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 60, left: 18, right: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: '검색어를 입력하세요',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff606a95),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _onSearch,
                    child: const Text('검색'),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('취소'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  '최근 검색어',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff606a95),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 2),
                  itemCount: _recentSearches.length,
                  itemBuilder: (context, index) {
                    final item = _recentSearches[index];
                    return ListTile(
                      title: Text(item),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Color(0xff606a95)),
                        onPressed: () => _removeSearch(item),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}