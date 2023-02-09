import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:planney/model/planney_user.dart';
part 'planney_user.store.g.dart';

class PlanneyUserStore = PlanneyUserStoreBase with _$PlanneyUserStore;

abstract class PlanneyUserStoreBase with Store {
  final storage = FirebaseStorage.instance;

  @observable
  File? profilePhoto;

  ImagePicker imagePicker = ImagePicker();

  @readonly
  String? _uid;

  @readonly
  String? _email;

  @readonly
  PlanneyUser? _planneyUser;

  @action
  void setUser(String uid, String email) {
    _uid = uid;
    _email = email;
  }

  @action
  void setPlanneyUser(PlanneyUser planneyUser) {
    _planneyUser = planneyUser;
  }

  @action
  void unloadPlanneyUser() {
    _uid = null;
    _email = null;
    _planneyUser = null;
  }

  Future<void> uploadFile() async {
    if (profilePhoto == null) return;
    final fileName = basename(profilePhoto!.path);
    final destination = 'files/$_uid';
    try {
      final ref = storage.ref(destination).child(fileName);
      await ref.putFile(profilePhoto!);
      String image = await ref.getDownloadURL();
      FirebaseAuth.instance.currentUser!.updatePhotoURL(image);
    } catch (e) {
      return;
    }
  }

  @action
  galeryImage() async {
    final XFile? temporaryImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (temporaryImage != null) {
      profilePhoto = File(temporaryImage.path);

      uploadFile();
    }
  }

  @action
  cameraImage() async {
    final XFile? temporaryImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (temporaryImage != null) {
      profilePhoto = File(temporaryImage.path);
      uploadFile();
    }
  }
}
