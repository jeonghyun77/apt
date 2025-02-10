import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TexFiled extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final String hintText;
  final Icon prefixIcon;
  final bool? obscure;
  const TexFiled({super.key, this.controller, this.type = TextInputType.emailAddress, required this.hintText, required this.prefixIcon, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type ,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,

      ),
    );
  }
}
