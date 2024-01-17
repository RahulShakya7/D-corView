import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Controller/ProductController.dart';
import 'package:fyp/Views/Admin_Panel/ProductsAdmin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Widgets/Button.dart';
import '../../Widgets/TextField.dart';

class UploadData extends StatefulWidget {
  const UploadData({super.key});

  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  ProductController product = Get.find();
  var args = Get.arguments;
  var index;
  var name;
  var price;
  var modelUrl;
  var category;
  var productId;
  var description;
  RxBool addCat = false.obs;
  RxBool selCat = false.obs;
  List cats = [];
  String? imageUrl;

  bool get isEditing => index != 'null';

  @override
  void initState() {
    super.initState();
    index = args[0];
    for (int i = 0; i < product.categories.value.length; i++) {
      cats.add(product.categories.value[i]['Category']);
    }
    print(cats);
    if (isEditing) {
      name = args[1];
      price = args[2];
      productId = args[3];
      modelUrl = args[4];
      category = args[5];
      description = args[6];
      imageUrl = args[7];
      product.name.text = name;
      product.category.text = category;
      product.modelUrl.text = modelUrl;
      product.price.text = price;
      product.description.text = description;
    } else {
      product.name.text = '';
      product.category.text = cats[0].toString();
      product.modelUrl.text = '';
      product.price.text = '';
      imageUrl = '';
      product.description.text = '';
    }
  }

  final key = GlobalKey<FormState>();
  File? image1;
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isEditing ? 'Update Product' : 'Add Product',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildImagePicker1(),
                CustomTextField(
                  controllers: product.name,
                  labelText: 'Product Name',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Field Required";
                    }
                    return null;
                  },
                ),
                // DropdownButton<String>(
                //
                //   focusColor: Colors.white,
                //   value: product.category.text,
                //   //elevation: 5,
                //
                //
                //   items: cats
                //       .map<DropdownMenuItem<String>>(( value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(
                //         value,
                //         style: const  TextStyle(fontSize: 18),
                //       ),
                //     );
                //   }).toList(),
                //   onChanged: (String? value) {
                //     setState(() {
                //       product.category.text = value.toString();
                //     });
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Builder(builder: (context) {
                          if (addCat.value == false) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  filled: true,
                                  // hintStyle: TextStyle(
                                  //     color: Colors.grey[800]),
                                  labelText: "Category",
                                ),
                                items: cats.map((itms) {
                                  return DropdownMenuItem(
                                    onTap: () {
                                      product.category.text = itms;
                                      print(product.category.text);
                                    },
                                    value: itms.toString(),
                                    child: Text(
                                      itms,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (itm) {
                                  setState(() {
                                    product.category.text = itm as String;

                                    print(product.category.text);
                                  });
                                },
                                value: product.category.text,
                              ),
                            );
                          } else {
                            return CustomTextField(
                              controllers: product.category,
                              labelText: 'Category',
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Field Required";
                                }
                                return null;
                              },
                            );
                          }
                        }),
                      ),
                      Builder(builder: (context) {
                        if (addCat.value == false) {
                          return IconButton(
                              onPressed: () {
                                setState(() {
                                  addCat.value = true;
                                  selCat.value = false;
                                  print(addCat);
                                });
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                size: 28,
                              ));
                        } else if (selCat.value == false) {
                          return IconButton(
                              onPressed: () {
                                setState(() {
                                  selCat.value = true;
                                  addCat.value = false;
                                  print(selCat);
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                size: 28,
                              ));
                        } else {
                          return const Text('');
                        }
                      })
                    ],
                  ),
                ),
                //

                CustomTextField(
                  controllers: product.modelUrl,
                  labelText: 'Model Url',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Field Required";
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controllers: product.price,
                  labelText: 'Price',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Field Required";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    controller: product.description,
                    maxLines: 3,
                    style: const TextStyle(),
                    decoration: const InputDecoration(
                      labelText: 'Product Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                UploadDataButton(
                  text: 'Upload',
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      if (isEditing) {
                        await uploadImagesAndGetDownloadLink();
                        final data = {
                          'name': product.name.text,
                          'description': product.description.text,
                          'modelUrl': product.modelUrl.text,
                          'category': product.category.text,
                          'price': product.price.text,
                          'productId': productId,
                          'imageUrl': imageUrl,
                        };
                        await FirebaseFirestore.instance
                            .collection('products')
                            .doc(productId)
                            .update(data);
                        Get.snackbar(
                            'Successful', 'Product Updated Successfully',
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.green,
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        await uploadImagesAndGetDownloadLink();
                        product.addProduct(imageUrl!);
                        Get.snackbar('Successful', 'Product Added Successfully',
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.green,
                            snackPosition: SnackPosition.BOTTOM);
                      }
                      Get.off(const ProductsAdmin());
                    }
                  },
                ),

                Builder(builder: (context) {
                  if (isEditing) {
                    return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('products')
                              .doc(productId)
                              .delete();
                          Get.off(const ProductsAdmin());
                        },
                        child: const Text('Delete'));
                  } else {
                    return const Text('');
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker1() {
    return InkWell(
      onTap: () async {
        var pickedFile = await imagePicker.pickImage(
            source: ImageSource.gallery, imageQuality: 20);
        setState(() {
          image1 = File(pickedFile!.path);
        });
      },
      child: imageUrl!.isEmpty
          ? Container(
              width: 120,
              height: 120,
              decoration: image1 == null
                  ? BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
              child: image1 != null
                  ? Stack(
                      children: [
                        Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.file(
                              image1!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              image1 = null;
                            });
                          },
                          child: const Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.cancel)),
                        ),
                      ],
                    )
                  : const Center(
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
            )
          : SizedBox(
              height: 120,
              width: 120,
              child: Image.network(imageUrl!),
            ),
    );
  }

  Future uploadImagesAndGetDownloadLink() async {
    try {
      if (image1 != null) {
        var reference1 = FirebaseStorage.instance.ref('Images/$image1');
        await reference1.putFile(image1!);
        String download1 = await reference1.getDownloadURL();
        if (kDebugMode) {
          print('Image1 DOWNLOAD URL:$download1');
        }
        setState(() {
          imageUrl = download1;
        });
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (kDebugMode) {
      print(imageUrl);
    }
  }
}
