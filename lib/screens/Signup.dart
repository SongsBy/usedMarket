import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nicknameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> handleEmailSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();
    final nickname = _nicknameController.text.trim();

    if (email.isEmpty || password.isEmpty || nickname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 항목을 입력해주세요.')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
      );
      return;
    }

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'nickname': nickname,
        'createdAt': FieldValue.serverTimestamp(),
        'signupMethod': 'email',
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Login()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입 실패: $e')),
      );
    }
  }

  Future<void> handleGoogleSignUp() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) return;

      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final doc = await docRef.get();

      if (!doc.exists) {
        await docRef.set({
          'uid': user.uid,
          'email': user.email,
          'nickname': user.displayName ?? '',
          'createdAt': FieldValue.serverTimestamp(),
          'signupMethod': 'google',
        });
      }

      Navigator.pushReplacementNamed(context, '/insert');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google 회원가입 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            SvgPicture.asset('assets/image/activity.svg', height: 30),
            const SizedBox(height: 16),
            const Text('Create New Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('REVOO에 오신 것을 환영합니다!', style: TextStyle(fontSize: 16, color: Colors.black87)),
            const SizedBox(height: 40),
            buildInputField(_nicknameController, 'Nickname', Icons.person),
            const SizedBox(height: 16),
            buildInputField(_emailController, 'Email', Icons.email),
            const SizedBox(height: 16),
            buildPasswordField(_passwordController, 'Password', _isPasswordVisible, () => setState(() => _isPasswordVisible = !_isPasswordVisible)),
            const SizedBox(height: 16),
            buildPasswordField(_confirmPasswordController, 'Password Again', _isConfirmPasswordVisible, () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible)),
            const SizedBox(height: 40),
            buildSignUpButton(),
            const SizedBox(height: 16),
            buildGoogleSignUpButton(),
            const SizedBox(height: 24),
            buildLoginPrompt(),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String hint, IconData icon) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            icon: Icon(icon, color: Colors.grey[500]),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField(TextEditingController controller, String hint, bool visible, VoidCallback toggle) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: controller,
          obscureText: !visible,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            icon: Icon(Icons.lock, color: Colors.grey[500]),
            suffixIcon: IconButton(
              icon: Icon(visible ? Icons.visibility : Icons.visibility_off, color: Colors.grey[500]),
              onPressed: toggle,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: handleEmailSignUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF606A95),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text('Sign up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget buildGoogleSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFEEEEEE),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        icon: Image.asset('assets/image/google_logo.png', height: 24),
        label: const Text('Google 계정으로 가입하기', style: TextStyle(fontSize: 16, color: Colors.black87)),
        onPressed: handleGoogleSignUp,
      ),
    );
  }

  Widget buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('이미 계정이 있으신가요?', style: TextStyle(color: Colors.black87)),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('로그인', style: TextStyle(color: Color(0xFF606A95), fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}