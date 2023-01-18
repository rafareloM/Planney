import 'package:planney/model/api_response.model.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/model/planney_user.dart';

abstract class PlanneyUserRepository {
  Future<APIResponse<PlanneyUser>> get();
  Future<APIResponse<PlanneyUser>> update(PlanneyUser newProfile);
  Future<APIResponse<List<Category>>> getCategories();
}
