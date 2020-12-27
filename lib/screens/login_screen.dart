import 'package:buyit/constants.dart';
import 'package:buyit/provider/adminMode.dart';
import 'package:buyit/provider/modelHud.dart';
import 'package:buyit/screens/admin/AdminHome.dart';
import 'package:buyit/screens/user/HomePage.dart';
import 'package:buyit/screens/signup_screen.dart';
import 'package:buyit/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:buyit/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  static String id = 'LoginScreen';
  String _email, _password;
  final _auth = Auth();
  bool isAdmin = false;
  final adminPassword = "Admin1234";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/icons/buyit.png"),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'Buy it',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
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
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.black,
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      _validate(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don\'t have an account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeisAdmin(true);
                        },
                        child: Text(
                          "I\'m an admin.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? kMainColor
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeisAdmin(false);
                        },
                        child: Text(
                          "I\'m a user",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin
                                  ? Colors.white
                                  : kMainColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.signIp(_email.trim(), _password.trim());
            Navigator.pushNamed(context, AdminHomeScreen.id);
          } catch (e) {
            modelhud.changeisLoading(false);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message),
              ),
            );
          }
        } else {
          modelhud.changeisLoading(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Something went wrong!"),
            ),
          );
        }
      } else {
        try {
          await _auth.signIp(_email.trim(), _password.trim());
          Navigator.pushNamed(context, HomePageScreen.id);
        } catch (e) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
        }
      }
    }
    modelhud.changeisLoading(false);
  }
}
