import 'package:planney/model/category.model.dart';

class PlanneyUser {
  String fullName = "";
  String email = "";
  List<Category>? categories = CategoryHelper.defaultCategories;

  bool get isValid => fullName.isNotEmpty;

  PlanneyUser({
    this.fullName = "",
    this.email = "",
    this.categories,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'categories': categories!.map((e) => e.toMap()),
    };
  }

  factory PlanneyUser.fromFirestore(Map<String, dynamic> map) {
    return PlanneyUser(
      fullName: map['full_name'] ?? '',
      email: map['email'] ?? '',
      categories: List<Category>.from(
          map['categories'].map((x) => Category.fromFirestore(x))),
    );
  }
}
