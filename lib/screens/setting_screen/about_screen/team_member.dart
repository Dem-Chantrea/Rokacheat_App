import 'package:flutter/material.dart';

class TeamMemberScreen extends StatefulWidget {
  const TeamMemberScreen({super.key});

  @override
  State<TeamMemberScreen> createState() => _TeamMemberScreenState();
}

class _TeamMemberScreenState extends State<TeamMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            SizedBox(height: 20),
            buildTeamCard(
              title: "Leader",
              name: "Duoungtha Sithat",
              role: "Back-end",
              email: "sithat123@gmail.com",
              avatarLeft: true,
              avatar: "assets/images/members/sithat.jpg",
            ),
            buildTeamCard(
              title: "Member",
              name: "Doeurng Pheanin",
              role: "UX/UI Design",
              email: "pheanin456@gmail.com",
              avatarLeft: false,
              avatar: "assets/images/members/pheanin.jpg",
            ),
            buildTeamCard(
              title: "Member",
              name: "Taing Naihuoy",
              role: "Front-end",
              email: "naihuoy678@gmail.com",
              avatarLeft: true,
              avatar: "assets/images/members/nai.jpg",
            ),
            buildTeamCard(
              title: "Member",
              name: "Dem Chantrea",
              role: "Front-end",
              email: "chantrea901@gmail.com",
              avatarLeft: false,
              avatar: "assets/images/members/trea.jpg",
            ),
            buildTeamCard(
              title: "Member",
              name: "Tangoun Songheng",
              role: "UX/UI & Front-end",
              email: "songheng234@gmail.com",
              avatarLeft: true,
              avatar: "assets/images/members/heng.jpg",
            ),
            SizedBox(height: 30),
            Text(
              " © 2026 Rokacheat Shop. All Rights Reserved.",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.28,
          decoration: BoxDecoration(
            color: Color(0xff5A9B73),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                "Team our team",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Meet the plant lovers dedicated\n to your green journey",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Positioned(
          top: 60,
          left: 20,
          child: SizedBox(
            height: 40,
            width: 40,
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

  Widget buildTeamCard({
    required String title,
    required String name,
    required String role,
    required String email,
    required String avatar,
    bool avatarLeft = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: avatarLeft
            ? [
                _buildAvatar(avatar),
                SizedBox(width: 10),
                Expanded(child: _buildInfo(title, name, role, email)),
              ]
            : [
                Expanded(child: _buildInfo(title, name, role, email)),
                SizedBox(width: 10),
                _buildAvatar(avatar),
              ],
      ),
    );
  }

  Widget _buildAvatar(String avatar) {
    return ClipOval(
      child: Image.asset(
        avatar,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.person, size: 40);
        },
      ),
    );
  }

  Widget _buildInfo(
    String title,
    String name,
    String role,
    String email,
  ) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 125,
      decoration: BoxDecoration(
        color: Color(0xffE4E4E4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(title, style: TextStyle(fontSize: 14))),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Text("Role: $role", style: TextStyle(fontSize: 14))),
          Expanded(child: Text(email, style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
