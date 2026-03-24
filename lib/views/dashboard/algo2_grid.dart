import 'package:flutter/material.dart';

class Algo2Grid extends StatelessWidget {
  final double h;
  final double w;

  const Algo2Grid({
    super.key,
    required this.h,
    required this.w,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Algo 2 — en cours de construction 🚧",
        style: TextStyle(
          color: Colors.white,
          fontSize: h * 0.025,
        ),
      ),
    );
  }
}