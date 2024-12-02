import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class FirestoreCrud{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  // CREATE
  Future<void> create(String path, bool isDocumentRefAuto, dataModelMap) async{
    try{
      if(isDocumentRefAuto){
        await firestore
            .collection(path)
            .add(dataModelMap);
      } else {
        final documentReference = firestore.doc(path);
        await documentReference.set(dataModelMap);
      }
    }catch(err){
      debugPrint("ERROR: FirestoreCrudCreate => ${err.toString()}");
    }
  }

  // RETRIEVE
  Future retrieve(storeName, key, id) async {
    // key => equivalent of columnName
    // id => equivalent to id of record
    // for example key - 'membershipNumber' and id - '3636'
    //    select * where 'membershipNumber' == '3636'
    List data = [];

    await firestore
        .collection(storeName)
        .where(key, isEqualTo: id)
        .get()
        .then((value) {
      for (var element in value.docs) {
        data.add(element.data());
      }
    });
    return data;
  }

  // RETRIEVE ALL
  Future retrieveAll(storeName) async {
    List data = [];

    await firestore
        .collection(storeName)
        .get()
        .then((value) {
      for (var element in value.docs) {
        data.add(element.data());
      }
    });

    return data;
  }

  // UPDATE
  Future<void> update(String storeName, dataModelMap, String key, id) async{
    try{
      await firestore
          .collection(storeName)
          .where(key, isEqualTo: id)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          firestore
              .collection(storeName)
              .doc(value.docs[0].id)
              .update(dataModelMap);
        }
      });
    }catch(err){
      debugPrint("ERROR: FirestoreCrudUpdate => ${err.toString()}");
    }
  }

  // DELETE
  Future<void> delete(String storeName, String key, id) async{
    try{
      await firestore
          .collection(storeName)
          .where(key, isEqualTo: id)
          .get()
          .then((value) {
        for (var document in value.docs) {
          document.reference.delete();
        }
      });
    }catch(err){
      debugPrint("ERROR: FirestoreCrudDelete => ${err.toString()}");
    }
  }

  // UPLOAD IMAGES
  Future<List<String>> uploadImages(String storeName, List<File> images, id) async {
    List<String> imageUrls = [];
    try {
      for(File image in images){
        Reference storageReference = storage.ref().child('$storeName/$id/${DateTime.now().millisecondsSinceEpoch}');
        UploadTask uploadTask = storageReference.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
    }catch(err){
      debugPrint("ERROR: StorageCrudUploadImage => ${err.toString()}");
    }
    return imageUrls;
  }
}