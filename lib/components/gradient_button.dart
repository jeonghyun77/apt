import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;
  final void Function()? onPressed;
  const CustomButton({super.key, required this.width,  this.child, this.onPressed, required this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color:  Color(0xffffdb12),
        ),
        child: Center(
          child: SizedBox(
           height: width,
            child: child,
          ),
        ),
      ),
    );
  }
}
