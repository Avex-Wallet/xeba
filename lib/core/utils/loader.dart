import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size ?? 40,
        width: size ?? 40,
        padding: const EdgeInsets.all(8.0),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
