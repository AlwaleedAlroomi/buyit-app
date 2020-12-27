import 'package:buyit/constants.dart';
import 'package:buyit/provider/modelHud.dart';
import 'package:buyit/screens/login_screen.dart';
import 'package:buyit/widgets/CustomLogo.dart';
import 'package:buyit/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:buyit/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = "SignupScreen";
  String _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<ModelHud>(
      create: (context) => ModelHud(),
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Builder(
          builder: (BuildContext context) => ModalProgressHUD(
            inAsyncCall: Provider.of<ModelHud>(context).isLoading,
            child: Form(
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
                    child: Builder(
                      builder: (context) => FlatButton(
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
                          final modelhud =
                              Provider.of<ModelHud>(context, listen: false);
                          modelhud.changeisLoading(true);
                          if (_globalKey.currentState.validate()) {
                            _globalKey.currentState.save();
                            try {
                              // ignore: unused_local_variable
                              final authResult = await _auth.signUp(
                                  _email.trim(), _password.trim());
                              modelhud.changeisLoading(false);
                            } on PlatformException catch (e) {
                              modelhud.changeisLoading(false);
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.message),
                                ),
                              );
                            } catch (error) {
                              modelhud.changeisLoading(false);
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error.message),
                                ),
                              );
                            }
                          }
                          modelhud.changeisLoading(false);
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
          ),
        ),
      ),
    );
  }
}
