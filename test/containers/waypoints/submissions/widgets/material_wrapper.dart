import 'package:flutter/material.dart';

class MaterialWrapper extends StatelessWidget {
  final WidgetBuilder builder;

  MaterialWrapper(this.builder);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: builder(context),
    ));
  }
}
