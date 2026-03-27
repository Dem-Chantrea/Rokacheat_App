// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:mobile_assignment/db/db_address.dart';
import 'package:mobile_assignment/model/address_model.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController detailCtrl = TextEditingController();

  String selectedGender = "mr";

  @override
  void initState() {
    super.initState();
    // Add listener so the top text updates as you type in the address field
    addressCtrl.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    detailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xffEEEEEE),
        title: const Text(
          "Address",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: const Color.fromARGB(255, 225, 250, 235),
                child: Center(child: Image.asset("assets/icons/map.png")),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      // CATCH DATA FROM TEXTFORMFIELD:
                      // If the controller is empty, show a placeholder
                      addressCtrl.text.isEmpty 
                          ? "Enter your address below" 
                          : addressCtrl.text,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis, fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Contact",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: nameCtrl,
                                decoration: const InputDecoration(
                                    hintText: "Name", border: InputBorder.none),
                              ),
                            ),
                            _buildGenderRadio("mr", "MR"),
                            _buildGenderRadio("ms", "MS"),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            const Text("Phone NO",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 20),
                            const Text("+855",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                controller: phoneCtrl,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                    hintText: "12345678",
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            const Text("Address",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 30),
                            Expanded(
                              child: TextFormField(
                                controller: addressCtrl,
                                decoration: const InputDecoration(
                                    hintText: "Select Receiving Address",
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            const Text("Detail",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 46),
                            Expanded(
                              child: TextFormField(
                                controller: detailCtrl,
                                decoration: const InputDecoration(
                                    hintText: "House number, floor, room, etc",
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 120),
              Bounceable(
                onTap: () async {
                  if (nameCtrl.text.trim().isEmpty ||
                      phoneCtrl.text.trim().isEmpty ||
                      addressCtrl.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Choose address"),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  var address = AddressModel(
                    name: nameCtrl.text.trim(),
                    gender: selectedGender.toUpperCase(),
                    phone: "+855${phoneCtrl.text.trim()}",
                    address: addressCtrl.text.trim(),
                    detail:
                        detailCtrl.text.isEmpty ? null : detailCtrl.text.trim(),
                    photo: null,
                  );

                  await DbAddress.instance.insertAddress(address);

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Address saved successfully")),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xff5A9B73),
                      borderRadius: BorderRadius.circular(200)),
                  child: const Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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

  Widget _buildGenderRadio(String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: selectedGender,
          onChanged: (val) => setState(() => selectedGender = val!),
          activeColor: const Color(0xff5A9B73),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}