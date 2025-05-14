// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/item_box.dart';
import 'trend_foryou.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedTab = 'FOR YOU';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 16),
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/image/activity.svg',
            width: 24,
            height: 24,
          ),
        ),
        title: const Text(
          'Revoo',
          style: TextStyle(
            fontFamily: 'Albert',
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, size: 20, color: Colors.black),
            onPressed: () => debugPrint('Menu pressed'),
          ),
          IconButton(
            icon: const Icon(Icons.search, size: 20, color: Colors.black),
            onPressed: () => debugPrint('Search pressed'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, size: 20, color: Colors.black),
            onPressed: () => debugPrint('Notification pressed'),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => setState(() => selectedTab = 'TREND'),
                child: Column(
                  children: [
                    Text(
                      'TREND',
                      style: TextStyle(
                        fontFamily: 'Albert',
                        color: selectedTab == 'TREND' ? Colors.black : Colors.grey,
                      ),
                    ),
                    if (selectedTab == 'TREND')
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        height: 2,
                        width: 40,
                        color: Colors.black,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => setState(() => selectedTab = 'FOR YOU'),
                child: Column(
                  children: [
                    Text(
                      'FOR YOU',
                      style: TextStyle(
                        fontFamily: 'Albert',
                        color: selectedTab == 'FOR YOU' ? Colors.black : Colors.grey,
                      ),
                    ),
                    if (selectedTab == 'FOR YOU')
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        height: 2,
                        width: 60,
                        color: Colors.black,
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: selectedTab == 'TREND' ? buildTrendList(context) : buildForYouList(context),
            ),
          ),
        ],
      ),
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
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [

            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이'),
          ],

        ),
      ),
    );
  }
}
