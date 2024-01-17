import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Views/Admin_Panel/OrderAdmin.dart';
import 'package:fyp/Views/Admin_Panel/ProductsAdmin.dart';
import 'package:get/get.dart';

import 'UserAdmin.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  var orderCount = '0'.obs;
  var userCount = '0'.obs;
  var productCount = '0'.obs;
  @override
  fetchCount() async {
    QuerySnapshot productCollection =
        await FirebaseFirestore.instance.collection('products').get();
    productCount.value = productCollection.size.toString();
    QuerySnapshot userCollections =
        await FirebaseFirestore.instance.collection('users').get();
    userCount.value = userCollections.size.toString();
    QuerySnapshot orderCollections =
        await FirebaseFirestore.instance.collection('Orders').get();
    orderCount.value = orderCollections.size.toString();
  }

  @override
  void initState() {
    super.initState();

    fetchCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.31,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const UserAdmin());
                    },
                    child: Card(
                      elevation: 8,
                      shadowColor:
                          Get.isDarkMode ? Colors.black45 : Colors.black45,
                      margin: const EdgeInsets.all(6),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black26)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Users',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Obx(() => Text(
                                '$userCount',
                                style: const TextStyle(
                                    fontSize: 22, color: Colors.green),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.31,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const ProductsAdmin());
                    },
                    child: Card(
                      elevation: 8,
                      shadowColor:
                          Get.isDarkMode ? Colors.black45 : Colors.black45,
                      margin: const EdgeInsets.all(6),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black26)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Products',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Obx(() => Text(
                                '$productCount',
                                style: const TextStyle(
                                    fontSize: 22, color: Colors.green),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.31,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const OrderAdmin());
                    },
                    child: Card(
                      elevation: 8,
                      shadowColor:
                          Get.isDarkMode ? Colors.black45 : Colors.black45,
                      margin: const EdgeInsets.all(6),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black26)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Orders',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Obx(() => Text(
                                '$orderCount',
                                style: const TextStyle(
                                    fontSize: 22, color: Colors.green),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
