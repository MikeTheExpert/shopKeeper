import 'package:flutter/material.dart';


Widget buildTextForm(controller, keyboardType, String label) {
  return TextFormField(
    controller: controller,
    autofocus: true,
    decoration: InputDecoration(label: Text(label), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))),
    textCapitalization: TextCapitalization.sentences,
    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
    keyboardType: keyboardType,
  );
}

//Edit button Widget
Widget editOption(editFunction) {
  return IconButton(
    onPressed: editFunction,
    icon: Icon(Icons.edit_outlined),
  );
}
