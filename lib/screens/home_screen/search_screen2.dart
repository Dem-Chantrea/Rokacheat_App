// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_assignment/data/plant_data.dart';
import 'package:mobile_assignment/model/plant_model.dart';
import 'package:mobile_assignment/routes/app_route.dart';

class SearchScreen2 extends StatefulWidget {
  const SearchScreen2({super.key});

  @override
  State<SearchScreen2> createState() => _SearchScreen2State();
}

class _SearchScreen2State extends State<SearchScreen2> {
  final TextEditingController searchCtrl = TextEditingController();

  List<Map<String, dynamic>> searchData = [];

  @override
  void initState() {
    super.initState();
    searchCtrl.addListener(_onSearch);
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  /* ---------------- BOOKMARK ---------------- */

  // Future<void> _loadBookmarks() async {
  //   final pref = await SharedPreferences.getInstance();

  /* ---------------- SEARCH ---------------- */

  void _onSearch() {
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

  /* ---------------- UI ---------------- */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEEE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 30),
              if (searchCtrl.text.isEmpty) _buildEmptyHint(),
              if (searchCtrl.text.isNotEmpty && searchData.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchData.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return _buildPlantItem(
                      PlantModel.fromMap(searchData[index]),
                    );
                  },
                ),
              if (searchCtrl.text.isNotEmpty && searchData.isEmpty)
                _buildNoResult(),
            ],
          ),
        ),
      ),
    );
  }

  /* ---------------- WIDGETS ---------------- */

  Widget _buildEmptyHint() {
    return const Padding(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Icon(Icons.search, size: 40, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            "Start typing to search plants",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResult() {
    return const Padding(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 40, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            "No plants found",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantItem(PlantModel plantData) {
    return Bounceable(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoute.detail,
          arguments: plantData,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 10),
            Expanded(
              child: RichText(
                text: _highlightText(plantData.name, searchCtrl.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextSpan _highlightText(String text, String query) {
    if (query.isEmpty) {
      return TextSpan(
        text: text,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final start = lowerText.indexOf(lowerQuery);

    if (start == -1) {
      return TextSpan(text: text);
    }

    return TextSpan(
      children: [
        TextSpan(text: text.substring(0, start)),
        TextSpan(
          text: text.substring(start, start + query.length),
          style: const TextStyle(
            color: Color(0xff5A9B73),
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(text: text.substring(start + query.length)),
      ],
      style: const TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          // const SizedBox(width: 10),
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
