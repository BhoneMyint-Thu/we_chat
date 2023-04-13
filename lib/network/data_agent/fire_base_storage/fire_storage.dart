import 'dart:io';

abstract class FireStorage{
  Future<String> upLoadFileToFirebaseStorage(File file,String uId);
}