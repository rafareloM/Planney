import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:planney/stores/category.store.dart';
import 'package:planney/ui/components/home/bottom_navigation_bar.dart';
import 'package:planney/ui/components/home/my_drawer.dart';
import 'package:planney/ui/components/transaction/list_view_button.dart';
import 'package:planney/ui/controller/home.controller.dart';
import 'package:planney/ui/pages/category_charts/views/charts_page.dart';
import 'package:planney/ui/pages/transaction/components/category_button.dart';

class DetailCategoryPage extends StatelessWidget {
  const DetailCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryStore categoryStore = GetIt.instance.get<CategoryStore>();
    final controller = GetIt.instance.get<HomePageController>();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color activeColor = Theme.of(context).brightness == Brightness.dark
        ? colorScheme.tertiary
        : colorScheme.primary;

    return Scaffold(
      extendBody: true,
      drawer: const MyDrawer(),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? colorScheme.background
            : colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: ConstrainedBox(
          constraints: BoxConstraints.tight(
            const Size(150, 32),
          ),
          child: const Text("CATEGORIAS"),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const HomeBottomNavigationBar(),
      body: Container(
        margin: const EdgeInsets.fromLTRB(16, 15, 16, 121),
        padding: const EdgeInsets.fromLTRB(0, 34, 0, 50),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: colorScheme.brightness == Brightness.dark
              ? const Color(0xFF454545)
              : colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              offset: Offset(2, 3),
              spreadRadius: 3,
              blurRadius: 7,
              color: Color.fromRGBO(0, 0, 0, 0.25),
            )
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Observer(
            builder: (_) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListViewButton(
                        onPressed: () {
                          controller.isExpence = true;
                        },
                        buttonLabel: 'Despesa',
                        buttonColor: controller.isExpence
                            ? activeColor
                            : colorScheme.brightness == Brightness.dark
                                ? colorScheme.onSurface
                                : colorScheme.tertiary,
                        dividerColor: controller.isExpence
                            ? colorScheme.brightness == Brightness.dark
                                ? colorScheme.tertiary
                                : colorScheme.primary
                            : Colors.transparent,
                      ),
                      ListViewButton(
                        onPressed: () {
                          controller.isExpence = false;
                        },
                        buttonLabel: 'Receita',
                        buttonColor: !controller.isExpence
                            ? activeColor
                            : colorScheme.brightness == Brightness.dark
                                ? colorScheme.onSurface
                                : colorScheme.tertiary,
                        dividerColor: !controller.isExpence
                            ? colorScheme.brightness == Brightness.dark
                                ? colorScheme.tertiary
                                : colorScheme.primary
                            : Colors.transparent,
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(4),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      primary: false,
                      shrinkWrap: false,
                      itemCount: categoryStore
                          .getCategoriesByType(controller.isExpence)
                          .length,
                      itemBuilder: (context, index) {
                        return categoryStore
                            .getCategoriesByType(controller.isExpence)
                            .map(
                          (e) {
                            return CategoryButton(
                              name: e.name.toUpperCase(),
                              color: colorScheme.primary,
                              icon: IconData(e.codePoint,
                                  fontFamily: "MaterialIcons"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoryChartsPage(
                                          categoryName: e.name,
                                          transactions: controller
                                              .getTransactionsByCategory(
                                                  e.name)),
                                    ));
                              },
                            );
                          },
                        ).toList()[index];
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
