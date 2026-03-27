// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mobile_assignment/data/plant_category.dart';
import 'package:mobile_assignment/data/plant_data.dart';
import 'package:mobile_assignment/db/db_fav.dart';
import 'package:mobile_assignment/model/plant_model.dart';
import 'package:mobile_assignment/routes/app_route.dart';
import 'package:shimmer/shimmer.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  final ScrollController scrollCtrl = ScrollController();

  int selectedCategoryIndex = 0;
  int itemToShow = 6;
  int itemLoadMore = 4;

  Set<String> favoriteIds = {};
  List<Map<String, dynamic>> filteredMaps = [];
  List<PlantModel> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filterProduct();
    loadFavorites();

    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels ==
          scrollCtrl.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  Future<void> loadFavorites() async {
    final ids = await DbFavorite.getAll();
    setState(() {
      favoriteIds = ids.toSet();
    });
  }

  void loadMore() async {
    if (itemToShow >= filteredProducts.length) return;
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      itemToShow += itemLoadMore;
    });
  }

  void filterProduct() {
    final selectedCategory = categories[selectedCategoryIndex];

    if (selectedCategory == "All") {
      filteredMaps = plantData;
    } else {
      filteredMaps = plantData
          .where((p) => p['category'] == selectedCategory)
          .toList();
    }

    filteredProducts =
        filteredMaps.map((e) => PlantModel.fromMap(e)).toList();

    itemToShow = filteredProducts.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Product",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff467B5D),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollCtrl,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            _buildSlider(),
            const SizedBox(height: 20),
            _buildCategory(),
            const SizedBox(height: 20),
            _buildProduct(),
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

  Widget _buildSlider() {
    return Container(
      height: 220,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset(
        "assets/images/plant_banner.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildCategory() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () {
              selectedCategoryIndex = index;
              filterProduct();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xff467B5D) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 2,
                  color: isSelected
                      ? const Color(0xff467B5D)
                      : const Color(0xffBBBBBB),
                ),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProduct() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
        mainAxisExtent: 280,
      ),
      itemCount: filteredProducts.length < itemToShow
          ? filteredProducts.length
          : itemToShow,
      itemBuilder: (context, index) {
        final plant = filteredProducts[index];
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
                color: const Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
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
                            progress == null
                                ? child
                                : skeletonLoading(),
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      plant.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 6),
                    child: Text(
                      "\$ ${plant.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
