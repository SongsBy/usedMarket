import 'package:flutter/material.dart';
import '../widgets/item_box.dart';
import '../screens/item_detail_screen.dart';

Widget buildTrendList(BuildContext context) {
  return Wrap(
    spacing: 16,
    runSpacing: 16,
    children: [
      ItemBox('assets/image/item1.png', '25,000', '보조 배터리',
          onTap: () => _navigateToDetail(context, 'assets/image/item1.png', '25,000원', '트렌드 상품1')),
      ItemBox('assets/image/item2.png', '30,000', '디지털 체중계',
          onTap: () => _navigateToDetail(context, 'assets/image/item2.png', '30,000원', '트렌드 상품2')),
      ItemBox('assets/image/item3.png', '45,000', '무선 키보드',
          onTap: () => _navigateToDetail(context, 'assets/image/item3.png', '45,000원', '트렌드 상품3')),
      ItemBox('assets/image/item4.png', '50,000', '핸드 드합세트',
          onTap: () => _navigateToDetail(context, 'assets/image/item4.png', '50,000원', '트렌드 상품4')),
      ItemBox('assets/image/item2.png', '30,000', 'LED스텐드',
          onTap: () => _navigateToDetail(context, 'assets/image/item2.png', '30,000원', '트렌드 상품2')),
      ItemBox('assets/image/item3.png', '75,000', '미니 공기청정기',
          onTap: () => _navigateToDetail(context, 'assets/image/item3.png', '45,000원', '트렌드 상품3')),
      ItemBox('assets/image/item4.png', '50,000', '캠핑용 공기청정기',
          onTap: () => _navigateToDetail(context, 'assets/image/item4.png', '50,000원', '트렌드 상품4')),
      ItemBox('assets/image/item2.png', '30,000', '닌텐도 랜덤 칩',
          onTap: () => _navigateToDetail(context, 'assets/image/item2.png', '30,000원', '트렌드 상품2')),
      ItemBox('assets/image/item3.png', '45,000', '정품 실리콘케이스',
          onTap: () => _navigateToDetail(context, 'assets/image/item3.png', '45,000원', '트렌드 상품3')),
      ItemBox('assets/image/item4.png', '50,000', '애플펜촉',
          onTap: () => _navigateToDetail(context, 'assets/image/item4.png', '50,000원', '트렌드 상품4')),
      ItemBox('assets/image/item4.png', '50,000', '스타벅스 굿즈',
          onTap: () => _navigateToDetail(context, 'assets/image/item4.png', '50,000원', '트렌드 상품4')),
    ],
  );
}

Widget buildForYouList(BuildContext context) {
  return Wrap(
    spacing: 16,
    runSpacing: 16,
    children: [
      ItemBox('assets/image/item5.png', '10,000', '추천 상품1',
          onTap: () => _navigateToDetail(context, 'assets/image/item5.png', '10,000원', '추천 상품1')),
      ItemBox('assets/image/item6.png', '15,000', '추천 상품2',
          onTap: () => _navigateToDetail(context, 'assets/image/item6.png', '15,000원', '추천 상품2')),
      ItemBox('assets/image/item1.png', '22,000', '추천 상품3',
          onTap: () => _navigateToDetail(context, 'assets/image/item1.png', '22,000원', '추천 상품3')),
      ItemBox('assets/image/item2.png', '18,000', '추천 상품4',
          onTap: () => _navigateToDetail(context, 'assets/image/item2.png', '18,000원', '추천 상품4')),
      ItemBox('assets/image/item5.png', '10,000', '추천 상품1',
          onTap: () => _navigateToDetail(context, 'assets/image/item5.png', '10,000원', '추천 상품1')),
      ItemBox('assets/image/item6.png', '15,000', '추천 상품2',
          onTap: () => _navigateToDetail(context, 'assets/image/item6.png', '15,000원', '추천 상품2')),
      ItemBox('assets/image/item1.png', '22,000', '추천 상품3',
          onTap: () => _navigateToDetail(context, 'assets/image/item1.png', '22,000원', '추천 상품3')),
      ItemBox('assets/image/item5.png', '10,000', '추천 상품1',
          onTap: () => _navigateToDetail(context, 'assets/image/item5.png', '10,000원', '추천 상품1')),
      ItemBox('assets/image/item6.png', '15,000', '추천 상품2',
          onTap: () => _navigateToDetail(context, 'assets/image/item6.png', '15,000원', '추천 상품2')),
      ItemBox('assets/image/item6.png', '15,000', '추천 상품2',
          onTap: () => _navigateToDetail(context, 'assets/image/item6.png', '15,000원', '추천 상품2')),
    ],
  );
}

void _navigateToDetail(BuildContext context, String imagePath, String price, String title) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ItemDetailScreen(
        imagePath: imagePath,
        price: price,
        title: title,
      ),
    ),
  );
}