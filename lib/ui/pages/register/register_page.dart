import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mask/mask/mask.dart';

import 'package:planney/extensions/extensions_string.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/strings.dart';
import 'package:planney/ui/components/custom_alert_dialog.dart';
import 'package:planney/ui/components/login/planney_logo_login.dart';
import 'package:planney/ui/components/progress_dialog.dart';
import 'package:planney/ui/controller/register.controller.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController _controller =
      GetIt.instance.get<RegisterController>();

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: deviceHeight * 0.05,
              ),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: deviceWidth),
                  child: const PlanneyLogoLogin(size: 48)),
              SizedBox(height: deviceHeight * 0.04),
              SizedBox(
                width: deviceWidth * 0.9,
                child: TextFormField(
                  onChanged: _controller.changeEmail,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, style: BorderStyle.solid),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.5),
                      ),
                    ),
                    labelText: Strings.LOGIN_FORM_EMAIL_LABEL,
                    labelStyle: TextStyle(
                      fontSize: 18,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 14,
                    ),
                    filled: true,
                  ),
                  validator: Mask.validations.email,
                ),
              ),
              SizedBox(height: deviceHeight * 0.06),
              SizedBox(
                width: deviceWidth * 0.9,
                child: TextFormField(
                  onChanged: _controller.changeName,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, style: BorderStyle.solid),
                    ),
                    labelText: Strings.REGISTER_FORM_USERNAME_LABEL,
                    labelStyle: TextStyle(
                      fontSize: 18,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 14,
                    ),
                    filled: true,
                  ),
                  validator: ((value) {
                    if (value == '' || value == null) {
                      return Strings.REGISTER_FORM_USERNAME_ERROR;
                    }
                    return null;
                  }),
                ),
              ),
              SizedBox(height: deviceHeight * 0.06),
              SizedBox(
                width: deviceWidth * 0.9,
                child: Observer(builder: (_) {
                  return TextFormField(
                    onChanged: _controller.changePassword,
                    obscureText: !_controller.canShowPassword,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, style: BorderStyle.solid),
                      ),
                      labelText: Strings.LOGIN_FORM_PASSWORD_LABEL,
                      labelStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      helperText: Strings.LOGIN_FORM_PASSWORD_HELPER,
                      helperStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      errorStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _controller.canShowPassword =
                              !_controller.canShowPassword;
                        },
                        icon: Icon(_controller.canShowPassword
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
                  );
                }),
              ),
              SizedBox(height: deviceHeight * 0.04),
              SizedBox(
                width: deviceWidth * 0.9,
                child: Observer(builder: (_) {
                  return TextFormField(
                    onChanged: _controller.changeRepeatPassword,
                    obscureText: !_controller.canShowRepeatPassword,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, style: BorderStyle.solid),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(12.5),
                        ),
                      ),
                      labelText: Strings.REGISTER_FORM_REPEAT_PASSWORD_LABEL,
                      labelStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      helperText: Strings.REGISTE_FORM_REPEAT_PASSWORD_HELPER,
                      helperStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      errorStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _controller.canShowRepeatPassword =
                              !_controller.canShowRepeatPassword;
                        },
                        icon: Icon(_controller.canShowRepeatPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    validator: ((value) {
                      if (!value!.isValidPassword) {
                        return Strings.REGISTER_FORM_REPEAT_PASSWORD_ERROR;
                      }
                      return null;
                    }),
                  );
                }),
              ),
              SizedBox(height: deviceHeight * 0.04),
              SizedBox(
                width: deviceWidth * 0.9,
                height: 48,
                child: ElevatedButton(
                  onPressed: _doRegister,
                  child: const Text(
                    Strings.REGISTER_BUTTON_LABEL,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Já possui uma Conta?'),
                  TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/loginPage');
                      },
                      child: const Text(
                        'Fazer Login',
                        style: TextStyle(color: Colors.blueAccent),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _doRegister() async {
    _progressDialog.show("Cadastrando...");
    try {
      final response = await _controller.doRegister();
      if (response.isSuccess) {
        _progressDialog.hide();
        Navigator.pushReplacementNamed(navigatorKey.currentContext!, "/");
      } else {
        _progressDialog.hide();
        _alertDialog.showInfo(title: "Ops!", message: response.message!);
      }
    } catch (e) {
      _progressDialog.hide();
      _alertDialog.showInfo(title: "Ops!", message: "Ops Algo deu errado!");
    }
  }
}
