import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final List<Map<String, dynamic>> allItems = [
  // 자동차
  {
    "title": "중고 SUV 차량",
    "price": "₩8,500,000",
    "image": "assets/image/car1.jpg",
    "category": "자동차",
  },
  {
    "title": "전기 스쿠터",
    "price": "₩1,200,000",
    "image": "assets/image/car2.jpg",
    "category": "자동차",
  },
  {
    "title": "자동차 타이어 4개 세트",
    "price": "₩320,000",
    "image": "assets/image/car3.jpg",
    "category": "자동차",
  },

  // 식품/음식
  {
    "title": "수제 쿠키 세트",
    "price": "₩12,000",
    "image": "assets/image/food1.jpg",
    "category": "식품/음식",
  },
  {
    "title": "유기농 과일 박스",
    "price": "₩19,000",
    "image": "assets/image/food2.jpg",
    "category": "식품/음식",
  },
  {
    "title": "핸드드립 커피 세트",
    "price": "₩25,000",
    "image": "assets/image/item4.jpg",
    "category": "식품/음식",
  },

  // 패션/의류
  {
    "title": "니트 가디건",
    "price": "₩25,000",
    "image": "assets/image/fashion1.jpg",
    "category": "패션/의류",
  },
  {
    "title": "슬림 청바지",
    "price": "₩30,000",
    "image": "assets/image/fashion2.jpg",
    "category": "패션/의류",
  },
  {
    "title": "가죽 숄더백",
    "price": "₩58,000",
    "image": "assets/image/fashion3.jpg",
    "category": "패션/의류",
  },

  // 미용/뷰티
  {
    "title": "립스틱 세트",
    "price": "₩18,000",
    "image": "assets/image/beauty2.jpg",
    "category": "미용/뷰티",
  },
  {
    "title": "스킨케어 풀세트",
    "price": "₩45,000",
    "image": "assets/image/beauty2.jpg",
    "category": "미용/뷰티",
  },
  {
    "title": "향수 디퓨저",
    "price": "₩20,000",
    "image": "assets/image/beauty3.jpg",
    "category": "미용/뷰티",
  },

  // 인테리어
  {
    "title": "빈티지 테이블",
    "price": "₩45,000",
    "image": "assets/image/housedesign1.jpg",
    "category": "인테리어",
  },
  {
    "title": "LED 플로어 램프",
    "price": "₩27,000",
    "image": "assets/image/housedesign2.jpg",
    "category": "인테리어",
  },
  {
    "title": "수납 선반",
    "price": "₩22,000",
    "image": "assets/image/housedesign3.jpg",
    "category": "인테리어",
  },

  // 취미/예술
  {
    "title": "기타 연주 입문서",
    "price": "₩15,000",
    "image": "assets/image/habit1.jpg",
    "category": "취미/예술",
  },
  {
    "title": "수채화 도구 세트",
    "price": "₩18,000",
    "image": "assets/image/habit2.jpg",
    "category": "취미/예술",
  },
  {
    "title": "DIY 목공 키트",
    "price": "₩33,000",
    "image": "assets/image/habit3.jpg",
    "category": "취미/예술",
  },
];