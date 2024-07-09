import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar({BuildContext? context, String? message}) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: 2),
    content: Text('$message!'),
  );
  return ScaffoldMessenger.of(context!).showSnackBar(snackBar);
}
