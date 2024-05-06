import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/ui/components/adaptative/adaptative_app_bar.dart';
import 'package:planney/ui/components/custom_alert_dialog.dart';
import 'package:planney/ui/components/progress_dialog.dart';
import 'package:planney/ui/controller/add_category.controller.dart';
import 'package:planney/ui/controller/home.controller.dart';

class AddCategoryPage extends StatelessWidget {
  AddCategoryPage({super.key});

  final _progressDialog = ProgressDialog();
  final _alertDialog = CustomAlertDialog();
  final controller = GetIt.instance.get<AddCategoryPageController>();
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AdaptativeAppBar.fromBrightness(
        colorScheme.brightness,
        title: "NOVA CATEGORIA",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: deviceHeight * 0.8,
            child: Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 2),
                        itemCount: CategoryHelper.icons.length,
                        itemBuilder: (context, index) {
                          return CategoryHelper.icons
                              .map((e) => Observer(builder: (context) {
                                    return IconButton(
                                      iconSize: 42,
                                      onPressed: () {
                                        controller.selectIcon(e);
                                      },
                                      icon: Icon(
                                        e.icon,
                                      ),
                                      color: controller.selectedIcon == e
                                          ? controller.color
                                          : colorScheme.brightness == Brightness.dark
                                              ? colorScheme.onBackground
                                              : colorScheme.tertiary,
                                    );
                                  }))
                              .toList()[index];
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 32),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'NOME DA CATEGORIA',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
                        child: SizedBox(
                            height: deviceHeight * 0.025,
                            child: TextField(
                                onChanged: (value) => controller.changeCategoryName(value),
                                decoration: const InputDecoration(
                                    hintText: 'Escolha um nome',
                                    hintStyle: TextStyle(fontSize: 16)),
                                textAlignVertical: TextAlignVertical.bottom,
                                style: const TextStyle(
                                  fontSize: 16,
                                ))
                            // TextFormField(
                            //   onChanged: (value) =>
                            //       controller.changeCategoryName(value),
                            //   textAlignVertical: TextAlignVertical.bottom,
                            //   style: TextStyle(
                            //     fontSize: 12,
                            //   ),
                            //   expands: true,
                            //   maxLines: null,
                            //   decoration: InputDecoration(
                            //       hintText: 'Escolha um nome',
                            //       hintStyle: TextStyle(fontSize: 12)),
                            // ),
                            ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(32, 17, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ESCOLHA A COR',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Observer(builder: (context) {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.circle,
                                color: controller.color,
                              ),
                              iconSize: 42,
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(const CircleBorder())),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: colorScheme.background,
                                      title: const Text('Escolha a cor'),
                                      content: IntrinsicHeight(
                                        child: BlockPicker(
                                          pickerColor: controller.color, //default color
                                          onColorChanged: (Color color) {
                                            controller.selectColor(color);
                                          },
                                        ),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(navigatorKey.currentContext!);
                                            },
                                            child: const Text('Voltar'))
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          }),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)))),
                        onPressed: () async {
                          await controller
                              .registerCategory(GetIt.instance.get<HomePageController>().isExpence);
                          Navigator.pop(navigatorKey.currentContext!);
                        },
                        child: const Text('Adicionar Categoria'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  registerTransaction() async {
    _progressDialog.show("Salvando...");

    try {
      final response =
          await controller.registerCategory(GetIt.instance.get<HomePageController>().isExpence);
      if (response.isSuccess) {
        Navigator.pop(
          navigatorKey.currentContext!,
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
