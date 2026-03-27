import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_assignment/constants/app_image.dart';
import 'package:mobile_assignment/db/db_user.dart';
import 'package:mobile_assignment/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var ctrlEmail = TextEditingController();
  var ctrlpwd = TextEditingController();

  bool isHidePwd = true;
  final _formKey = GlobalKey<FormState>();

  void login() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", true);

    Navigator.pushReplacementNamed(
      context,
      AppRoute.bottomNav,
    );
  }

  @override
  void dispose() {
    ctrlEmail.dispose();
    ctrlpwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: 20),
              _buildWelcome(),
              SizedBox(height: 30),
              _buildForm(),
              // Spacer(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              _buildLoginButton(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Image.asset(AppImage.login),
        Positioned(
          top: 60,
          left: 20,
          child: Container(
            height: 40,
            width: 40,
            // padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
                color: Colors.white.withAlpha(100),
                // borderRadius: BorderRadius.circular(100),
                shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcome() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Text(
            "Welcome Back!",
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xff5A9B73)),
          ),
          SizedBox(height: 10),
          Text(
            "Login to your account",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          _buildTextFormField(
            text: "Email",
            controller: ctrlEmail,
            hintText: "Enter your email",
            prefixIcon: AppImage.email,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please enter your email";
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return "Invalid email";
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          _buildTextFormField(
            text: "Password",
            controller: ctrlpwd,
            hintText: "Enter your password",
            prefixIcon: AppImage.lock,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              } else if (value.length < 8) {
                return "Password must be at least 8 characters";
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required String hintText,
    required String text,
    required String prefixIcon,
    required TextEditingController controller,
    required FormFieldValidator<String> validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: text == "Password" ? isHidePwd : false,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 20, right: 5),
              child: Image.asset(
                color: Colors.black,
                prefixIcon,
                width: 20,
                height: 20,
              ),
            ),
            suffixIcon: text == "Password"
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isHidePwd = !isHidePwd;
                      });
                    },
                    icon: Icon(
                      isHidePwd
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD9D9D9), width: 1.0),
              borderRadius: BorderRadius.circular(100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD9D9D9), width: 3.0),
              borderRadius: BorderRadius.circular(100),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.circular(100),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Column(
      children: [
        Bounceable(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              await DbUser.insertUser(
                firstName: "",
                lastName: "",
                email: ctrlEmail.text,
                profile: "",
                gender: "",
                dob: "",
                address: "",
              );
              Navigator.pushReplacementNamed(
                context,
                AppRoute.bottomNav,
                arguments: {
                  "firstName": "",
                  "lastName": "",
                  "email": ctrlEmail.text,
                },
              );
            }
            login();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xff5A9B73),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have account?",
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.8),
                fontSize: 16,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.register);
              },
              child: Text(
                "Register",
                style: TextStyle(
                  color: Color(0xff5A9B73),
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xff5A9B73),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
