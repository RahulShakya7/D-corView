import 'package:flutter/material.dart';
import 'package:fyp/Controller/PaymentController.dart';
import 'package:fyp/Views/CheckOut.dart';
import 'package:get/get.dart';

import '../Controller/CartController.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartController cart = Get.find();
  List<TextEditingController> linePrice = [];
  PaymentController payment = Get.find();
  @override
  void initState() {
    super.initState();
    cart.totalAmount.value = 0;
    linePrice.clear();

    // cart.totalAmount.value=double.parse(linePrice..reduce((a, b) => a + b))
    for (int i = 0; i < cart.quantity.length; i++) {
      cart.quantity[i].text = '1';
    }
    for (int j = 0; j < cart.cartList.value.length; j++) {
      linePrice.add(TextEditingController());
      linePrice[j].text = cart.cartList.value[j]['price'].toString();
    }
    for (var j = 0; j < linePrice.length; j++) {
      //print(widget.controllers[i].text);
      cart.totalAmount.value += double.tryParse(linePrice[j].text) ?? 0;
    }
    print(cart.totalAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          if (cart.cartList.value.isEmpty) {
            return SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Column(
                children: [
                  Center(child: Image.asset('images/noOrders.png')),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Your cart is Empty',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ));
          } else {
            return Column(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.78,
                    child: Obx(
                      () => ListView.builder(
                        itemCount: cart.cartList.value.length,
                        itemBuilder: (context, index) => Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            color: Colors.red,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) {
                            setState(() {
                              cart.totalAmount.value = cart.totalAmount.value -
                                  double.parse(linePrice[index].text);
                              print(linePrice[index].text);
                              linePrice.remove(linePrice[index]);
                              cart.quantity.remove(cart.quantity[index]);
                              cart.cartList.removeAt(index);
                            });
                          },
                          child: Card(
                            elevation: 8,
                            shadowColor: Get.isDarkMode
                                ? Colors.black45
                                : Colors.black45,
                            margin: const EdgeInsets.all(6),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black26)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 110,
                                    width: 90,
                                    child: Image.network(
                                      cart.cartList.value[index]['imageUrl']
                                          .toString(), // a bundled asset file
                                    ),
                                    // child: ModelViewer(
                                    //       src: '${cart.cartList.value[index]['modelUrl'].toString()}', // a bundled asset file
                                    //
                                    //   ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cart.cartList.value[index]['name']
                                            .toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                visualDensity:
                                                    VisualDensity.compact,
                                                iconSize: 18,
                                                onPressed: () {
                                                  setState(() {
                                                    if (cart.quantity[index]
                                                        .text.isEmpty) {
                                                      cart.quantity[index]
                                                          .text = '0';
                                                    } else if (double.parse(cart
                                                            .quantity[index]
                                                            .text) ==
                                                        1) {
                                                      return;
                                                    } else {
                                                      cart.quantity[index]
                                                          .text = (int.parse(
                                                                  cart
                                                                      .quantity[
                                                                          index]
                                                                      .text) -
                                                              1)
                                                          .toString();
                                                    }
                                                    linePrice[index]
                                                        .text = (double.parse(cart
                                                                .cartList
                                                                .value[index]
                                                                    ['price']
                                                                .toString()) *
                                                            double.parse(cart
                                                                .quantity[index]
                                                                .text
                                                                .toString()))
                                                        .toString();
                                                    cart.totalAmount.value =
                                                        cart.totalAmount.value -
                                                            double.parse(cart
                                                                .cartList
                                                                .value[index]
                                                                    ['price']
                                                                .toString());
                                                  });
                                                },
                                                icon: const Icon(
                                                    Icons.exposure_minus_1),
                                                color: Colors.red,
                                              ),
                                              SizedBox(
                                                height: 20,
                                                width: 45,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      cart.quantity[index],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      cart.totalAmount.value =
                                                          0.0;
                                                      if (value.isEmpty) {
                                                        value = '0';
                                                      }
                                                      linePrice[index]
                                                          .text = (double.parse(cart
                                                                  .cartList
                                                                  .value[index]
                                                                      ['price']
                                                                  .toString()) *
                                                              double.parse(
                                                                  value))
                                                          .toString();
                                                      print(linePrice);
                                                      for (var j = 0;
                                                          j < linePrice.length;
                                                          j++) {
                                                        //print(widget.controllers[i].text);
                                                        cart.totalAmount.value =
                                                            cart.totalAmount
                                                                    .value +
                                                                double.parse(
                                                                    linePrice[j]
                                                                        .text);
                                                      }

                                                      //cart.totalAmount.value=cart.totalAmount.value+ (double.parse(linePrice[index].text));
                                                    });
                                                  },
                                                  //initialValue: '1',
                                                ),
                                              ),
                                              IconButton(
                                                iconSize: 18,
                                                onPressed: () {
                                                  setState(() {
                                                    if (cart.quantity[index]
                                                        .text.isEmpty) {
                                                      cart.quantity[index]
                                                          .text = '0';
                                                    }
                                                    cart.quantity[index]
                                                        .text = (int.parse(cart
                                                                .quantity[index]
                                                                .text) +
                                                            1)
                                                        .toString();
                                                    linePrice[index]
                                                        .text = (double.parse(cart
                                                                .cartList
                                                                .value[index]
                                                                    ['price']
                                                                .toString()) *
                                                            double.parse(cart
                                                                .quantity[index]
                                                                .text
                                                                .toString()))
                                                        .toString();

                                                    cart.totalAmount.value =
                                                        cart.totalAmount.value +
                                                            double.parse(cart
                                                                .cartList
                                                                .value[index]
                                                                    ['price']
                                                                .toString());
                                                  });
                                                },
                                                icon:
                                                    const Icon(Icons.plus_one),
                                                color: Colors.green,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'RS ${linePrice[index].text}',
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Obx(() => Text(
                                'RS ${cart.totalAmount.value}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            // var total=cart.totalAmount.value.toInt();
                            // print(total);
                            //  cart.uploadUserSpecificCart();
                            //  setState((){ cart.cartList.value.clear();});
                            //
                            //  //var send=await payment.makePayment(amount: '$total', currency: 'PKR');
                            Get.to(() => const Checkout());
                          },
                          child: const Text('Proceed to Checkout'))
                    ],
                  ),
                )
              ],
            );
          }
        }),
      ),
    );
  }
}
