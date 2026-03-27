// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_assignment/constants/app_image.dart';
import 'package:mobile_assignment/db/db_user.dart';
import 'package:mobile_assignment/model/user_model.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  var gender = "male";
  String selectedDOB = "";
  String selectedProfile = "";
  var fnCtrl = TextEditingController();
  var lnCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  String selectedCity = "Phnom Penh";

  final List<String> cities = [
    "Phnom Penh",
    "Banteay Meanchey",
    "Battambang",
    "Kampong Cham",
    "Kampong Chhnang",
    "Kampong Speu",
    "Kampong Thom",
    "Kampot",
    "Kandal",
    "Kep",
    "Koh Kong",
    "Kratie",
    "Mondulkiri",
    "Oddar Meanchey",
    "Pailin",
    "Preah Sihanouk",
    "Preah Vihear",
    "Prey Veng",
    "Pursat",
    "Ratanakiri",
    "Siem Reap",
    "Stung Treng",
    "Svay Rieng",
    "Takeo",
    "Tboung Khmum",
  ];
  int userId = 0;

  bool isReadOnly = true;
  var userData = [];
  late UserModel user;
  void loadData() async {
    // Read all users from database
    var data = await DbUser.readUsers();

    if (data.isNotEmpty) {
      // Take the last user inserted
      user = data.last;

      setState(() {
        userId = user.id;
        fnCtrl.text = user.firstName;
        lnCtrl.text = user.lastName;
        emailCtrl.text = user.email;
        gender = user.gender.isNotEmpty ? user.gender : gender;
        selectedDOB = user.dob.isNotEmpty ? user.dob : selectedDOB;
        selectedCity = user.address.isNotEmpty ? user.address : selectedCity;
        selectedProfile = user.profile;
      });
    }
  }

  void chooseProfile(ImageSource source) async {
    var imagePicked = await ImagePicker().pickImage(source: source);

    setState(() {
      selectedProfile = imagePicked!.path;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    fnCtrl.dispose();
    lnCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            // _buildProfile(),
            SizedBox(height: 30),
            _buildFormField(
              hint: "First name",
              controller: fnCtrl,
              readOnly: isReadOnly,
            ),
            SizedBox(height: 20),
            _buildFormField(
              hint: "Last name",
              controller: lnCtrl,
              readOnly: isReadOnly,
            ),
            SizedBox(height: 20),
            _buildFormField(
              hint: "Email",
              suffixIcon: Icons.email_outlined,
              controller: emailCtrl,
              readOnly: isReadOnly,
            ),
            SizedBox(height: 20),
            _buildGender(),
            SizedBox(height: 20),
            _buildDobSelector(),
            SizedBox(height: 20),
            _buildAddress(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 260,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Image.asset(
              AppImage.signin,
              fit: BoxFit.cover,
            ),
          ),
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
                shape: BoxShape.circle,
              ),
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
          Positioned(
            top: 60,
            right: 20,
            child: Bounceable(
              onTap: () async {
                if (!isReadOnly) {
                  await DbUser.updateUser(
                    id: userId,
                    firstName: fnCtrl.text,
                    lastName: lnCtrl.text,
                    email: emailCtrl.text,
                    gender: gender,
                    dob: selectedDOB,
                    address: selectedCity,
                    profile: selectedProfile,
                  );
                }
                setState(() {
                  isReadOnly = !isReadOnly;
                });
                
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(100),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isReadOnly ? 'Edit' : 'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: _buildProfile(),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildProfile() {
  return Bounceable(
    onTap: isReadOnly
        ? null
        : () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Choose Options"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          chooseProfile(ImageSource.camera);
                        },
                        leading: Icon(Icons.camera_alt),
                        title: Text("Camera"),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          chooseProfile(ImageSource.gallery);
                        },
                        leading: Icon(Icons.photo_library_sharp),
                        title: Text("Gallery"),
                      ),
                    ],
                  ),
                  actionsPadding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  contentPadding: EdgeInsets.only(left: 20, right: 20),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                );
              },
            );
          },
    child: badges.Badge(
      badgeContent: Icon(
        Icons.add,
        color: Colors.white.withOpacity(isReadOnly ? 0.5 : 1.0),
        size: 16,
      ),
      position: badges.BadgePosition.bottomEnd(bottom: 10, end: 10),
      child: CircleAvatar(
        radius: 80,
        backgroundColor:
            Colors.grey.withOpacity(isReadOnly ? 0.8 : 1.0), 
        child: (selectedProfile.isEmpty &&
                (user.firstName.isEmpty || user.lastName.isEmpty))
            ? CircleAvatar(
                radius: 80,
                backgroundColor:
                    Colors.grey[400]!.withOpacity(isReadOnly ? 0.5 : 1.0),
              )
            : CircleAvatar(
                radius: 80,
                backgroundColor:
                    Colors.grey[400]!.withOpacity(isReadOnly ? 0.5 : 1.0),
                child: selectedProfile.isEmpty
                    ? Center(
                        child: Text(
                          "${fnCtrl.text.isNotEmpty ? fnCtrl.text[0] : ''}${lnCtrl.text.isNotEmpty ? lnCtrl.text[0] : ''}"
                              .toUpperCase(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(
                                isReadOnly ? 0.5 : 1.0), // fade initials
                            fontSize:
                                MediaQuery.of(context).size.width * 0.175,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ClipOval(
                        child: Image.file(
                          File(selectedProfile),
                          fit: BoxFit.cover,
                          width: 160,
                          height: 160,
                        ),
                      ),
              ),
      ),
    ),
  );
}

  Widget _buildFormField({
    required String hint,
    required TextEditingController controller,
    IconData? suffixIcon,
    required bool readOnly,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        style: TextStyle(
          color: readOnly ? Colors.grey : Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: readOnly ? Colors.grey : Colors.black,
            fontSize: 16,
          ),
          suffixIcon:
              suffixIcon != null ? Icon(suffixIcon, color: Colors.grey) : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: readOnly ? Colors.grey : Colors.black.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: readOnly ? Colors.grey : Colors.black.withOpacity(0.5),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }

  Widget _buildGender() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: RadioListTile<String>(
              value: "male",
              groupValue: gender,
              onChanged: isReadOnly
                  ? null
                  : (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
              title: Text(
                "Male",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              activeColor: Color(0xff5A9B73),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          Expanded(
            child: RadioListTile<String>(
              value: "female",
              groupValue: gender,
              onChanged: isReadOnly
                  ? null
                  : (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
              title: Text(
                "Female",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              activeColor: Color(0xff5A9B73),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDobSelector() {
    return Bounceable(
      onTap: isReadOnly
          ? () {}
          : () async {
              DateTime? value = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (value != null) {
                setState(() {
                  selectedDOB = DateFormat("dd MMMM yyyy").format(value);
                });
              }
            },
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black.withOpacity(0.5),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Text(
              selectedDOB.isEmpty ? "Date of birth" : selectedDOB,
              style: TextStyle(
                fontSize: 16,
                color: isReadOnly ? Colors.grey : Colors.black,
              ),
            ),
            const Spacer(),
            const Icon(Icons.calendar_month_outlined, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Opacity(
        opacity: isReadOnly ? 0.7 : 1.0,
        child: DropdownButtonFormField<String>(
          value: selectedCity,
          icon: const Icon(Icons.arrow_drop_down),
          // Passing null to onChanged automatically disables the Dropdown
          onChanged: isReadOnly
              ? null
              : (value) {
                  setState(() {
                    selectedCity = value!;
                  });
                },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black.withOpacity(0.5), width: 1.0),
              borderRadius: BorderRadius.circular(100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black.withOpacity(0.5), width: 2.0),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          items: cities
              .map((city) => DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
