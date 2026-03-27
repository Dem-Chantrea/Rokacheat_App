import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_assignment/constants/app_image.dart';
import 'package:mobile_assignment/routes/app_route.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          SizedBox(height: 30),
          _builldDescription(),
          Spacer(),
          _buildBtnTeamUs(),
          Spacer(),
          _buildSocial(),
          SizedBox(height: 20),
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
                "ROKACHEAT SHOP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Bringing Nature’s Heart to Your Home",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
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

  Widget _builldDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            "At Rokacheat Shop, we believe that\n everyhome deserves a touch of green.\n What started as a small passion for petals\n has grown into a community of plant\n lovers. We don’t just sell plants we share\n the joy of watching life grow.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImage.iconLeaf),
              SizedBox(width: 10),
              Text(
                "Expert Care",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5A9B73),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImage.iconLeaf),
              SizedBox(width: 10),
              Text(
                "Eco-Friendly",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5A9B73),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImage.iconLeaf),
              SizedBox(width: 10),
              Text(
                "Curated Collection",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5A9B73),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "To brighten lives through the beauty of nature, making plant parenthood accessible, easy, and sustainable for everyone—one sprout at a time.",
            style: TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBtnTeamUs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Bounceable(
        onTap: () {
          Navigator.pushNamed(context, AppRoute.team);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xff5A9B73),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Team Us",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocial() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Bounceable(
          onTap: () async {
            await launchUrl(
              Uri.parse(
                  'https://www.facebook.com/share/1BeGNs3uQB/?mibextid=wwXIfr'),
              mode: LaunchMode.externalApplication,
            );
          },
          child: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset(
              AppImage.facebook,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: 15),
        Bounceable(
          onTap: () async {
            await launchUrl(
              Uri.parse(
                  'https://www.instagram.com/_t.naihuoy_?igsh=MXB5OXpyaXZvdW51OA%3D%3D&utm_source=qr'),
              mode: LaunchMode.externalApplication,
            );
          },
          child: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset(
              AppImage.instragram,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: 15),
        Bounceable(
          onTap: () async {
            await launchUrl(
              Uri.parse('https://t.me/Naihuoy07'),
              mode: LaunchMode.externalApplication,
            );
          },
          child: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset(
              AppImage.telegram,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
