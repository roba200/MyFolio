import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/Services/database.dart';

class Storage {
  XFile? image;
  String url = "";
  Reference? ref;
  Future pickUploadImage() async {
    image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 50);

    ref = FirebaseStorage.instance
        .ref()
        .child(FirebaseAuth.instance.currentUser!.uid + ".jpg");

    await ref?.putFile(File(image!.path));
    ref!.getDownloadURL().then((value) async {
      print(value);
      url = value;
      await Database().updateUrl(url);
    });
    return url;
  }
}
