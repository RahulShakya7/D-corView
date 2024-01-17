import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Views/Admin_Panel/AdminOrderDetailsPage.dart';
import 'package:get/get.dart';

class OrderAdmin extends StatefulWidget {
  const OrderAdmin({Key? key}) : super(key: key);

  @override
  State<OrderAdmin> createState() => _OrderAdminState();
}

class _OrderAdminState extends State<OrderAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                List listOfOrders = doc['order'];

                return InkWell(
                  onTap: () {
                    Get.to(() => const AdminOrderDetailsPage(), arguments: [
                      doc['userName'],
                      doc['phoneNumber'],
                      doc['orderDate'],
                      doc['orderStatus'],
                      doc['totalPrice'],
                      doc['orderId'],
                      doc['orderedBy'],
                      doc['address'],
                      listOfOrders,
                      doc['email']
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
                      child: Column(children: [
                        SizedBox(
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(doc['orderDate']),
                                Text(doc['userName']),
                                Text(
                                  doc['orderStatus'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: doc['orderStatus'] == 'Processing'
                                        ? Colors.yellow
                                        : doc['orderStatus'] == 'Cancelled'
                                            ? Colors.red
                                            : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ])),
                  // ListTile(
                  //   title: Text(doc['userName']),
                  //   trailing: Text(doc['orderStatus']),
                  //   leading: Text(doc['orderDate']),
                  // ),
                );
              });
        },
      ),
    );
  }
}
