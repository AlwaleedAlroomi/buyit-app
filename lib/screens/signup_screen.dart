import 'package:buyit/constants.dart';
import 'package:buyit/screens/login_screen.dart';
import 'package:buyit/widgets/CustomLogo.dart';
import 'package:buyit/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:buyit/services/auth.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = "SignupScreen";
  String _email, _password;
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            CustomLogo(),
            SizedBox(
              height: height * .1,
            ),
            CustomTextField(
              onClick: (value) {},
              hint: "Enter your name",
              icon: Icons.perm_identity,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              onClick: (value) {
                _email = value;
              },
              hint: "Enter your email",
              icon: Icons.email,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              onClick: (value) {
                _password = value;
              },
              hint: "Enter your password",
              icon: Icons.lock,
            ),
            SizedBox(
              height: height * .05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.black,
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (_globalKey.currentState.validate()) {
                    _globalKey.currentState.save();
                    print(_email);
                    print(_password);
                    final authResult = await _auth.signUp(_email, _password);
                    print(authResult.user.uid);
                  }
                },
              ),
            ),
            SizedBox(
              height: height * .05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
