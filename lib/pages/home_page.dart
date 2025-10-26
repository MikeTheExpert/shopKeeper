import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shop_keeping/pages/update_product_page.dart';
import 'package:shop_keeping/pages/upload_product_page.dart';
import 'package:shop_keeping/utility/create_product_nav_function.dart';

import '../models/db_helper_class.dart';
import '../models/product_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  final dbHelper = DatabaseHelper();
  List<Product> products = []; //original query
  TextEditingController searchController = TextEditingController();
  List<Product> filteredProducts = []; //filter query
  Timer? _debounce; // timer to limit search option to keystroke pause

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    final data = await dbHelper.getAllProducts();
    setState(() {
      products = data;
      filteredProducts = data; // initialize with full list
    });
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 300), () {
      filterProducts(query); // your actual search logic
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = 150.0; // desired width per item
    final crossAxisCount = (screenWidth / itemWidth).floor();

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Product Catalogue'))),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: IconButton.outlined(
          onPressed: addProduct,
          icon: Icon(Icons.add_outlined),
          color: Colors.brown,
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: onSearchChanged,
              ),
            ),
            Expanded(
              child:
                  filteredProducts.isEmpty
                      ? Center(child: Text('No products found.'))
                      : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.5,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          Uint8List? imageBytes;

                          if (product.imageBase64 != null) {
                            imageBytes = base64Decode(product.imageBase64!);
                          } //checks for null values of product image

                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product Image
                                AspectRatio(
                                  aspectRatio: 1, // keeps image square
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child:
                                        imageBytes != null
                                            ? Image.memory(
                                              imageBytes,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            )
                                            : Container(
                                              color: Colors.grey[300],
                                              child: Icon(
                                                Icons.image_not_supported,
                                                size: 50,
                                              ),
                                            ),
                                  ),
                                ),

                                // Product Details
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '₦${product.price}',
                                        style: TextStyle(
                                          color: Colors.green[700],
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Qty: ${product.quantity}',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Action Buttons
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      editOption(() => editPageRoute(product)),
                                      IconButton(
                                        onPressed: ()=> deleteFunction(product),
                                        icon: Icon(
                                          Icons.delete_forever_outlined,
                                        ),
                                        style: IconButton.styleFrom(
                                          surfaceTintColor: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  //Routing to the upload product page
  void addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UploadProduct()),
    ).then((_) {
      fetchProducts(); // refresh after returning
    });
  }

  //Routing to the edit product page
  editPageRoute(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateProduct(product: product)),
    ).then((_) => fetchProducts()); // refresh after update
  }

  //Search bar function
  void filterProducts(String query) {
    final lowerQuery = query.toLowerCase();

    final results =
        products.where((product) {
          final nameMatch = product.name.toLowerCase().contains(lowerQuery);
          final priceMatch = product.price.toString().contains(lowerQuery);
          return nameMatch || priceMatch;
        }).toList();

    setState(() {
      filteredProducts = results;
    });
  }

  //Delete Functionality
  deleteFunction(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final id = product.id;
                final dbHelper = DatabaseHelper();
                await dbHelper.deleteProduct(id!);
                if (!context.mounted) return;
                Navigator.pop(context);
                fetchProducts();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
