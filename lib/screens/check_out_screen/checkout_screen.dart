import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_assignment/db/db_address.dart'; // Logic Added
import 'package:mobile_assignment/db/db_user.dart';
import 'package:mobile_assignment/model/address_model.dart'; // Logic Added
import 'package:mobile_assignment/model/plant_model.dart';
import 'package:mobile_assignment/model/user_model.dart';
import 'package:mobile_assignment/routes/app_route.dart';

enum DeliveryType { priority, standard }

DeliveryType selectedDelivery = DeliveryType.standard;

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<PlantModel> items = [];
  AddressModel? selectedAddress; // Logic Added

  double get subTotal {
    return items.fold(0, (sum, item) => sum + item.total);
  }

  double get deliveryFee {
    return selectedDelivery == DeliveryType.priority ? 1.0 : 0.0;
  }

  UserModel? user;
  Future<void> loadUser() async {
    final data = await DbUser.readUsers();
    if (data.isNotEmpty) {
      setState(() {
        user = data.last;
      });
    }
  }

  // Logic Added: Load Address from DB
  Future<void> loadAddress() async {
    final data = await DbAddress.instance.getAllAddresses();
    if (data.isNotEmpty) {
      setState(() {
        selectedAddress = data.first; // Get the latest one
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    loadAddress(); // Logic Added
  }

bool _loaded = false;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (_loaded) return;

  final args = ModalRoute.of(context)!.settings.arguments;

  // FROM CART
  if (args is List<PlantModel>) {
    items = args;
  }

  // FROM BUY NOW
  else if (args is Map) {
    final PlantModel plant = args['plant'];
    final int qty = args['quantity'];

    plant.qty = qty; // ✅ THIS IS THE KEY LINE
    items = [plant];
  }

  _loaded = true;
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEEE),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff467B5D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummary(),
                  SizedBox(height: 15),
                  Divider(),
                  SizedBox(height: 15),
                  _buildDeliveryDetail(),
                  SizedBox(height: 15),
                  Divider(),
                  SizedBox(height: 15),
                  _buildDeliveryOption(),
                  SizedBox(height: 15),
                  Divider(),
                  SizedBox(height: 15),
                  _buildPaymentMethod(),
                  SizedBox(height: 15),
                  Divider(),
                  SizedBox(height: 150),
                ],
              ),
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: _buildButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ...items.map((plant) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      plant.image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(plant.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("Qty: ${plant.qty}"),
                      ],
                    ),
                  ),
                  Text(
                    "\$${plant.total.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
        const Divider(),
        Row(
          children: [
            const Text("SubTotal",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Spacer(),
            Text("\$${subTotal.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text(
              "Delivery fee",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text("\$${deliveryFee.toStringAsFixed(2)}"),
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Delivery Detail",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Spacer(),
            Bounceable(
              onTap: () async {
                // Change pushReplacementNamed to pushNamed so it returns here
                await Navigator.pushNamed(context, AppRoute.address);
                loadAddress(); // Refresh data after coming back
              },
              child: Text(
                "Change",
                style: TextStyle(
                  color: Color(0xff467B5D),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      
        Text(
          selectedAddress != null
              ? "${selectedAddress!.gender}. ${selectedAddress!.name}"
              : (user != null
                  ? "Ms/Mr. ${user!.firstName} ${user!.lastName}"
                  : "Ms/Mr. None"),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 15),

        Text(
          selectedAddress != null
              ? "${selectedAddress!.address}, ${selectedAddress!.detail ?? ''}"
              : "Tuek Tlar,Khan Sen Sok, Phnom Penh",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
        ),
        SizedBox(height: 15),

        Text(
          selectedAddress != null ? selectedAddress!.phone : "+855 12345678",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildDeliveryOption() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Delivery Options",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDelivery = DeliveryType.priority;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedDelivery == DeliveryType.priority
                    ? Color(0xff467B5D)
                    : Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Priority • 20min",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Delivery to you with no stop in between",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "\$1.00",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDelivery = DeliveryType.standard;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedDelivery == DeliveryType.standard
                    ? Color(0xff467B5D)
                    : Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(
                  "Standard • 40min",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  "Free",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Methods",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 15),
        Bounceable(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              showDragHandle: true,
              backgroundColor: Colors.white,
              builder: (context) {
                return _buildBottomSheetCash();
              },
            );
          },
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff467B5D),
                ),
                child: Image.asset("assets/icons/cash.png"),
              ),
              SizedBox(width: 10),
              Text(
                "Cash on Delivery",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
        SizedBox(height: 15),
        Bounceable(
          onTap: () {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              builder: (context) {
                return _buildBottomSheetOffers();
              },
            );
          },
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff467B5D),
                ),
                child:
                    Image.asset("assets/icons/offer.png", color: Colors.white),
              ),
              SizedBox(width: 10),
              const Text(
                "Use offer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheetOffers() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Offers",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            SizedBox(height: 15),
            Text(
              "Have gift code to redeem?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              "Enter your gift code to your suprice!",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
            ),
            SizedBox(height: 20),
            Text("Gift code", style: TextStyle(fontSize: 20)),
            SizedBox(height: 15),
            TextField(
              autofocus: true,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Navigator.pop(context);
                }
              },
              decoration: InputDecoration(
                hintText: "e.g kk123455",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 2, color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 2, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheetCash() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Methods",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Linked Methods",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF2D6936),
                  ),
                  child: Image.asset(
                    "assets/icons/cash.png",
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "Cash on delivery",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
                Spacer(),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff467B5D),
                  ),
                  child: Center(child: Icon(Icons.check, color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text(
              "Add Methods",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Bounceable(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Pay via card"),
                      content: Text("Pay via card is not available now."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF2D6936),
                    ),
                    child: Image.asset(
                      "assets/icons/card.png",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Card",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            SizedBox(height: 20),
            Bounceable(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "ABA Pay",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "To use ABA Pay, please scan the QR code below in your ABA Mobile app to link your account.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Image.asset(
                              "assets/images/abaqr.png",
                              width: 300,
                              height: 300,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset("assets/icons/ABA.png"),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "ABA Pay",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotal() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Total",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            Text(
              " (nxw-402345)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
            Spacer(),
            Text(
              "\$ ${(subTotal + deliveryFee).toStringAsFixed(2)}",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildButton() {
    return Container(
      width: double.infinity,
      color: const Color(0xffEEEEEE),
      child: Column(
        children: [
          SizedBox(height: 15),
          _buildTotal(),
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                // If you want to force an address, check selectedAddress here
                Navigator.pushReplacementNamed(context, AppRoute.placeorder);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff467B5D),
                foregroundColor: Colors.white,
              ),
              child: Text(
                "Place Order",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
