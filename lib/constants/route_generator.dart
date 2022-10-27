import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/views/home_view.dart';
import 'package:flutter_projects/views/signup_view.dart';
import 'package:flutter_projects/views/signup_workspace_view.dart';
import 'package:flutter_projects/views/welcome_view.dart';

class RouteGenerator extends NavigatorObserver {
  static List<Route> routeStack = [];
  static int transitionDuration = 300; // Milliseconds - The default duration
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteNames.signUpView:
        var r = MaterialPageRoute(builder: (_) => const SignupView(), settings: settings);
        addToStack(r);
        return r;
      case RouteNames.signUpWorkSpaceView:
        var r =
        MaterialPageRoute(builder: (_) => SignupWorkSpaceView(), settings: settings);
        addToStack(r);
        return r;
      case RouteNames.welcomeView:
        var r =
        MaterialPageRoute(builder: (_) => WelcomeView(), settings: settings);
        addToStack(r);
        return r;
      case RouteNames.homeView:
        var r =
        MaterialPageRoute(builder: (_) => const HomeView(), settings: settings);
        addToStack(r);
        return r;
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: MaterialButton(
            child: const Text('ERROR'),
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ),
      );
    });
  }

  static void addToStack(MaterialPageRoute route) {
    routeStack.add(route);
    if (kDebugMode) {
      print('PUSHED A NEW ROUTE :${route.settings.name ?? 'UNKNOWN'}');
    }
    printStackCount();
  }

  static void addToStackExplicitly(Route r) {
    routeStack.add(r);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    try {
      if (route is DialogRoute || route is PopupRoute) {
        return;
      }
      routeStack.removeLast();
      print('REMOVED A ROUTE :${route.settings.name ?? 'UNKNOWN'}');
      printStackCount();
      super.didPop(route, previousRoute);
    } catch (e) {
      print('ROUTE GENERATOR EXCEPTION ${e.toString()}');
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    try {
      routeStack.removeLast();
      routeStack.add(newRoute!);
      print(
          'REPLACED A ROUTE :${newRoute.settings.name ?? 'UNKNOWN'} WITH ${oldRoute?.settings.name ?? 'UNKNOWN'}');
      printStackCount();
    } catch (e) {
      print('ROUTE GENERATOR EXCEPTION ${e.toString()}');
    }
  }

  static void printStackCount() {
    print('STACK LENGTH IS :${routeStack.length}');
  }

  static bool hasThisRoute(String routeName) {
    bool hasTheRoute = false;
    for (var route in routeStack) {
      if (route.settings.name == routeName) {
        hasTheRoute = true;
        break;
      }
    }
    return hasTheRoute;
  }

  static void handleFlowBackButton(String desiredRoute, BuildContext context) {
    if (hasThisRoute(desiredRoute)) {
      Navigator.of(context).pop();
    } else {
      Navigator.popAndPushNamed(context, desiredRoute,
          arguments: <String, bool>{'quick': true});
    }
  }
}

class RouteNames {
  static const signUpView = '/signup_view';
  static const signUpWorkSpaceView = '/signup_workspace_view';
  static const welcomeView = '/welcome_view';
  static const homeView ='/home_view';
 }

class CustomMaterialRoute extends MaterialPageRoute {
  CustomMaterialRoute({builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 20);
}
