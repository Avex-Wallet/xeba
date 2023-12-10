import 'package:flutter/material.dart';

class TokenLoadingWidget extends StatelessWidget {
  const TokenLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white10,
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(8.0),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
