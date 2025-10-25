class Product {
  int? id;
  String name;
  int quantity;
  double price;
  String? imageBase64;

  Product({
    this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.imageBase64,
  });

  // Converts a Product into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'imageBase64': imageBase64,
    };
  }

  // Convert a Map into a Product
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
      imageBase64: map['imageBase64'],
    );
  }
}
