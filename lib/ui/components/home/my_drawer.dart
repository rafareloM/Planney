import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/controller/profile_page.controller.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _controller = GetIt.instance.get<HomePageController>();

  @override
  Widget build(BuildContext context) {
    final userStore = GetIt.instance.get<PlanneyUserStore>();
    final controller = GetIt.instance.get<HomePageController>();
    final ProfilePageController profilePageController = GetIt.instance.get();
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
            accountEmail: Text(userStore.email ?? ''),
            accountName:
                Text(userStore.planneyUser?.fullName.split(' ').first ?? ''),
            currentAccountPicture: CircleAvatar(
                radius: 40,
                child: userStore.user?.photoURL == null &&
                        profilePageController.profilePhoto == null
                    ? const Icon(
                        Icons.person,
                        size: 100,
                        color: Color.fromARGB(255, 211, 209, 209),
                      )
                    : userStore.user?.photoURL == null &&
                                profilePageController.profilePhoto != null ||
                            profilePageController.profilePhoto != null &&
                                profilePageController.profilePhoto != null
                        ? ClipOval(
                            child: Image.file(
                            profilePageController.profilePhoto!,
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
              Navigator.pushReplacementNamed(
                navigatorKey.currentContext!,
                '/',
              );
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
              Navigator.popAndPushNamed(context, '/relatory');
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
              Icons.account_circle_rounded,
              color: buttonColor,
            ),
            title: Text(
              'Perfil',
              style: TextStyle(color: buttonColor),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/profile');
            },
          ),
          ListTile(
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
          ),
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
    Navigator.pushNamedAndRemoveUntil(
      navigatorKey.currentContext!,
      '/loginPage',
      (route) => false,
    );
  }
}
