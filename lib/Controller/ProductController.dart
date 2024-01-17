import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../Models/ProductModel.dart';

class ProductController extends GetxController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController modelUrl = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxBool addCat = false.obs;
  var prodName = ''.obs;
  var prodDesc = ''.obs;
  var prodImageUrl = ''.obs;
  var prodModelUrl = ''.obs;
  var prodPrice = ''.obs;
  RxList categories = [].obs;
  RxBool catFetch = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    collectionReference = fireStore.collection('products');
    products.bindStream(getAllProducts());
    Future.delayed(const Duration(seconds: 2), () async {
      await catGet();
      catFetch.value = true;
      print(catFetch.value);
    });
    // var result=await catGet();
    // print(result);
  }

  Stream<List<ProductModel>> getAllProducts() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item)).toList());
// Future getData(String collection) async{
//     QuerySnapshot snapshot=
//         await fireStore.collection(collection).get();
//     return snapshot.docs;
// }

  Future<List> catGet() {
    for (int i = 0; i < products.value.length; i++) {
      var contain = categories.value.where((element) =>
          element['Category'] == products.value[i].category.toString());
      if (contain.isEmpty) {
        Map catMap = {
          'Category': products.value[i].category,
          'imageUrl': products.value[i].imageUrl
        };
        categories.value.add(catMap);
      }
    }
    return Future.value(categories);
  }

  Future<void> addProduct(String imageUrl) {
    // Calling the collection to add a new user
    var productId = const Uuid().v1();
    final data = {
      'name': name.text,
      'description': description.text,
      'modelUrl': modelUrl.text,
      'category': category.text,
      'price': price.text,
      'productId': productId,
      'imageUrl': imageUrl,
    };
    return collectionReference
        .doc(productId)
        //adding to firebase collection
        .set(data)
        .then((value) => Get.snackbar('Success', 'Product Added Successfully',
            backgroundColor: Colors.green))
        .catchError((error) =>
            Get.snackbar('Error', '$error', backgroundColor: Colors.red));
  }
  // printUrl() async {
  //   var ref =
  //   FirebaseStorage.instance.ref().child("Artichoke.glb");
  //   String url = (await ref.getDownloadURL()).toString();
  //   print(url);
  // }
//For setting a specific document ID use .set instead of .add
//   users.doc(documentId).set({
//   //Data added in the form of a dictionary into the document.
//   'full_name': fullName,
//   'grade': grade,
//   'age': age
// });

//For updating docs, you can use this function.
// Future<void> updateUser() {
//   return collectionReference
//   //referring to document ID, this can be queried or named when added accordingly
//       .doc(documentId)
//   //updating grade value of a specific student
//       .update({'grade': newGrade})
//       .then((value) => print("Student data Updated"))
//       .catchError((error) => print("Failed to update data"));
// }
}
