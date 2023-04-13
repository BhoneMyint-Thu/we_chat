import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat/network/data_agent/fire_base_storage/fire_storage.dart';

import '../../../constant/strings.dart';

class FireStorageImpl extends FireStorage{
  final _firebaseStorage=FirebaseStorage.instance;

  @override
  Future<String> upLoadFileToFirebaseStorage(File file,String uId)=>_firebaseStorage
      .ref(kRootNodeForFirebaseStorageUpload)
      .child(uId)
      .putFile(file)
      .then((taskSnapShot) => taskSnapShot.ref.getDownloadURL());
  
}