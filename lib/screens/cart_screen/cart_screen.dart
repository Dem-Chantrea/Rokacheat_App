// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mobile_assignment/db/db_cart.dart';
import 'package:mobile_assignment/model/plant_model.dart';
import 'package:mobile_assignment/routes/app_route.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double total = 0.0;
  List<PlantModel> cartList = [];
  int cartCount = 0;

  Future<void> loadCart() async {
    final items = await DbCart.getCart();
    int totalQty = 0;
    for (var item in items) {
      totalQty += item.qty;
    }

    setState(() {
      cartList = items;
      cartCount = totalQty;
    });
  }

  void updateCartCount() {
    int totalQty = 0;
    for (var item in cartList) {
      totalQty += item.qty;
    }
    setState(() {
      cartCount = totalQty;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  double get cartTotal {
    return cartList
        .where((item) => item.isSelected)
        .fold(0.0, (sum, item) => sum + item.total);
  }

  bool get isAllSelected {
    return cartList.isNotEmpty && cartList.every((item) => item.isSelected);
  }

  void toggleSelectAll(bool value) async {
    setState(() {
      for (var item in cartList) {
        item.isSelected = value;
      }
    });

    for (var item in cartList) {
      await DbCart.updateSelection(item.plantId, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xff5A9B73),
        automaticallyImplyLeading: false,
        title: const Text(
          "My cart",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: cartList.isEmpty
          ? const Center(
              child: Text(
                "No Items yet",
                style: TextStyle(fontSize: 26, color: Colors.black54),
              ),
            )
          : Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "$cartCount items",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff5A9B73),
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          if (cartList.any((item) => item.isSelected))
                            TextButton(
                              onPressed: () async {
                                await DbCart.deleteSelected();

                                await loadCart();
                              },
                              child: const Text(
                                "Remove all",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: cartList.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 150,
                            child: _buildPlantCard(cartList[index], index),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildBottomCartBar(),
                ),
              ],
            ),
    );
  }

  Widget _buildBottomCartBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                child: Checkbox(
                  value: isAllSelected,
                  activeColor: const Color(0xFF2D6936),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onChanged: (value) {
                    toggleSelectAll(value ?? false);
                  },
                ),
              ),
              const Text("All"),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Total:",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                "\$${cartTotal.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff5A9B73),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: cartTotal == 0
                ? null
                : () async {
                    final selectedItems =
                        cartList.where((item) => item.isSelected).toList();
                    await Navigator.pushNamed(
                      context,
                      AppRoute.checkout,
                      arguments: selectedItems,
                    );
                  },
            child: const Text(
              "Checkout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantCard(PlantModel plantData, int index) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Checkbox(
            value: plantData.isSelected,
            activeColor: const Color(0xFF2D6936),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onChanged: (bool? value) async {
              setState(() {
                plantData.isSelected = value ?? false;
              });

              await DbCart.updateSelection(
                plantData.plantId,
                plantData.isSelected,
              );
            },
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 110,
                  height: 160,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    plantData.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.eco, size: 40),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plantData.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        plantData.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "\$${plantData.total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D6936),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (plantData.qty > 1) {
                                setState(() {
                                  plantData.qty--;
                                  updateCartCount();
                                });
                                DbCart.updateQty(
                                    plantData.plantId, plantData.qty);
                              }
                            },
                          ),
                          Text(
                            plantData.qty.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                plantData.qty++;
                                updateCartCount();
                              });
                              DbCart.updateQty(
                                  plantData.plantId, plantData.qty);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await DbCart.deletePlant(plantData.plantId);
                    await loadCart();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
