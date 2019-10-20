import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/bloc/aws_upload/bloc.dart';
import 'package:tgg/ui/colors.dart';

class AwsUploadWidget extends StatelessWidget {
  final WidgetBuilder widgetBuilder;

  const AwsUploadWidget({Key key, @required this.widgetBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[_UploadProgress(), widgetBuilder(context)],
    );
  }
}

class _UploadProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AwsUploadBloc>(context);
    return BlocBuilder<AwsUploadBloc, AwsUploadState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is UploadingAwsUploadState && state.count > 0) {
          return SizedBox.fromSize(
              size: Size.fromHeight(18),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  LinearProgressIndicator(
                    value: state.progress,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(ORANGE)),
                    backgroundColor: Colors.transparent,
                  ),
                  Center(
                    child: Text(
                      "${state.current}/${state.count}",
                      style: defaultTextStyle,
                    ),
                  )
                ],
              ));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
