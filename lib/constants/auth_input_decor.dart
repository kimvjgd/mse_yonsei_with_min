import 'package:flutter/material.dart';


InputDecoration textInputDecor(String hint) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.transparent,
    hintText: hint,
    hintStyle: TextStyle(color: Colors.white38),
    enabledBorder: _enaleBorder(),
    focusedBorder: _focusBorder(),
    errorBorder: _errorBorder(),
    focusedErrorBorder: _focusedErrorBorder(),
  );
}

OutlineInputBorder _enaleBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
      ),
      borderRadius: BorderRadius.circular(30));
}
OutlineInputBorder _focusBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(30));
}
OutlineInputBorder _errorBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(30));
}
OutlineInputBorder _focusedErrorBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.redAccent,
      ),
      borderRadius: BorderRadius.circular(30));
}