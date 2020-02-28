import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tinycolor/tinycolor.dart';

import 'theme_config.dart';

class ThemedApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget home;
  final Map<String, WidgetBuilder> routes;
  final String initialRoute;
  final RouteFactory onGenerateRoute;
  final RouteFactory onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;
  final TransitionBuilder builder;
  final String title;
  final GenerateAppTitle onGenerateTitle;
  final Color color;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final LocaleListResolutionCallback localeListResolutionCallback;
  final LocaleResolutionCallback localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;

  ThemedApp({
    Key key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
  });

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          /*  SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(statusBarColor: vm.primaryDark));*/
          return new MaterialApp(
            navigatorKey: navigatorKey,
            home: home,
            routes: routes,
            initialRoute: initialRoute,
            onGenerateRoute: onGenerateRoute,
            onUnknownRoute: onUnknownRoute,
            navigatorObservers: navigatorObservers,
            builder: builder,
            title: title,
            onGenerateTitle: onGenerateTitle,
            color: color,
            theme: ThemeData(
                primaryColor: vm.primary,
                primaryColorDark: vm.primaryDark,
                primaryColorLight: vm.primaryLight,
                scaffoldBackgroundColor: vm.background,
                backgroundColor: vm.background,
                textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: vm.textColor, displayColor: vm.textColor)),
            darkTheme: darkTheme,
            themeMode: themeMode,
            locale: locale,
            localizationsDelegates: localizationsDelegates,
            localeListResolutionCallback: localeListResolutionCallback,
            localeResolutionCallback: localeResolutionCallback,
            supportedLocales: supportedLocales,
            debugShowMaterialGrid: debugShowMaterialGrid,
            showPerformanceOverlay: showPerformanceOverlay,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers,
            showSemanticsDebugger: showSemanticsDebugger,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          );
        });
  }
}

class _ViewModel {
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color background;
  final Color textColor;

  _ViewModel({
    @required this.primary,
    @required this.primaryDark,
    @required this.primaryLight,
    @required this.background,
    @required this.textColor,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final primary = TinyColor(themeConfig.primary);
    return new _ViewModel(
        primary: primary.color,
        primaryDark: primary.darken(10).color,
        primaryLight: primary.lighten(10).color,
        background: themeConfig.background,
        textColor: themeConfig.fontColor);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          background == other.background;

  @override
  int get hashCode => primary.hashCode ^ background.hashCode;
}
