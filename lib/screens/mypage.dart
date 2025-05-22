import 'package:flutter/material.dart';
import 'package:usedmarket/screens/favorite_page.dart';
import 'package:usedmarket/screens/home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'favorite_page.dart'; // 관심상품 페이지 import

class MyPageScreen extends StatefulWidget {
  final List<String> selectedInterests;
  const MyPageScreen({super.key, required this.selectedInterests});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(selectedInterests: widget.selectedInterests)),
                );
              },
              icon: SvgPicture.asset(
                'assets/image/home.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? Colors.black : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pushReplacementNamed(
                  context,
                  '/go',
                  arguments: widget.selectedInterests);
              },
              icon: SvgPicture.asset(
                'assets/image/menuheart.svg',
                width: 24,
                height: 24,

              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pushNamed(
                  context,
                  '/mypage',
                  arguments: widget.selectedInterests,
                );
              },
              icon: SvgPicture.asset(
                'assets/image/user.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? Colors.black : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("MY PAGE", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(radius: 40, backgroundColor: Colors.white),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("닉네임", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("123456789@gmail.com", style: TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              ),
              Divider(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _iconButton(Icons.favorite_border, "관심상품"),
                  _iconButton(Icons.receipt_long, "거래내역"),
                  _iconButton(Icons.chat_bubble_outline, "문의"),
                ],
              ),
              Divider(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(Icons.bookmark_border),
                    SizedBox(width: 8),
                    Text("최근 본 상품", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (_) => _productBox()),
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("도움말", style: TextStyle(color: Colors.grey)),
                    Text("공지사항"),
                    Text("앱 버전"),
                    Text("서비스 이용 약관"),
                    Text("개인정보 처리방침"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 28),
        SizedBox(height: 6),
        Text(label),
      ],
    );
  }

  Widget _productBox() {
    return Container(
      width: 80,
      height: 100,
      color: Colors.grey[300],
    );
  }
}
