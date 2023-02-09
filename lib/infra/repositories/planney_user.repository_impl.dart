import 'package:planney/infra/repositories/planney_user.repository.dart';
import 'package:planney/infra/services/planney_user.service.dart';
import 'package:planney/model/category.model.dart';
import 'package:planney/model/planney_user.dart';
import 'package:planney/model/api_response.model.dart';

class PlanneyUserRepositoryImpl implements PlanneyUserRepository {
  final PlanneyUserService _service;

  PlanneyUserRepositoryImpl(this._service);

  @override
  Future<APIResponse<PlanneyUser>> get() async {
    final documentSnapshot = await _service.get();
    if (documentSnapshot != null) {
      final planneyUser = PlanneyUser.fromFirestore(
          documentSnapshot.data() as Map<String, dynamic>);

      return APIResponse.success(planneyUser);
    } else {
      return APIResponse.error("Deu ruim mano");
    }
  }

  @override
  Future<APIResponse<PlanneyUser>> update(PlanneyUser newProfile) async {
    final response = await _service.update(newProfile.toMap());
    if (response) {
      return APIResponse.success(newProfile);
    } else {
      return APIResponse.error('Ops! Falha na atualização');
    }
  }

  @override
  Future<APIResponse<List<Category>>> getCategories() async {
    final documentSnapshot = await _service.get();
    if (documentSnapshot != null) {
      final planneyUser = PlanneyUser.fromFirestore(
          documentSnapshot.data() as Map<String, dynamic>);
      return APIResponse.success(planneyUser.categories);
    } else {
      return APIResponse.error("Deu ruim mano");
    }
  }
}
