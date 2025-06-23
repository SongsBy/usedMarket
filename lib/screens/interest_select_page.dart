import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usedmarket/screens/home_screen.dart';

class InterestSelectionPage extends StatefulWidget {
  const InterestSelectionPage({super.key});

  @override
  State<InterestSelectionPage> createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage> {
  final List<String> interests = [
    '자동차',
    '식품/음식',
    '패션/의류',
    '미용/뷰티',
    '인테리어',
    '취미/예술'
  ];

  final Set<String> selectedInterests = {};

  Widget _buildInterestCard(String title, String imagePath) {
    final isSelected = selectedInterests.contains(title);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedInterests.remove(title);
          } else {
            selectedInterests.add(title);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xff606a95) : Colors.transparent,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isSelected ? const Color(0xff606a95) : Colors.grey,
                size: 28,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveInterestsToFirestore(List<String> interests) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'interests': interests,
      }, SetOptions(merge: true)); // ✅ 기존 nickname, email 유지
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePaths = [
      'assets/image/cars.jpg',
      'assets/image/foods.jpg',
      'assets/image/fashions.jpg',
      'assets/image/beautys.jpg',
      'assets/image/housedesigns.jpg',
      'assets/image/habits.jpg'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/image/activity.svg',
              height: 30,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            const Text(
              'Revoo',
              style: TextStyle(
                fontFamily: 'Albert',
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '관심있는 분야를 선택하시면\n취향에 맞는 상품을 추천해드려요',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 6),
            const Text(
              '여러개 선택하셔도 괜찮아요!',
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 88, 88, 88)),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 22),
            Expanded(
              child: GridView.builder(
                itemCount: interests.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  return _buildInterestCard(interests[index], imagePaths[index]);
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff606a95),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final interestsToSave = selectedInterests.toList();
                await _saveInterestsToFirestore(interestsToSave); // 🔥 관심사 저장
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(selectedInterests: interestsToSave),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  '내 취향에 맞는 상품 보러가기',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}