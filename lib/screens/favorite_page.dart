import 'package:flutter/material.dart';
import 'package:usedmarket/screens/home_screen.dart';

class FavoritePage extends StatefulWidget {
  final List<String> selectedInterests;
  const FavoritePage({super.key, required this.selectedInterests});
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, dynamic>> favoriteItems = [
    {"name": "상품명1", "seller": "판매처명1", "price": "₩10,000", "checked": false},
    {"name": "상품명2", "seller": "판매처명2", "price": "₩20,000", "checked": false},
    {"name": "상품명3", "seller": "판매처명3", "price": "₩30,000", "checked": false},
  ];

  bool selectAll = false;

  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var item in favoriteItems) {
        item["checked"] = selectAll;
      }
    });
  }

  void deleteSelected() {
    setState(() {
      favoriteItems.removeWhere((item) => item["checked"] == true);
      selectAll = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/go', arguments: widget.selectedInterests);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("관심 상품 등록", style: TextStyle(fontFamily: 'Albert')),
          actions: [
            TextButton(
              onPressed: deleteSelected,
              child: Text("선택 삭제", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: selectAll,
                    onChanged: toggleSelectAll,
                  ),
                  Text("전체선택"),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  var item = favoriteItems[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            Checkbox(
                              value: item["checked"],
                              onChanged: (value) {
                                setState(() {
                                  item["checked"] = value ?? false;
                                  selectAll = favoriteItems.every((e) => e["checked"]);
                                });
                              },
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[300],
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item["seller"], style: TextStyle(fontSize: 14)),
                                  Text(item["name"], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Text(item["price"]),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}