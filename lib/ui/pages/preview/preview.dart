import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

import '../../keys.dart';
import 'bloc.dart';

const Color defaultBackground = Colors.black38;
const double rowHeight = 48;

class PreviewPage extends StatelessWidget {
  PreviewPage({Key key}) : super(key: Keys.previewPage);
  static const routeName = '/previewImage';

  @override
  Widget build(BuildContext context) {
    ImagePreviewArguments args = ModalRoute.of(context).settings.arguments;
    final bloc = PreviewBloc()..dispatch(InitializePreviewEvent(args: args));
    return BlocProvider(
      builder: (context) => bloc,
      child: buildPreview(bloc),
    );
  }

  Widget buildPreview(PreviewBloc bloc) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<PreviewBloc, PreviewState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is ImagePreviewState)
              return ImagePreview(
                key: Keys.previewImagePage,
                imageLink: state.link,
              );
            if (state is VideoPreviewState)
              return VideoPreview(
                key: Keys.previewVideoPage,
                videoLink: state.link,
                screenRotation: state.screenRotation,
              );
            return Container();
          },
        ),
      ),
    );
  }
}
