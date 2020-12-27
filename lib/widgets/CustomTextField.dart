import 'package:buyit/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  // ignore: missing_return
  String _errorMsg(String str) {
    switch (hint) {
      case "Enter your name":
        return "Name is Empty";
      case "Enter your email":
        return "Email is Empty";
      case "Enter your password":
        return "Password is Empty";
    }
  }

  CustomTextField({@required this.onClick, @required this.hint, this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return _errorMsg(hint);
          }
        },
        onSaved: onClick,
        obscureText: hint == "Enter your password" ? true : false,
        cursorColor: kMainColor,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          filled: true,
          fillColor: kSecondryColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
