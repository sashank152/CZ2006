import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _ff = FirebaseStorage.instance;
  final FirebaseAuth _fa = FirebaseAuth.instance;

  Future<String> uploadImage(String child, Uint8List file) async {
    Reference ref = _ff.ref().child(child).child(_fa.currentUser!.uid);

    UploadTask ut = ref.putData(file);

    TaskSnapshot snap = await ut;

    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }
}
