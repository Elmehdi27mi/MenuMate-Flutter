import 'package:flutter/material.dart';

class CustemTextFormField extends StatelessWidget {
  String? hintText, labelText;
  bool? obscure;

  TextInputType? textInputType;
  Function(String)? onChanged;
  CustemTextFormField({
    this.hintText,
    this.onChanged,
    this.obscure = false,
    this.textInputType,
    this.labelText,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: obscure!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'this champ is empty';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(32),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(32),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(32),
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 12),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 12, color: Color(0xff183153)),
      ),
    );
  }
}
