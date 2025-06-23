import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final String currentUserId;
  final String itemTitle;
  final String itemPrice;
  final String itemImage;

  const ChatScreen({
    super.key,
    required this.chatRoomId,
    required this.currentUserId,
    required this.itemTitle,
    required this.itemPrice,
    required this.itemImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  void sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final message = {
      'text': text,
      'senderId': widget.currentUserId,
      'timestamp': FieldValue.serverTimestamp(),
      'read': false,
    };

    final chatDoc = FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatRoomId);

    await chatDoc.set({
      'createdAt': FieldValue.serverTimestamp(),
      'lastMessage': text,
      'lastTimestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await chatDoc.collection('messages').add(message);

    await chatDoc.update({
      'lastMessage': text,
      'lastTimestamp': FieldValue.serverTimestamp(),
    });

    _controller.clear();
  }

  void markMessagesAsRead(QuerySnapshot snapshot) {
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final isFromOther = data['senderId'] != widget.currentUserId;
      final isUnread = data['read'] == false;

      if (isFromOther && isUnread) {
        doc.reference.update({'read': true});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅'),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF606A95),
      ),
      body: Column(
        children: [
          // 상단 상품 정보 박스
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: const Color(0xFFF0F0F0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    widget.itemImage, // ✅ 로컬 이미지 경로 그대로 사용
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${widget.itemPrice}원',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 메시지 영역
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.chatRoomId)
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;
                markMessagesAsRead(snapshot.data!);

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final doc = messages[messages.length - 1 - index];
                    final data = doc.data() as Map<String, dynamic>;
                    final text = data['text'] ?? '';
                    final senderId = data['senderId'];
                    final isMe = senderId == widget.currentUserId;
                    final isRead = data['read'] == true;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(10),
                            constraints: const BoxConstraints(maxWidth: 250),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.orange[100] : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(text, style: const TextStyle(fontSize: 16)),
                          ),
                          if (isMe)
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                isRead ? '읽음' : '전송됨',
                                style: const TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // 입력창
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '메시지를 입력하세요',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: const Color(0xFF606A95),
                  onPressed: sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}