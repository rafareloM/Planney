// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      'categories': categories!.map((e) => e.toMap()).toList(),
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

  PlanneyUser copyWith({
    String? fullName,
    String? email,
    List<Category>? categories,
  }) {
    return PlanneyUser(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      categories: categories ?? this.categories,
    );
  }
}
