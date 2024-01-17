import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Controller/CartController.dart';
import 'package:fyp/Controller/PaymentController.dart';
import 'package:fyp/Views/MainPage.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../Widgets/TextField.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var args = Get.arguments;
  bool get buyNow => args != null;
  PaymentController payment = Get.find();
  CartController cart = Get.find();
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (buyNow == true) {
      print('args total price ${args[1]}');
      cart.totalAmount.value = double.parse(args[1].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Check Out',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: key,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    CustomTextField(
                      controllers: payment.name,
                      labelText: 'Full Name',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Field Required";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controllers: payment.email,
                      labelText: 'Email',
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
                        controller: payment.number,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            filled: true,
                            labelText: 'Phone Number'),
                        autovalidateMode: AutovalidateMode.always,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Field Required";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        controller: payment.address,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            filled: true,
                            labelText: 'Address'),
                        autovalidateMode: AutovalidateMode.always,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Field Required";
                          }
                          return null;
                        },
                      ),
                    ),
                    CSCPicker(
                      dropdownDecoration: const BoxDecoration(),
                      onCountryChanged: (value) {
                        setState(() {
                          String countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          payment.state.text = value.toString();
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          payment.city.text = value.toString();
                        });
                      },
                    ),
                    // CustomTextField(controllers:payment.city,labelText: 'City', validator: (val) {
                    //   if (val!.isEmpty) {
                    //     return "Field Required";
                    //   }
                    // },),
                    // CustomTextField(controllers:payment.state,labelText: 'State', validator: (val) {
                    //   if (val!.isEmpty) {
                    //     return "Field Required";
                    //   }
                    // },),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SlideAction(
                        innerColor: Colors.white,
                        outerColor: Colors.green,
                        sliderButtonIcon: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.black,
                        ),
                        text: 'Check Out',
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        onSubmit: () async {
                          if (key.currentState!.validate()) {
                            if (buyNow == false) {
                              var total = cart.totalAmount.value.toInt();
                              await payment.makePayment(
                                  amount: '$total', currency: 'PKR');
                              print(total);
                              cart.uploadUserSpecificCart(
                                  userName: payment.name.text,
                                  address: payment.address.text,
                                  phone: payment.number.text,
                                  city: payment.city.text,
                                  state: payment.state.text,
                                  email: payment.email.text);

                              cart.uploadOverAllCart(
                                  userName: payment.name.text,
                                  address: payment.address.text,
                                  phone: payment.number.text,
                                  city: payment.city.text,
                                  state: payment.state.text,
                                  email: payment.email.text);
                              setState(() {
                                cart.cartList.value.clear();
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => const MainPage()),
                                  (route) => false);
                              // Get.off(()=> const MainPage());
                            } else {
                              var total = cart.totalAmount.value.toInt();
                              await payment.makePayment(
                                  amount: '$total', currency: 'PKR');
                              print(total);
                              cart.buyNowUserSpecificCart(
                                  userName: payment.name.text,
                                  address: payment.address.text,
                                  phone: payment.number.text,
                                  city: payment.city.text,
                                  state: payment.state.text,
                                  email: payment.email.text);

                              cart.buyNowCart(
                                  userName: payment.name.text,
                                  address: payment.address.text,
                                  phone: payment.number.text,
                                  city: payment.city.text,
                                  state: payment.state.text,
                                  email: payment.email.text);
                              setState(() {
                                cart.buyList.value.clear();
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => const MainPage()),
                                  (route) => false);
                            }
                          } else {
                            Get.snackbar(
                                'Error', 'Please Fill the required fields',
                                duration: const Duration(seconds: 2),
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                      ),
                    )
                    // ElevatedButton(onPressed: (){
                    //
                    // }, child: Text('Pay Now'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
