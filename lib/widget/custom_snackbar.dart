import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar({context,String? message}){
   final snackBar = SnackBar(
    duration: const Duration(seconds: 1),
  content: Text('$message!'),
);
  return   ScaffoldMessenger.of(context).showSnackBar(snackBar);
}