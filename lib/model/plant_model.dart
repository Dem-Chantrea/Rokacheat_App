class PlantModel {
  String plantId;
  String name;
  String description;
  double price;
  String image;
  String category;
  double discount;
  bool recommendForYou;
  int qty;
  bool isSelected;
  bool isFavorite;
  int cart;

  PlantModel({
    required this.plantId,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.discount,
    required this.recommendForYou,
    this.qty = 1,
    this.isSelected = false,
    this.isFavorite = false,
    this.cart = 0,
  });

  double get total => price * qty;

  factory PlantModel.fromMap(Map<String, dynamic> map) {
    return PlantModel(
      plantId: map['plant_id']?.toString() ?? '',
      name: map['name']?.toString() ?? 'Unknown',
      description: map['description']?.toString() ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      image: map['image']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      discount: (map['discount'] ?? 0.0).toDouble(),
      qty: (map['qty'] ?? 1).toInt(),
      cart: (map['cart'] ?? 0).toInt(),
      isSelected: map['isSelected'] == true,
      isFavorite: map['isFavorite'] == true,
      recommendForYou: map['recommend_for_you'] == true ||
          map['recommend_for_you'] == 1 ||
          map['recommend_for_you']?.toString().toLowerCase() == 'true',
    );
  }
}
