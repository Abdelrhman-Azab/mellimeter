import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UploadThisFile {
  Future uploadMyfile(_file) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child(_file.path);
    UploadTask uploadTask = storageReference.putFile(File(_file.path));
    await uploadTask.whenComplete(() {
      storageReference.getDownloadURL().then((value) {
        print(value);
      });
    });
  }
}
