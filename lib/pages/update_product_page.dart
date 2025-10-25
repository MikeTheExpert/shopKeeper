import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_keeping/utility/create_product_nav_function.dart';

import '../models/db_helper_class.dart';
import '../models/product_model.dart';

class UpdateProduct extends StatefulWidget {
  final Product product;
  const UpdateProduct({super.key, required this.product});

  @override
  State<StatefulWidget> createState() {
    return _UpdateProduct();
  }
}

class _UpdateProduct extends State<UpdateProduct> {
  final dbHelper = DatabaseHelper();
  String? imageBase64;
  final picker = ImagePicker();
  TextEditingController updateProductName = TextEditingController();
  TextEditingController updateQuantityController = TextEditingController();
  TextEditingController updatePriceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateProductName.text = widget.product.name;
    updateQuantityController.text = widget.product.quantity.toString();
    updatePriceController.text = widget.product.price.toString();
    imageBase64 = widget.product.imageBase64;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Update Product Information")),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildTextForm(
                  updateProductName,
                  TextInputType.text,
                  "Product Name:",
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildTextForm(
                  updateQuantityController,
                  TextInputType.number,
                  "Available Quantity: ",
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildTextForm(
                  updatePriceController,
                  TextInputType.number,
                  "Price",
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.outlined(
                      onPressed: pickImage,
                      icon: Icon(Icons.browse_gallery_outlined),
                      tooltip: "Select a photo from Gallery",
                      color: Colors.black54,
                    ),
                    // OutlinedButton(onPressed: pickImage, child: Text("Select a photo")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.outlined(
                      onPressed: captureImage,
                      icon: Icon(Icons.add_a_photo_outlined),
                      tooltip: "Take a photo with Camera",
                      color: Colors.black54,
                    ),
                  ),
                  if (imageBase64 != null)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Text("Image selected:", style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              base64Decode(imageBase64!),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),

                ],
              ),
              SizedBox(height: 55,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: update,
                    style: ElevatedButton.styleFrom(
                      elevation: 6.00,
                      shadowColor: Colors.black26,
                    ),
                    child: const Text("Submit Entry"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Image Picker for saved images upload
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        imageBase64 = base64Encode(bytes);
      });
    }
  }

  //Image Picker Function to take photo using native camera
  Future<void> captureImage() async {
    final capturedFile = await picker.pickImage(source: ImageSource.camera);

    if (capturedFile != null) {
      final bytes = await capturedFile.readAsBytes();
      setState(() {
        imageBase64 = base64Encode(bytes);
      });
    }
  }

  //Submission Function
  Future update() async {
    final newProduct = Product(
      id: widget.product.id,
      name: updateProductName.text,
      quantity: int.parse(updateQuantityController.text),
      price: double.parse(updatePriceController.text),
      imageBase64: imageBase64, // optional
    );

    await dbHelper.updateProduct(newProduct);
    if (!mounted) return;
    Navigator.pop(context); // go back after saving
  }
}
