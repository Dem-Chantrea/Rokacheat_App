import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/signin.png"),
          Positioned(
            top: 130,
            left: 20,
            child: Text(
              "The best app\nfor your\nrokcheat",
              style: TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            left: 20,
            right: 20,
            child: Bounceable(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffF8F8F8).withAlpha(350),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 110,
            left: 120,
            child: Bounceable(
              // scaleFactor: 0.5,
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                "Create an account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
