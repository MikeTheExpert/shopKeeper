import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_keeping/utility/create_product_nav_function.dart';

import '../models/db_helper_class.dart';
import '../models/product_model.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UploadProduct();
  }
}

class _UploadProduct extends State<UploadProduct> {
  final dbHelper = DatabaseHelper();
  String? imageBase64;
  final picker = ImagePicker();
  TextEditingController productName = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Upload Product Page")),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildTextForm(
                  productName,
                  TextInputType.text,
                  "Product Name:",
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildTextForm(
                  quantityController,
                  TextInputType.number,
                  "Available Quantity: ",
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildTextForm(
                  priceController,
                  TextInputType.number,
                  "Price",
                ),
              ),
              SizedBox(height: 25),
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
                    onPressed: submit,
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
  Future submit() async {
    final newProduct = Product(
      name: productName.text,
      quantity: int.parse(quantityController.text),
      price: double.parse(priceController.text),
      imageBase64: imageBase64, // optional
    );

    await dbHelper.insertProduct(newProduct);
    if (!mounted) return;
    Navigator.pop(context); // go back after saving
  }
}
