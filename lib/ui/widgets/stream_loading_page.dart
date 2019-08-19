import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef DataLoadedClickCallback<T> = Widget Function(T data);

class StreamLoadingPage<T> extends StreamBuilder<T> {
  StreamLoadingPage(Stream<T> stream, DataLoadedClickCallback callback)
      : super(
            stream: stream,
            builder: (context, AsyncSnapshot<T> snapshot) {
              if (snapshot.hasData) {
                return callback(snapshot.data);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            });
}
