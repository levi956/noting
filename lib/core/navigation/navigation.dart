import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool canPop(BuildContext context) {
  return Navigator.canPop(context);
}

Future<T?> pushTo<T>(
  BuildContext context,
  Widget page, {
  RouteSettings? settings,
}) async {
  switch (Platform.isIOS) {
    case true:
      return await Navigator.push<T>(
        context,
        CupertinoPageRoute(
          builder: (context) => page,
          settings: settings,
        ),
      );
    default:
      return await Navigator.push<T>(
        context,
        MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        ),
      );
  }
}

Future<T> pushReplacementTo<T>(
  BuildContext context,
  Widget page,
) async {
  return await Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void pushToAndClearStack(BuildContext context, Widget page) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page), (route) => false);
}

void pop<T>(BuildContext context, [T? value]) {
  return Navigator.pop<T>(context, value);
}

void pushNamed(BuildContext context, String name) {
  Navigator.of(context).pushNamed(name);
}

void pushReplacementNamed(BuildContext context, String name) {
  Navigator.of(context).pushReplacementNamed(name);
}

enum PushStyle { material, cupertino }
