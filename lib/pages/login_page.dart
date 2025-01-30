import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();

}

class _LogInPageState extends State<LogInPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFFFFBEA),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 90),
                  Image.asset(
                    'assets/shelfmate_logo_yellowBlack.png',
                  ),
                  const SizedBox(height: 40),
                  const Padding(
                    padding: EdgeInsets.only(right: 170),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'To access more than 3600 books',
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: _emailController,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 190),
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if(_emailController.text.isNotEmpty && _passwordController.text.length > 6) {
                        login();
                      }
                      else {
                        debugPrint("Email is empty or password is invalid");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC21A),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 140),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black,
                      elevation: 10,
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/Graduation.png',
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: "Don't have an account? ",
                        ),
                        TextSpan(
                          text: 'Create Account',
                          style: const TextStyle(
                            color: Color(0xFFFF2257),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    final auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if(auth != null) {
      debugPrint("User logged in");
      Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
  }

}
