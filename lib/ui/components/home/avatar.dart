import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/stores/planney_user.store.dart';
import 'package:planney/ui/controller/profile_page.controller.dart';

class Avatar extends StatelessWidget {
  final String? userName;
  final double userBalance;
  final String? path;
  const Avatar(
      {super.key,
      required this.userName,
      required this.userBalance,
      required this.path});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    final userStore = GetIt.instance.get<PlanneyUserStore>();
    final ProfilePageController controller = GetIt.instance.get();

    Color spanTextColor = colorScheme.tertiary;

    return SizedBox(
      width: double.maxFinite,
      height: 160,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(21))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 40,
                      child: userStore.user?.photoURL == null &&
                              controller.profilePhoto == null
                          ? const Icon(
                              Icons.person,
                              size: 70,
                              color: Color.fromARGB(255, 211, 209, 209),
                            )
                          : userStore.user?.photoURL == null &&
                                      controller.profilePhoto != null ||
                                  controller.profilePhoto != null &&
                                      controller.profilePhoto != null
                              ? ClipOval(
                                  child: Image.file(
                                  controller.profilePhoto!,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text.rich(
                          TextSpan(
                            text: "Olá, ",
                            style: const TextStyle(fontSize: 28),
                            children: [
                              TextSpan(
                                text: "$userName!",
                                style: TextStyle(
                                    color: spanTextColor, fontSize: 28),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'O seu balanço atual é:',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "R\$ ${userBalance.toStringAsFixed(2).replaceAll('.', ',')}",
              style: TextStyle(
                  color: userBalance >= 0 ? spanTextColor : Colors.redAccent,
                  fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
