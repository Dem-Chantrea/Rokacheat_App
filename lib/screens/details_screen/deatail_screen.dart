import 'package:flutter/material.dart';
import 'package:mobile_assignment/db/db_cart.dart';
import 'package:mobile_assignment/db/db_fav.dart';
import 'package:mobile_assignment/model/plant_model.dart';
import 'package:mobile_assignment/routes/app_route.dart';

class DeatailScreen extends StatefulWidget {
  const DeatailScreen({super.key});

  @override
  State<DeatailScreen> createState() => _DeatailScreenState();
}

class _DeatailScreenState extends State<DeatailScreen> {
  late PlantModel plant;

  int quantity = 1;
  int cartCount = 0;
  bool isFavorite = false;
  bool _initialized = false;

  // ---------- LOAD FAVORITE ----------
  Future<void> loadFavoriteStatus() async {
    final fav = await DbFavorite.isFavorite(plant.plantId);
    if (!mounted) return;
    setState(() {
      isFavorite = fav;
      plant.isFavorite = fav;
    });
  }

  // ---------- LOAD CART COUNT ----------
  Future<void> loadCartCount() async {
    final cartItems = await DbCart.getCart();
    if (!mounted) return;

    setState(() {
      cartCount = cartItems.fold(0, (sum, item) => sum + item.qty);
    });
  }

  // ---------- INIT ----------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      plant = ModalRoute.of(context)!.settings.arguments as PlantModel;
      loadFavoriteStatus();
      loadCartCount();
      _initialized = true;
    }
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(height: 20),
            _buildDetail(),
            const SizedBox(height: 20),
            _buildQty(),
            const SizedBox(height: 20),
            _buildBuyNowBtn(),
          ],
        ),
      ),
    );
  }

  // ---------- APP BAR ----------
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Detail",
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
      actions: [
        // FAVORITE
        IconButton(
          onPressed: () async {
            setState(() {
              isFavorite = !isFavorite;
              plant.isFavorite = isFavorite;
            });

            if (isFavorite) {
              await DbFavorite.insert(plant.plantId);
            } else {
              await DbFavorite.deleteFav(plant.plantId);
            }
          },
          icon: Icon(
            Icons.favorite,
            color: isFavorite ? Colors.red : Colors.white,
            size: 28,
          ),
        ),

        // CART
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart,
                  color: Colors.white, size: 30),
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoute.cart2,
              ).then((_) => loadCartCount()),
            ),
            if (cartCount > 0)
              Positioned(
                right: 6,
                top: 3,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "$cartCount",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // ---------- IMAGE ----------
  Widget _buildImage() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Image.network(
        plant.image,
        height: 400,
        fit: BoxFit.cover,
      ),
    );
  }

  // ---------- DETAIL ----------
  Widget _buildDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plant.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "Price : \$${plant.price.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            plant.description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ---------- QUANTITY + ADD TO CART ----------
  Widget _buildQty() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quantity:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: quantity > 1
                          ? () => setState(() => quantity--)
                          : null,
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => setState(() => quantity++),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Color(0xff467B5D), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () async {
                    await DbCart.insertOrUpdatePlant(plant, quantity);
                    await loadCartCount();

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${plant.name} added to cart"),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Text(
                    "Add to cart - ${(plant.price * quantity).toStringAsFixed(2)} USD",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- BUY NOW ----------
  Widget _buildBuyNowBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff467B5D),
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoute.checkout,
              arguments: {
                'plant': plant,
                'quantity': quantity,
                
              },
            );
          },
          child: const Text(
            "Buy Now",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
