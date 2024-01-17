import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Views/Admin_Panel/UploadData.dart';
import 'package:get/get.dart';

class ProductsAdmin extends StatefulWidget {
  const ProductsAdmin({Key? key}) : super(key: key);

  @override
  State<ProductsAdmin> createState() => _ProductsAdminState();
}

class _ProductsAdminState extends State<ProductsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const UploadData(), arguments: ['null']);
              },
              icon: const Icon(Icons.add_circle))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                return InkWell(
                  onTap: () {
                    Get.to(() => const UploadData(), arguments: [
                      index,
                      doc['name'],
                      doc['price'],
                      doc['productId'],
                      doc['modelUrl'],
                      doc['category'],
                      doc['description'],
                      doc['imageUrl']
                    ]);
                  },
                  child: Card(
                    elevation: 8,
                    shadowColor:
                        Get.isDarkMode ? Colors.black45 : Colors.black45,
                    margin: const EdgeInsets.all(6),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black26)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(doc['imageUrl'].toString()),
                            // child: ModelViewer(
                            //   src: doc['modelUrl'],
                            // ),
                          ),
                          Text(doc['name'].toString(),
                              style: const TextStyle(fontSize: 18)),
                          Text(doc['price'].toString(),
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
