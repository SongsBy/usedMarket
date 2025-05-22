import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/item_box.dart';
import 'trend_foryou.dart';
import 'package:usedmarket/screens/search.dart';
import 'package:usedmarket/data/all_item.dart';

class HomeScreen extends StatefulWidget {
  final List<String> selectedInterests;
  const HomeScreen({Key? key, required this.selectedInterests}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedTab = 'FOR YOU';
  int _selectedIndex = 0;

  List<Map<String, dynamic>> getFilteredItems() {
    return allItems.where((item) => widget.selectedInterests.contains(item['category'])).toList();
  }

  void _showSearchDialog() {
    showGeneralDialog(
      context: context,
      barrierLabel: "검색",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(anim1),
          child: const SearchOverlay(),
        );
      },
    );
  }

  Widget buildForYouList(BuildContext context, List<String> selectedInterests) {
    final filteredItems = allItems.where((item) => selectedInterests.contains(item['category'])).toList();

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: filteredItems.map((item) {
        return ItemBox(
          item['image'],
          item['price'],
          item['title'],
          onTap: () => navigateToDetail(context, item['image'], item['price'], item['title']),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.transparent,
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
            onPressed: _showSearchDialog,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, size: 20, color: Colors.black),
            onPressed: () {},
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
              child: selectedTab == 'TREND' ? buildTrendList(context) :
              buildForYouList(context , widget.selectedInterests),
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
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
                Navigator.pushNamed(
                  context,
                  '/favorite',
                  arguments: widget.selectedInterests,
                );
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
    );
  }
}