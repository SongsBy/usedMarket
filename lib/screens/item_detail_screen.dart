import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/chat_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  final String imagePath;
  final String price;
  final String title;

  const ItemDetailScreen({
    super.key,
    required this.imagePath,
    required this.price,
    required this.title,
  });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 260,
            width: double.infinity,
            color: const Color(0xFFF0F0F0),
            child: Image.asset(
              widget.imagePath,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(radius: 16, backgroundColor: Colors.black12),
                SizedBox(width: 8),
                Text('빵돌이', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 4),
                Icon(Icons.verified, color: Color(0xFF4D6DFF), size: 16),
              ],
            ),
          ),
          const Divider(thickness: 1, height: 1, color: Color(0xFFE0E0E0)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Mulish',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '식품류 · 1시간 전',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              '딱 한입 먹은 새 빵 입니다. 한 입 먹고 팔이 아니어서 팝니다.',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
              child: SvgPicture.asset(
                isLiked
                    ? 'assets/image/red.svg'
                    : 'assets/image/heart.svg',
                width: 18,
                height: 18,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              widget.price,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Mulish',
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF606A95),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              ),
              onPressed: () {
                final productId = widget.title.replaceAll(' ', '_'); // 공백 제거한 상품 ID 대체
                const currentUserId = 'test_user'; // 이건 실제 로그인 정보로 대체할 것
                final chatRoomId = '${productId}_$currentUserId';

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      chatRoomId: chatRoomId,
                      currentUserId: currentUserId,
                      itemTitle: widget.title,
                      itemPrice: widget.price,
                      itemImage: widget.imagePath,
                    ),
                  ),
                );
              },
              child: const Text('채팅하기', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}