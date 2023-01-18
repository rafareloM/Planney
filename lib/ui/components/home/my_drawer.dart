import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/stores/category.store.dart';
import 'package:planney/ui/controller/home.controller.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _controller = GetIt.instance.get<HomePageController>();

  @override
  Widget build(BuildContext context) {
    final store = GetIt.instance.get<CategoryStore>();
    final controller = GetIt.instance.get<HomePageController>();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color buttonColor =
        Theme.of(context).colorScheme.brightness == Brightness.dark
            ? colorScheme.onBackground
            : colorScheme.primary;
    return Drawer(
      backgroundColor: colorScheme.background,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountEmail: const Text('marilene@gmail.com'),
            accountName: const Text('Marilene'),
            currentAccountPicture: ClipOval(
                child: Image.asset(
              'lib/style/assets/img/userprofile.png',
              width: 20,
              height: 20,
            )),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: buttonColor,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: buttonColor),
            ),
            onTap: () {
              store.getCategoriesByType(false);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.graphic_eq,
              color: buttonColor,
            ),
            title: Text(
              'Relatório',
              style: TextStyle(color: buttonColor),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.drive_folder_upload_rounded,
              color: buttonColor,
            ),
            title: Text(
              'Categorias',
              style: TextStyle(color: buttonColor),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/detailPage');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.mail,
              color: buttonColor,
            ),
            title: Text(
              'Fale conosco',
              style: TextStyle(color: buttonColor),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Builder(builder: (context) {
            return Observer(builder: (context) {
              return ListTile(
                trailing: Switch(
                  value: colorScheme.brightness == Brightness.dark,
                  onChanged: (value) {
                    controller.changeAppTheme();
                  },
                  activeColor: colorScheme.primary,
                ),
                title: Text(
                  colorScheme.brightness == Brightness.dark
                      ? 'Desativar modo Dark'
                      : 'Ativar modo Dark',
                  style: TextStyle(color: buttonColor),
                ),
                onTap: () {
                  controller.changeAppTheme();
                },
              );
            });
          }),
          const Expanded(
            child: SizedBox(),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: buttonColor,
            ),
            title: Text(
              'Sair',
              style: TextStyle(color: buttonColor),
            ),
            onTap: doLogout,
          ),
        ],
      ),
    );
  }

  doLogout() async {
    await _controller.logout();
    Navigator.pushReplacementNamed(navigatorKey.currentContext!, '/loginPage');
  }
}
