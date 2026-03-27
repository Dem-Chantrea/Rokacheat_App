import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_assignment/constants/app_image.dart';
import 'package:mobile_assignment/db/db_user.dart';
import 'package:mobile_assignment/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ctrlEmail = TextEditingController();
  final ctrlPwd = TextEditingController();
  final ctrlFn = TextEditingController();
  final ctrlLn = TextEditingController();
  bool isHidePwd = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    ctrlEmail.dispose();
    ctrlPwd.dispose();
    ctrlFn.dispose();
    ctrlLn.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await DbUser.insertUser(
          firstName: ctrlFn.text.trim(),
          lastName: ctrlLn.text.trim(),
          email: ctrlEmail.text.trim(),
          profile: "",
          gender: "",
          dob: "",
          address: "",
        );

        var pref = await SharedPreferences.getInstance();
        await pref.setBool("isLogin", true);

        Navigator.pushReplacementNamed(
          context,
          AppRoute.bottomNav,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to register: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              _buildRegisterTitle(),
              SizedBox(height: 30),
              _buildForm(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              _buildRegisterButton(),
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
        SizedBox(width: double.infinity, height: 180),
        Positioned(
          top: 60,
          left: 20,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(100),
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
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

  Widget _buildRegisterTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            "Register",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xff5A9B73),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Create your account",
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
          _buildTextFormField(
            text: "First name",
            controller: ctrlFn,
            hintText: "Enter your first name",
            prefixIcon: AppImage.user,
            validator: (value) => value == null || value.trim().isEmpty
                ? "Please enter your first name"
                : null,
          ),
          SizedBox(height: 20),
          _buildTextFormField(
            text: "Last name",
            controller: ctrlLn,
            hintText: "Enter your last name",
            prefixIcon: AppImage.user,
            validator: (value) => value == null || value.trim().isEmpty
                ? "Please enter your last name"
                : null,
          ),
          SizedBox(height: 20),
          _buildTextFormField(
            text: "Email",
            controller: ctrlEmail,
            hintText: "Enter your email",
            prefixIcon: AppImage.email,
            validator: (value) {
              if (value == null || value.trim().isEmpty)
                return "Please enter your email";
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                return "Invalid email";
              return null;
            },
          ),
          SizedBox(height: 20),
          _buildTextFormField(
            text: "Password",
            controller: ctrlPwd,
            hintText: "Enter your password",
            prefixIcon: AppImage.lock,
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Please enter your password";
              if (value.length < 8)
                return "Password must be at least 8 characters";
              return null;
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                prefixIcon,
                color: Colors.black,
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

  Widget _buildRegisterButton() {
    return Column(
      children: [
        Bounceable(
          onTap: _registerUser,
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
                "Register",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.8),
                fontSize: 16,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoute.login),
              child: Text(
                "Login",
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
        ),
      ],
    );
  }
}
