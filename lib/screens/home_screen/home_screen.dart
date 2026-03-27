import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_assignment/data/plant_data.dart';
import 'package:mobile_assignment/db/db_fav.dart';
import 'package:mobile_assignment/db/db_user.dart';
import 'package:mobile_assignment/model/plant_model.dart';
import 'package:mobile_assignment/model/user_model.dart';
import 'package:mobile_assignment/routes/app_route.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String greeting = "Good Morning!";
  UserModel? user;

  final ScrollController scrollCtrl = ScrollController();
  Set<String> favoriteIds = {};
  int itemToShow = 6;
  int itemLoadMore = 4;
  int sliderIndex = 0;

  @override
  void initState() {
    super.initState();
    getGreeting();
    loadUser();
    loadFavorites();

    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels == scrollCtrl.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  @override
  void dispose() {
    scrollCtrl.dispose();
    super.dispose();
  }

  void getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greeting = "Good Morning!";
    } else if (hour < 18) {
      greeting = "Good Afternoon!";
    } else {
      greeting = "Good Evening!";
    }
  }

  Future<void> loadUser() async {
    final data = await DbUser.readUsers();
    if (data.isNotEmpty) {
      setState(() {
        user = data.last;
      });
    }
  }

  Future<void> loadFavorites() async {
    final ids = await DbFavorite.getAll();
    setState(() {
      favoriteIds = ids.toSet();
    });
  }

  Future<void> loadMore() async {
    if (itemToShow >= plantData.length) return;
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      itemToShow += itemLoadMore;
    });
  }

  final recommendedPlants = plantData
      .map((e) => PlantModel.fromMap(e))
      .where((plant) => plant.recommendForYou)
      .toList();

  @override
  Widget build(BuildContext context) {
    if (user == null){
      return  SizedBox(
        height: 250,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        controller: scrollCtrl,
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            _buildSlider(),
            SizedBox(height: 20),
            _buildText(),
            SizedBox(height: 30),
            _buildProduct(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget skeletonLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: 210,
        color: Colors.white,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Color(0xff467B5D),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      // Check if firstName is empty
                      if (user!.firstName.isNotEmpty) ...[
                        Text(
                          user!.firstName,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ] else
                        SizedBox(),
                    ],
                  ),
                  Spacer(),
                  SizedBox(width: 10),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: user!.profile.isEmpty
                        ? Text(
                            "${user!.firstName.isNotEmpty ? user!.firstName[0] : ''}${user!.lastName.isNotEmpty ? user!.lastName[0] : ''}"
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff467B5D),
                            ),
                          )
                        : ClipOval(
                            child: Image.file(
                              File(user!.profile),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ],
              ),
              Spacer(),
              Bounceable(
                onTap: () => Navigator.pushNamed(context, AppRoute.search2),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Search here...",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() {
    final images = [
      "assets/images/silder1.png",
      "assets/images/silder2.png",
      "assets/images/silder3.png",
    ];

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, _) {
              setState(() => sliderIndex = index);
            },
          ),
          items: images.map((img) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: sliderIndex,
          count: images.length,
          effect: SwapEffect(
            activeDotColor: Color(0xff467B5D),
            dotHeight: 12,
            dotWidth: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "Recommend for you",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoute.see_all),
            child: Text(
              "See all",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff467B5D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProduct() {
    // Filter the recommended plants
    final recommendedPlants = plantData
        .map((e) => PlantModel.fromMap(e))
        .where((plant) => plant.recommendForYou)
        .toList();

    if (recommendedPlants.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Text(
            "No Items",
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          mainAxisExtent: 280,
        ),
        itemCount: itemToShow > recommendedPlants.length
            ? recommendedPlants.length
            : itemToShow,
        itemBuilder: (context, index) {
          final plant = recommendedPlants[index];
          plant.isFavorite = favoriteIds.contains(plant.plantId);

          return Hero(
            tag: plant.plantId,
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  AppRoute.detail,
                  arguments: plant,
                );
                loadFavorites();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF4F4F4),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          plant.image,
                          height: 210,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (c, child, progress) =>
                              progress == null ? child : skeletonLoading(),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                plant.isFavorite = !plant.isFavorite;
                              });
                              if (plant.isFavorite) {
                                favoriteIds.add(plant.plantId);
                                await DbFavorite.insert(plant.plantId);
                              } else {
                                favoriteIds.remove(plant.plantId);
                                await DbFavorite.deleteFav(plant.plantId);
                              }
                            },
                            child: Image.asset(
                              plant.isFavorite
                                  ? "assets/icons/heartRed.png"
                                  : "assets/icons/heart.png",
                              width: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        plant.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 6),
                      child: Text(
                        "\$ ${plant.price.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
