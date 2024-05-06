import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/extensions/extensions_string.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/strings.dart';
import 'package:planney/ui/components/custom_alert_dialog.dart';
import 'package:planney/ui/components/login/planney_logo_login.dart';
import 'package:planney/ui/components/login/theme_select.dart';
import 'package:planney/ui/components/progress_dialog.dart';
import 'package:planney/ui/controller/login.controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController _controller = GetIt.instance.get<LoginController>();

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();

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
                height: deviceHeight * 0.2,
              ),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: deviceWidth),
                  child: const PlanneyLogoLogin(size: 52)),
              SizedBox(height: deviceHeight * 0.08),
              SizedBox(
                width: deviceWidth * 0.9,
                child: TextFormField(
                  onChanged: _controller.changeEmail,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, style: BorderStyle.solid),
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
                  validator: ((value) {
                    if (!value!.isValidEmail) {
                      return Strings.LOGIN_FORM_EMAIL_ERROR;
                    }
                    return null;
                  }),
                ),
              ),
              SizedBox(height: deviceHeight * 0.04),
              SizedBox(
                width: deviceWidth * 0.9,
                child: Observer(builder: (_) {
                  return TextFormField(
                    onChanged: _controller.changePassword,
                    obscureText: !_controller.canShowPassword,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, style: BorderStyle.solid),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(12.5),
                        ),
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
                          _controller.canShowPassword = !_controller.canShowPassword;
                        },
                        icon: Icon(
                            _controller.canShowPassword ? Icons.visibility : Icons.visibility_off),
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
              SizedBox(height: deviceHeight * 0.08),
              SizedBox(
                width: deviceWidth * 0.9,
                height: 48,
                child: ElevatedButton(
                  onPressed: _doLogin,
                  child: const Text(
                    Strings.LOGIN_BUTTON_ENTER,
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
                  const Text('Não Possui uma Conta?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registerPage');
                    },
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
              ThemeSelect.fromBrightness(Theme.of(context).colorScheme.brightness),
            ],
          ),
        ),
      ),
    );
  }

  _doLogin() async {
    _progressDialog.show("Autenticando...");

    try {
      final response = await _controller.login();

      if (response.isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          "/",
          (route) => false,
        );
      } else {
        _progressDialog.hide();
        _alertDialog.showInfo(title: "Ops!", message: response.message!);
      }
    } catch (e) {
      _progressDialog.hide();
      _alertDialog.showInfo(title: "Ops!", message: 'Algo deu errado!');
    }
  }
}
