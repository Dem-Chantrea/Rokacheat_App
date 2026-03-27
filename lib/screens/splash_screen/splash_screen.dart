import 'package:flutter/material.dart';
import 'package:mobile_assignment/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  void checkLogin()async{
    var pref = await SharedPreferences.getInstance();
    var isLogin = pref.getBool("isLogin") ?? false;
    
    if(isLogin){
      Navigator.pushReplacementNamed(context, AppRoute.bottomNav);
    } else{
      Navigator.pushReplacementNamed(context, AppRoute.signin);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 3),() {
        // ignore: use_build_context_synchronously
        checkLogin();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/Logo.png"),
      ),
    );
  }
}