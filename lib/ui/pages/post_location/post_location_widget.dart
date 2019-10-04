import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class PostLocationWidget extends StatefulWidget {
  final Widget child;

  const PostLocationWidget({Key key, this.child}) : super(key: key);

  @override
  State createState() => _PostLocationWidgetState(child);
}

class _PostLocationWidgetState extends State<PostLocationWidget>
    with WidgetsBindingObserver {
  PostLocationBloc postLocationBloc;
  final Widget _child;

  _PostLocationWidgetState(this._child);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    postLocationBloc = BlocProvider.of<PostLocationBloc>(context);
    postLocationBloc?.dispatch(StartPostLocationEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    postLocationBloc?.dispatch(StopPostLocationEvent());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      postLocationBloc?.dispatch(StopPostLocationEvent());
    } else if (state == AppLifecycleState.resumed) {
      postLocationBloc?.dispatch(StartPostLocationEvent());
    }
  }

  @override
  Widget build(BuildContext context) => _child;
}
