import 'package:flutter/material.dart';
import 'package:usedmarket/screens/Login.dart';
import 'package:usedmarket/screens/Signup.dart'; // 이거 추가!
import 'package:usedmarket/screens/favorite_page.dart';
import 'package:usedmarket/screens/interest_select_page.dart';
import 'package:usedmarket/screens/mypage.dart';
import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '중고마켓',
      debugShowCheckedModeBanner: false,
      home: const Login(),
      routes: {
        '/insert':(context) => const InterestSelectionPage(),
        '/go': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as List<String>? ?? [];
          return HomeScreen(selectedInterests: args);
        },
        '/favorite': (context) {
          final selected = ModalRoute.of(context)!.settings.arguments as List<String>? ?? [];
          return FavoritePage(selectedInterests: selected);
        },
        '/mypage': (context){
          final selected = ModalRoute.of(context)!.settings.arguments as List<String>? ?? [];
          return MyPageScreen(selectedInterests: selected);
        },
        '/signup': (context) => const Signup(),
        '/home': (context) => const HomeScreen(selectedInterests: []),
      },

    );
  }
}