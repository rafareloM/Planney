import 'package:flutter/material.dart';
import 'package:planney/extensions/extensions_string.dart';
import 'package:planney/model/user_credential.dart';
import 'package:planney/strings.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/components/planney_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _canShowPassword = false;
  String _email = '';
  String _password = '';

  UserCredential? _userCredential;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppStyle.backgroundBuyColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceHeight * 0.15,
                ),
                const PlanneyLogo(),
                SizedBox(height: deviceHeight * 0.1),
                SizedBox(
                  width: deviceWidth * 0.9,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppStyle.button1Color,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12.5),
                        ),
                      ),
                      labelText: Strings.LOGIN_FORM_EMAIL_LABEL,
                      labelStyle: TextStyle(
                          color: AppStyle.backgroundBuyColor, fontSize: 18),
                      errorStyle: TextStyle(
                          color: AppStyle.cardBackgroundColor, fontSize: 14),
                      fillColor: AppStyle.cardBackgroundColor,
                      filled: true,
                    ),
                    validator: ((value) {
                      if (!value!.isValidEmail) {
                        return Strings.LOGIN_FORM_EMAIL_ERROR;
                      }
                      return null;
                    }),
                    onSaved: (newValue) => _email = newValue!,
                  ),
                ),
                SizedBox(height: deviceHeight * 0.04),
                SizedBox(
                  width: deviceWidth * 0.9,
                  child: TextFormField(
                    obscureText: !_canShowPassword,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppStyle.button1Color,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(12.5),
                        ),
                      ),
                      labelText: Strings.LOGIN_FORM_PASSWORD_LABEL,
                      labelStyle: TextStyle(color: AppStyle.backgroundBuyColor),
                      helperText: Strings.LOGIN_FORM_PASSWORD_HELPER,
                      helperStyle: TextStyle(
                          color: AppStyle.cardBackgroundColor, fontSize: 14),
                      fillColor: AppStyle.cardBackgroundColor,
                      errorStyle: TextStyle(
                          color: AppStyle.cardBackgroundColor, fontSize: 14),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              _canShowPassword = !_canShowPassword;
                            },
                          );
                        },
                        icon: Icon(_canShowPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: ((value) {
                      if (!value!.isValidPassword) {
                        return Strings.LOGIN_FORM_PASSWORD_ERROR;
                      }
                      return null;
                    }),
                    onSaved: (newValue) => _password = newValue!,
                  ),
                ),
                SizedBox(height: deviceHeight * 0.08),
                SizedBox(
                  width: deviceWidth * 0.9,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppStyle.button1Color),
                        foregroundColor: MaterialStateProperty.all(
                            AppStyle.backgroundBuyColor)),
                    child: const Text(
                      Strings.LOGIN_BUTTON_ENTER,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
