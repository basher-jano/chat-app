import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.hitText, this.onChanged});
  String? hitText;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'This field is requaird';
          }
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hitText,
          hintStyle:
              TextStyle(fontSize: 15, color: Colors.white.withAlpha(100)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 175, 145, 145))),
        ));
  }
}
