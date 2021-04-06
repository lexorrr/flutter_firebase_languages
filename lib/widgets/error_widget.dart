import 'package:flutter/material.dart';

class ErrorItemWidget extends StatelessWidget {
  const ErrorItemWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.error_outline,
        color: Colors.redAccent,
        size: 20,
      ),
    );
  }
}
