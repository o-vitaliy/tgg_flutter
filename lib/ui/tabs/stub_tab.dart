import 'package:flutter/widgets.dart';

class StubTab extends StatelessWidget {
  final String title;

  const StubTab({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
