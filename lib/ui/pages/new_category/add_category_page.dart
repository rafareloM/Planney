import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/navigator_key.dart';
import 'package:planney/ui/controller/add_category.controller.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/pages/transaction/components/category_button.dart';
import 'package:planney/ui/pages/transaction/components/text_form.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    final AddCategoryPageController controller = GetIt.instance.get();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? colorScheme.background
            : colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: const Text('NOVA CATEGORIA'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: deviceHeight * 0.8,
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    primary: false,
                    shrinkWrap: false,
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemCount: CategoryHelper.icons.length,
                    itemBuilder: (context, index) {
                      return CategoryHelper.icons
                          .map((e) => Observer(builder: (context) {
                                return CategoryButton(
                                  onPressed: () {
                                    controller.selectIcon(e);
                                  },
                                  icon: IconData(e.icon!.codePoint,
                                      fontFamily: 'MaterialIcons'),
                                  color: controller.selectedIcon == e
                                      ? controller.color
                                      : colorScheme.brightness ==
                                              Brightness.dark
                                          ? colorScheme.onBackground
                                          : colorScheme.tertiary,
                                  name: '',
                                  paintBackground: false,
                                );
                              }))
                          .toList()[index];
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(32, 17, 0, 0),
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
                        padding:
                            EdgeInsets.fromLTRB(32, 10, deviceWidth * 0.1, 0),
                        child: TextForm(
                          height: deviceHeight * 0.05,
                          hint: 'Dê um nome à categoria',
                          hintFontSize: 14,
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
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Observer(builder: (context) {
                            return ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder())),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: colorScheme.background,
                                      title: const Text('Escolha a cor'),
                                      content: IntrinsicHeight(
                                        child: BlockPicker(
                                          pickerColor:
                                              controller.color, //default color
                                          onColorChanged: (Color color) {
                                            controller.selectColor(color);
                                          },
                                        ),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  navigatorKey.currentContext!);
                                            },
                                            child: const Text('Voltar'))
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 42,
                                decoration: BoxDecoration(
                                  color: controller.color,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(29)))),
                        onPressed: () async {
                          await controller.registerCategory(GetIt.instance
                              .get<HomePageController>()
                              .isExpence);
                          Navigator.pop(navigatorKey.currentContext!);
                        },
                        child: const Text('Adicionar Categoria'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
