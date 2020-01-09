import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(),
      );
}
