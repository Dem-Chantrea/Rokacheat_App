// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_assignment/data/plant_data.dart';
import 'package:mobile_assignment/model/plant_model.dart';
import 'package:mobile_assignment/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  List<Map<String, dynamic>> searchData = [];
  String selectedCategory = "Indoor";

  var storedIndex = <String>[];

  void toggleBookmark(int plantId) async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      if (storedIndex.contains("bookmark_$plantId")) {
      storedIndex.remove("bookmark_$plantId");
    } else {
      storedIndex.add("bookmark_$plantId");
    }
    });

    pref.setStringList("bookmarkItems", storedIndex);
  }

  void loadBookmark() async{
    var pref = await SharedPreferences.getInstance();
    var data = pref.getStringList("bookmarkItems");
    setState(() {
      storedIndex = data ?? [];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterByCategory(selectedCategory);
    searchCtrl.addListener(searchFunc);
    loadBookmark();
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void searchFunc() {
    final query = searchCtrl.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        searchData = []; 
      } else {
        searchData = plantData.where((item) {
          return item["name"].toString().toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      searchData = plantData
          .where(
            (map) =>
                map["category"].toString().toLowerCase() ==
                category.toLowerCase(),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(),
              SizedBox(height: 30),

              if (searchCtrl.text.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.search, size: 40, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        "Start typing to search plants",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),


              // if (searchCtrl.text.isNotEmpty && searchData.isNotEmpty)
              //   GridView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: searchData.length,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       mainAxisSpacing: 10,
              //       mainAxisExtent: 300,
              //     ),
              //     itemBuilder: (context, index) {
              //       return _buildPlantItem(
              //         PlantModel.fromMap(searchData[index]),
              //       );
              //     },
              //   ),

                if (searchCtrl.text.isNotEmpty && searchData.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchData.length,
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 10,
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    return _buildPlantItem2(
                      PlantModel.fromMap(searchData[index]),
                    );
                  },
                ),
                
              if (searchCtrl.text.isNotEmpty && searchData.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.error_outline, size: 40, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        "No plants found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildPlantItem(PlantModel plantData) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Expanded(
  //           child: Container(
  //             clipBehavior: Clip.hardEdge,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(20),
  //               color: const Color(0xffebebeb),
  //             ),
  //             child: Stack(
  //               children: [
  //                 // CachedNetworkImage(
  //                 //   memCacheHeight: 400,
  //                 //   memCacheWidth: 400,
  //                 //   imageUrl: PlantData.image,
  //                 //   fit: BoxFit.cover,
  //                 //   placeholder: (_, __) => Shimmer.fromColors(
  //                 //     baseColor: Colors.grey.shade300,
  //                 //     highlightColor: Colors.white,
  //                 //     child: Container(color: Colors.grey),
  //                 //   ),
  //                 // ),
  //                 Image.network(
  //                   plantData.image,
  //                   fit: BoxFit.cover,
  //                   width: double.infinity,
  //                   height: double.infinity,
  //                   loadingBuilder: (context, child, loadingProgress) {
  //                     if (loadingProgress == null) return child;
  //                     return Shimmer.fromColors(
  //                       baseColor: Colors.grey.shade300,
  //                       highlightColor: Colors.white,
  //                       child: Container(color: Colors.grey),
  //                     );
  //                   },
  //                   errorBuilder: (context, error, stackTrace) {
  //                     return const Center(child: Icon(Icons.broken_image));
  //                   },
  //                 ),
  //                 Positioned(
  //                   top: 15,
  //                   left: 15,
  //                   child: Container(
  //                     padding: const EdgeInsets.symmetric(
  //                       horizontal: 8,
  //                       vertical: 4,
  //                     ),
  //                     decoration: BoxDecoration(
  //                       color: Colors.red,
  //                       borderRadius: BorderRadius.circular(20),
  //                     ),
  //                     child: Text(
  //                       "${plantData.discount}%",
  //                       style: const TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 12,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Positioned(
  //                   top: 15,
  //                   right: 15,
  //                   child: Bounceable(
  //                     scaleFactor: 0.5,
  //                     onTap: () {
  //                       setState(() {
  //                         toggleBookmark(plantData.plantId.toString() as int);
  //                       });
  //                     },
  //                     child: Image.asset("assets/images/icon_bookmark.png", width: 25, height: 25,
  //                     color: storedIndex.contains("bookmark_${plantData.plantId}") ? Colors.red : Colors.grey,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           plantData.category,
  //           style: const TextStyle(color: Colors.grey),
  //         ),
  //         Text(
  //           plantData.name,
  //           maxLines: 1,
  //           overflow: TextOverflow.ellipsis,
  //           style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //         ),
  //         Text(
  //           "\$${plantData.price}",
  //           style: const TextStyle(color: Colors.red),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPlantItem2(PlantModel plantData){
    return Bounceable(
      onTap: () {
         Navigator.pushNamed(
          context,
          AppRoute.detail,
          arguments: plantData,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
        child: Row(
          children: [
            Icon(Icons.search,),
            SizedBox(width: 10,),
            RichText(
              text: _buildHighlightedTextSpan(plantData.name, searchCtrl.text),
            )
          ],
        ),
      ),
    );
  }

  TextSpan _buildHighlightedTextSpan(String name, String query) {
  if (query.isEmpty) {
    return TextSpan(
      text: name,
      style: const TextStyle(color: Colors.black, fontSize: 16),
    );
  }

  final lowerQuery = query.toLowerCase();

  return TextSpan(
    children: name.split('').map((char) {
      final isMatch = lowerQuery.contains(char.toLowerCase());

      return TextSpan(
        text: char,
        style: TextStyle(
          color: isMatch ? Colors.grey : Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      );
    }).toList(),
  );
}

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                hintText: "Search here...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff5A9B73)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
