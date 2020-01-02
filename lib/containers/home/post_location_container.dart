import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/post_location_actions.dart';
import 'package:tgg/redux_model/app_state.dart';

class PostLocationContainer extends StatefulWidget {
  final WidgetBuilder widgetBuilder;

  const PostLocationContainer({Key key, this.widgetBuilder}) : super(key: key);

  @override
  State createState() => _PostLocationWidgetState();
}

class _PostLocationWidgetState extends State<PostLocationContainer>
    with WidgetsBindingObserver {
  Store _store;

  WidgetBuilder get widgetBuilder => widget.widgetBuilder;

  @override
  void initState() {
    super.initState();
    _store = StoreProvider.of<AppState>(context, listen: false);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stopPostLocation();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      stopPostLocation();
    } else if (state == AppLifecycleState.resumed) {
      startPostLocation();
    }
  }

  void stopPostLocation() {
    final timer = (_store.state as AppState).postLocationTimer;
    if (timer != null) {
      _store?.dispatch(StopPostingLocation(timer));
    }
  }

  void startPostLocation() {
    final timer = (_store.state as AppState).postLocationTimer;
    if (timer == null) {
      _store?.dispatch(StartPostingLocation());
    }
  }

  @override
  Widget build(BuildContext context) => widgetBuilder(context);
}
