import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_assignment/db/db_cart.dart';
import 'package:mobile_assignment/db/db_fav.dart';
import 'package:mobile_assignment/db/db_user.dart';
import 'package:mobile_assignment/model/user_model.dart';
import 'package:mobile_assignment/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  UserModel? user;
  int id = 0;

  void loadData() async {
    var data = await DbUser.readUsers();
    if (data.isNotEmpty) {
      setState(() {
        user = data.last; // latest user
        id = user!.id;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xffEEEEEE),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          _buildProfile(),
          SizedBox(height: 60),
          _buildBody(),
          Spacer(),
          _buildButtonLogout(),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Bounceable(
            onTap: () {
              Navigator.pushNamed(context, AppRoute.favorite);
            },
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  size: 30,
                  color: Color(0xff5A9B73),
                ),
                SizedBox(width: 20),
                Text(
                  "Favorites",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Color(0xff5A9B73),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(thickness: 2),
          SizedBox(height: 10),
          Bounceable(
            onTap: () async {
              await Navigator.pushNamed(
                context,
                AppRoute.accountSetting,
              ).then(
                (value) {
                  loadData();
                },
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                  color: Color(0xff5A9B73),
                ),
                SizedBox(width: 20),
                Text(
                  "Account Settings",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Color(0xff5A9B73),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(thickness: 2),
          SizedBox(height: 10),
          Bounceable(
            onTap: () {
              Navigator.pushNamed(context, AppRoute.support);
            },
            child: Row(
              children: [
                Icon(
                  Icons.contact_support_rounded,
                  size: 30,
                  color: Color(0xff5A9B73),
                ),
                SizedBox(width: 20),
                Text(
                  "Support us",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Color(0xff5A9B73),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(thickness: 2),
          SizedBox(height: 10),
          Bounceable(
            onTap: () {
              Navigator.pushNamed(context, AppRoute.aboutus);
            },
            child: Row(
              children: [
                Icon(
                  Icons.info_rounded,
                  size: 30,
                  color: Color(0xff5A9B73),
                ),
                SizedBox(width: 20),
                Text(
                  "About",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Color(0xff5A9B73),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(thickness: 2),
          // SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildButtonLogout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Bounceable(
        onTap: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.noHeader,
            headerAnimationLoop: true,
            animType: AnimType.bottomSlide,
            title: 'Log out  of your account?',
            // desc: 'Dialog description here...',
            buttonsTextStyle: TextStyle(color: Colors.black),
            // showCloseIcon: true,
            btnCancelText: "cancel",
            btnCancelColor: Color(0xffDCDCDC),
            btnOkText: "Log out",
            btnOkColor: Colors.redAccent,
            btnOkOnPress: () async {
              await DbUser.deleteUser(id);
              await DbFavorite.deleteAllFav();
              await DbCart.deleteAllCart();
            
              var pref = await SharedPreferences.getInstance();
              pref.remove("isLogin");

              Navigator.pushReplacementNamed(context, AppRoute.signin);
            },
            btnCancelOnPress: () {},
          ).show();
        },
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xffDCDCDC),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Log out",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfile() {
    if (user == null) {
      return SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: Colors.grey[400],
            child: user!.profile.isEmpty
                ? Center(
                    child: Text(
                      "${user!.firstName.isNotEmpty ? user!.firstName[0] : ''}${user!.lastName.isNotEmpty ? user!.lastName[0] : ''}"
                          .toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.175,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ClipOval(
                    child: Image.file(
                      File(user!.profile),
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${user!.firstName} ${user!.lastName}",
                style: TextStyle(
                  color: Color(0xff5A9B73),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 10),
              Bounceable(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.accountSetting)
                      .then((_) => loadData());
                },
                child: Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                      color: Color(0xffDCDCDC),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            user!.email,
            style: TextStyle(
              color: Colors.black.withOpacity(0.45),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
