import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemBox extends StatefulWidget {
  final String imagePath;
  final String price;
  final String title;
  final VoidCallback? onTap;

  const ItemBox(
      this.imagePath,
      this.price,
      this.title, {
        this.onTap,
        super.key,
      });

  @override
  State<ItemBox> createState() => _ItemBoxState();
}

class _ItemBoxState extends State<ItemBox> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 160,
                height: 160,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  child: SvgPicture.asset(

                    isLiked
                        ? 'assets/image/red.svg'
                        : 'assets/image/heart.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            widget.price,
            style: const TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}