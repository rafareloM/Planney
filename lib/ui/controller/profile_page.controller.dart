import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:planney/model/api_response.model.dart';
import 'package:planney/stores/planney_user.store.dart';
part 'profile_page.controller.g.dart';

class ProfilePageController = ProfilePageControllerBase
    with _$ProfilePageController;

abstract class ProfilePageControllerBase with Store {
  final PlanneyUserStore store = GetIt.instance.get();

  ImagePicker imagePicker = ImagePicker();

  final storage = FirebaseStorage.instance;

  @observable
  File? profilePhoto;

  @observable
  bool showChangePassword = false;

  @observable
  bool canShowPassword = false;

  @observable
  bool canShowNewPassword = false;

  String _email = '';
  String _fullName = '';
  String _password = '';
  String _newPassword = '';

  void changeEmail(String value) {
    _email = value;
  }

  void changeName(String value) {
    _fullName = value;
  }

  void changePassword(String value) {
    _password = value;
  }

  void changeNewPassword(String value) {
    _newPassword = value;
  }

  @action
  void setCanShowChangePassword(bool value) {
    canShowNewPassword = value;
  }

  @action
  void setShowPassword() {
    canShowPassword = !canShowPassword;
  }

  @action
  void setShowNewPassword() {
    canShowNewPassword = !canShowNewPassword;
  }

  Future<APIResponse<bool>> updateUser() async {
    if (_password == '' && _email == '' && _fullName == '') {
      return APIResponse.success(true);
    }
    final auth = FirebaseAuth.instance;
    if (_password == '') {
      return APIResponse.error('É obrigatório informar a senha');
    }
    final user = await auth.currentUser!.reauthenticateWithCredential(
      EmailAuthProvider.credential(
        email: auth.currentUser!.email!,
        password: _password,
      ),
    );
    if (user.user != null) {
      if (_fullName != '') {
        if (_fullName.split(' ').length == 1) {
          return APIResponse.error("É necessário ao menos um sobrenome.");
        }
        await auth.currentUser!.updateDisplayName(_fullName);
        store.setPlanneyUser(store.planneyUser!.copyWith(fullName: _fullName));
      }
      if (_email != '') {
        await auth.currentUser!.updateEmail(_email);
        store.setPlanneyUser(store.planneyUser!.copyWith(email: _email));
      }
      if (_newPassword != '') {
        await auth.currentUser!.updatePassword(_newPassword);
      }
      canShowNewPassword = false;
      canShowPassword = false;
      showChangePassword = false;
      return APIResponse.success(true);
    } else {
      return APIResponse.error('Algo deu errado!');
    }
  }

  galeryImage() async {
    final XFile? temporaryImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (temporaryImage != null) {
      profilePhoto = File(temporaryImage.path);
      await uploadFile(profilePhoto!);
    }
  }

  cameraImage() async {
    final XFile? temporaryImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (temporaryImage != null) {
      profilePhoto = File(temporaryImage.path);
      await uploadFile(profilePhoto!);
    }
  }

  Future<void> uploadFile(File profilePhoto) async {
    final fileName = basename(profilePhoto.path);
    final destination = 'files/${store.uid}';
    try {
      final ref = storage.ref(destination).child(fileName);
      await ref.putFile(profilePhoto);
      String image = await ref.getDownloadURL();
      FirebaseAuth.instance.currentUser!.updatePhotoURL(image);
    } catch (e) {
      return;
    }
  }
}
