import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mask/mask/mask.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/style/style.dart';
import 'package:planney/ui/components/adaptative/adaptative_app_bar.dart';
import 'package:planney/ui/components/custom_alert_dialog.dart';
import 'package:planney/ui/components/home/my_drawer.dart';
import 'package:planney/ui/components/progress_dialog.dart';
import 'package:planney/ui/controller/profile_page.controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();
  final ProfilePageController _controller = GetIt.instance.get();

  @override
  Widget build(BuildContext context) {
    final userStore = GetIt.instance.get<PlanneyUserStore>();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    bool isDark = colorScheme.brightness == Brightness.dark ? true : false;
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AdaptativeAppBar.fromBrightness(colorScheme.brightness),
      body: Observer(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.05,
                width: deviceWidth,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Editar foto de Perfil:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          isDark ? colorScheme.onBackground : colorScheme.primary),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          iconSize: 36,
                                          onPressed: () {
                                            _controller.galeryImage();
                                            Navigator.pop(navigatorKey.currentContext!);
                                          },
                                          icon: Icon(
                                            Icons.image,
                                            color: colorScheme.primary,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Galeria',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: isDark
                                                    ? colorScheme.onBackground
                                                    : colorScheme.primary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          iconSize: 36,
                                          onPressed: () async {
                                            await _controller.cameraImage();
                                            Navigator.pop(navigatorKey.currentContext!);
                                          },
                                          icon: Icon(
                                            Icons.camera_alt,
                                            color: colorScheme.primary,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Câmera',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: isDark
                                                    ? colorScheme.onBackground
                                                    : colorScheme.primary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                iconSize: 120,
                icon: CircleAvatar(
                    backgroundColor: colorScheme.brightness == Brightness.dark
                        ? AppStyle.graytextbox
                        : colorScheme.primary,
                    radius: 80,
                    child: userStore.user?.photoURL == null && _controller.profilePhoto == null
                        ? const Icon(
                            Icons.person,
                            size: 100,
                            color: Color.fromARGB(255, 211, 209, 209),
                          )
                        : userStore.user?.photoURL == null && _controller.profilePhoto != null ||
                                _controller.profilePhoto != null && _controller.profilePhoto != null
                            ? ClipOval(
                                child: Image.file(
                                _controller.profilePhoto!,
                                fit: BoxFit.fill,
                                height: 150,
                                width: 150,
                              ))
                            : ClipOval(
                                child: Image.network(
                                userStore.user!.photoURL!,
                                fit: BoxFit.fill,
                                height: 150,
                                width: 150,
                              ))),
              ),
              SizedBox(
                height: deviceHeight * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05, vertical: 2),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Nome',
                    style: TextStyle(
                        color: isDark ? colorScheme.onBackground : colorScheme.tertiary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.05,
                width: deviceWidth * 0.9,
                child: TextFormField(
                  onChanged: _controller.changeName,
                  decoration: InputDecoration(
                    hintText: userStore.planneyUser?.fullName ?? "",
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, style: BorderStyle.none),
                    ),
                    errorStyle: const TextStyle(
                      fontSize: 14,
                    ),
                    filled: false,
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05, vertical: 2),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                        color: isDark ? colorScheme.onBackground : colorScheme.tertiary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.05,
                width: deviceWidth * 0.9,
                child: TextFormField(
                  validator: Mask.validations.email,
                  onChanged: _controller.changeEmail,
                  decoration: InputDecoration(
                    hintText: userStore.email,
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, style: BorderStyle.none),
                    ),
                    errorStyle: const TextStyle(
                      fontSize: 14,
                    ),
                    filled: false,
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05, vertical: 2),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Senha',
                    style: TextStyle(
                        color: isDark ? colorScheme.onBackground : colorScheme.tertiary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.05,
                width: deviceWidth * 0.9,
                child: Observer(builder: (_) {
                  return TextFormField(
                    obscureText: _controller.canShowPassword,
                    onChanged: _controller.changePassword,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, style: BorderStyle.none),
                      ),
                      errorStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      filled: false,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _controller.setShowPassword();
                        },
                        icon: Icon(
                            _controller.canShowPassword ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.only(left: deviceWidth * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Observer(
                    builder: (context) {
                      return TextButton(
                        onPressed: () {
                          _controller.showChangePassword = !_controller.showChangePassword;
                        },
                        child: const Text(
                          'Alterar Senha',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              _controller.showChangePassword
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05, vertical: 2),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Nova Senha',
                          style: TextStyle(
                              color: isDark ? colorScheme.onBackground : colorScheme.tertiary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : const SizedBox(),
              _controller.showChangePassword
                  ? Padding(
                      padding: EdgeInsets.only(bottom: deviceHeight * 0.0143),
                      child: SizedBox(
                        height: deviceHeight * 0.05,
                        width: deviceWidth * 0.9,
                        child: TextFormField(
                          onChanged: _controller.changeName,
                          obscureText: _controller.canShowNewPassword,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(width: 1, style: BorderStyle.none),
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 14,
                            ),
                            filled: false,
                            suffixIcon: Observer(builder: (context) {
                              return IconButton(
                                onPressed: () {
                                  _controller.setShowNewPassword();
                                },
                                icon: Icon(_controller.canShowNewPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              );
                            }),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: deviceHeight * 0.1,
                    ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)))),
                onPressed: () async {
                  await _updateUser();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 36),
                  child: Text(
                    'Salvar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                width: deviceWidth * 0.1,
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
            ],
          ),
        );
      }),
    );
  }

  _updateUser() async {
    _progressDialog.show("Atualizando...");
    try {
      final response = await _controller.updateUser();
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
