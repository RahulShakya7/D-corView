import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Views/Admin_Panel/OrderAdmin.dart';
import 'package:get/get.dart';

import '../../Widgets/Constants.dart';
import '../../Widgets/SmallerDivider.dart';

class AdminOrderDetailsPage extends StatefulWidget {
  const AdminOrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<AdminOrderDetailsPage> createState() => _AdminOrderDetailsPageState();
}

class _AdminOrderDetailsPageState extends State<AdminOrderDetailsPage> {
  var args = Get.arguments;
  late String userName;
  late String phoneNumber;
  late String orderDate;
  late String orderStatus;
  late String totalPrice;
  late String userId;
  late String orderId;
  late String address;
  late List orders;
  late String email;
  @override
  void initState() {
    super.initState();
    userName = args[0].toString();
    phoneNumber = args[1].toString();
    orderDate = args[2].toString();
    orderStatus = args[3].toString();
    totalPrice = args[4].toString();
    orderId = args[5].toString();
    userId = args[6].toString();
    address = args[7].toString();
    orders = args[8];
    email = args[9].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'User Name',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(userName, style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Phone Number', style: TextStyle(fontSize: 18)),
                    Text(phoneNumber, style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Email', style: TextStyle(fontSize: 18)),
                    Text(email, style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Order Date', style: TextStyle(fontSize: 18)),
                    Text(orderDate, style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Order Price', style: TextStyle(fontSize: 18)),
                    Text(totalPrice, style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 50.0),
                      child: Text('Address', style: TextStyle(fontSize: 18)),
                    ),
                    Flexible(
                      child: Text(address,
                          maxLines: 4,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order Status',
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton<String>(
                      focusColor: Colors.white,
                      value: orderStatus,
                      //elevation: 5,

                      items: <String>[kProcessing, kCompleted, kCancelled]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          orderStatus = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              SmallerDividerHeading(
                heading: 'Items',
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: SizedBox(
                            height: 100, width: 50,
                            child: Image.network(
                                orders[index]['imageUrl'].toString()),
                            // ModelViewer(src:orders[index]['modelUrl'].toString())
                          ),
                          title: Text(orders[index]['name'].toString()),
                          trailing: Text(orders[index]['price'].toString()),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Center(
                    child: ElevatedButton(
                      child: const Text('Update Status'),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('Orders')
                            .doc(orderId)
                            .update({
                          'orderStatus': orderStatus,
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('orders')
                            .doc(orderId)
                            .update({
                          'orderStatus': orderStatus,
                        });
                        Get.off(const OrderAdmin());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: const Text('Delete Order'),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('Orders')
                            .doc(orderId)
                            .delete();
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('orders')
                            .doc(orderId)
                            .delete();
                        Get.off(const OrderAdmin());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
