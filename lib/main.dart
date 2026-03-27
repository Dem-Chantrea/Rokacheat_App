import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_assignment/routes/app_route.dart';
import 'package:mobile_assignment/screens/bottom_navigation_bar/bnb_screen.dart';
import 'package:mobile_assignment/screens/cart_screen/cart_screen.dart';
import 'package:mobile_assignment/screens/check_out_screen/address_screen.dart';
import 'package:mobile_assignment/screens/check_out_screen/checkout_screen.dart';
import 'package:mobile_assignment/screens/details_screen/cart2_screen.dart';
import 'package:mobile_assignment/screens/details_screen/deatail_screen.dart';
import 'package:mobile_assignment/screens/home_screen/home_screen.dart';
import 'package:mobile_assignment/screens/home_screen/search_screen2.dart';
import 'package:mobile_assignment/screens/home_screen/see_all_screen.dart';
import 'package:mobile_assignment/screens/login_screen/login_screen.dart';
import 'package:mobile_assignment/screens/on_bordering_screen/on_bordering_screen.dart';
import 'package:mobile_assignment/screens/place_order_screen/place_order_screen.dart';
import 'package:mobile_assignment/screens/register_screen/register_screen.dart';
import 'package:mobile_assignment/screens/search_screen/search_screen.dart';
import 'package:mobile_assignment/screens/setting_screen/about_screen/about_us_screen.dart';
import 'package:mobile_assignment/screens/setting_screen/about_screen/team_member.dart';
import 'package:mobile_assignment/screens/setting_screen/account_setting/account_setting_screen.dart';
import 'package:mobile_assignment/screens/setting_screen/favorites_screen/favorites_screen.dart';
import 'package:mobile_assignment/screens/setting_screen/setting_screen.dart';
import 'package:mobile_assignment/screens/setting_screen/support_us_screen/support_us_screen.dart';
import 'package:mobile_assignment/screens/signin_screen/signin_screen.dart';
import 'package:mobile_assignment/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoute.splash,
      routes: {
        AppRoute.splash: (context) => SplashScreen(),
        AppRoute.onBordering: (context) => OnBorderingScreen(),
        AppRoute.signin: (context) => SigninScreen(),
        AppRoute.login: (context) => LoginScreen(),
        AppRoute.register: (context) => RegisterScreen(),
        AppRoute.bottomNav: (context) => BnbScreen(),
        AppRoute.home: (context) => HomeScreen(),
        AppRoute.search: (context) => SearchScreen(),
        AppRoute.search2: (context) => SearchScreen2(),
        AppRoute.cart: (context) => CartScreen(),
        AppRoute.cart2: (context) => Cart2Screen(),
        AppRoute.setting: (context) => SettingScreen(),
        AppRoute.support: (context) => SupportUsScreen(),
        AppRoute.favorite: (context) => FavoritesScreen(),
        AppRoute.accountSetting: (context) => AccountSettingScreen(),
        AppRoute.aboutus: (context) => AboutUsScreen(),
        AppRoute.team: (context)=> TeamMemberScreen(),
        AppRoute.detail: (context) => DeatailScreen(),
        AppRoute.see_all: (context) => SeeAllScreen(),
        AppRoute.checkout: (context) => CheckoutScreen(),
        AppRoute.placeorder: (context) => PlaceOrderScreen(),
        AppRoute.address: (context) => AddressScreen(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        // scaffoldBackgroundColor: Color(0xffEAFDF4),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
