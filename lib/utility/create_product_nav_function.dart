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

//Delete button widget
Widget deleteOption(onPressed) {
  return IconButton(
    onPressed: (){
      onPressed;
    },
    icon: Icon(Icons.delete_forever_outlined),
    style: IconButton.styleFrom(surfaceTintColor: Colors.red),
  );
}

//Edit button Widget
Widget editOption(editFunction) {
  return IconButton(
    onPressed: editFunction,
    icon: Icon(Icons.edit_outlined),
  );
}
