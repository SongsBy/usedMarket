import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '1064881753065-i6dt6at4bk3c8ha9rfql62f7qv4dcagt.apps.googleusercontent.com',
  );

  Future<void> handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      print('AccessToken: ${googleAuth.accessToken}');
      print('IDToken: ${googleAuth.idToken}');

      // ✅ 구글 로그인 성공 시 홈 화면으로 이동
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      print('Google 로그인 오류: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/image/activity.svg',
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'RE-Value',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '필요 없는 것에서, 누군가의 필요로',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 80),

                  // Email
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email_outlined, color: Colors.grey),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock_outlined, color: Colors.grey),
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF606A95),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      onPressed: () {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          Navigator.pushReplacementNamed(context, '/insert');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('이메일과 비밀번호를 입력하세요'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Google Login
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFEEEEEE),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      icon: Image.asset(
                        'assets/image/google_logo.png',
                        height: 24,
                        width: 24,
                      ),
                      label: const Text(
                        'Login with Google',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: handleGoogleSignIn,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('처음이신가요?', style: TextStyle(color: Colors.black87)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          '회원가입',
                          style: TextStyle(
                            color: Color(0xFF606A95),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF606A95),
                            decorationThickness: 2.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}