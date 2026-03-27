import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_assignment/constants/app_image.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportUsScreen extends StatefulWidget {
  const SupportUsScreen({super.key});

  @override
  State<SupportUsScreen> createState() => _SupportUsScreenState();
}

class _SupportUsScreenState extends State<SupportUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          SizedBox(height: 40),
          Container(
            width: 280,
            height: 300,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              AppImage.aba,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 40),
          Image.asset("assets/images/Thank you!.png"),
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
                "Support Us",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "You guy can support us via\n scanning this QR Code",
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

}
