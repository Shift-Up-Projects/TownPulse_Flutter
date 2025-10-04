import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void ShowToast({required String message,required toastState state}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: _choseColorState(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum toastState{
  success,error,warning
}

Color _choseColorState(toastState state){
  Color color;
  switch(state){
    case toastState.success:
      color=Colors.green;
      break;
    case toastState.error:
      color=Colors.red;
      break;
    case toastState.warning:
      color=Colors.amber;
      break;
  }
  return color;
}