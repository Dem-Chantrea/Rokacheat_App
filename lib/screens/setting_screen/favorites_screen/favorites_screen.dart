import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_assignment/data/plant_data.dart';
import 'package:mobile_assignment/db/db_fav.dart';
import 'package:mobile_assignment/model/plant_model.dart';
import 'package:mobile_assignment/routes/app_route.dart';
import 'package:shimmer/shimmer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<PlantModel> favorites = [];
  bool isLoading = true;

  Future<void> loadFavorites() async {
    final favIds = await DbFavorite.getAll();

    final favPlants = plantData
        .where((e) => favIds.contains(e['plant_id']))
        .map((e) => PlantModel.fromMap(e))
        .toList();

    setState(() {
      favorites = favPlants;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        title: Text(
          "Favourite",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff5A9B73),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : favorites.isEmpty
              ? Center(
                  child: Text(
                    "No favorites yet",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black54,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "${favorites.length} items",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff5A9B73),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          itemCount: favorites.length,
                          itemBuilder: (context, index) {
                            return Bounceable(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoute.detail,
                                    arguments: favorites[index],
                                  );
                                },
                                child: _buildPlantCard(favorites[index]));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildPlantCard(PlantModel plant) {
    return Container(
      height: 140,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            height: 110,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: plant.image,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    color: Color(0xffebebeb),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  plant.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  plant.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                SizedBox(height: 8),
                Text(
                  "\$${plant.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D6936),
                  ),
                ),
              ],
            ),
          ),
          Bounceable(
            onTap: () async {
              await DbFavorite.deleteFav(plant.plantId);
              loadFavorites();
            },
            child: Icon(Icons.favorite, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
