import 'package:flutter/material.dart';
import 'package:fyp/Controller/CartController.dart';
import 'package:fyp/Controller/ProductController.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import 'CartPage.dart';
import 'CheckOut.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductController product = Get.find();
  CartController cart = Get.find();
  var arguments = Get.arguments;
  var buyNow = false;
  @override
  void initState() {
    super.initState();
    product.prodName.value = arguments[0];
    product.prodDesc.value = arguments[1];
    product.prodModelUrl.value = arguments[2];
    product.prodPrice.value = arguments[3];
    product.prodImageUrl.value = arguments[4];
    cart.cartLen.value = cart.cartList.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.41,
              child: Stack(alignment: Alignment.topRight, children: [
                ModelViewer(
                  backgroundColor: Get.isDarkMode ? Colors.white : Colors.black,
                  src: product.prodModelUrl.value, // a bundled asset file
                  ar: true,
                  arPlacement: ArPlacement.floor,
                  autoRotate: true,
                  cameraControls: true,
                ),
                // SizedBox(
                //   height: 380,
                //   width: 380,
                //   child: Image.network(product.prodImageUrl.value),
                //   // child: ModelViewer(
                //   //       src: '${product.products[index].modelUrl}', // a bundled asset file
                //   //
                //   //   ),
                // ),
                // ModelView(url: product.prodModelUrl.value),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                      ElevatedButton.icon(
                          onPressed: () {
                            Get.to(() => const Cart());
                          },
                          icon: const Icon(Icons.add_shopping_cart),
                          label: Builder(builder: (context) {
                            return Obx(() => Text('${cart.cartLen}'));
                          })),
                    ],
                  ),
                )
              ]),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 35, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.prodName.value,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rs.${product.prodPrice.value}",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.28,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    '${product.prodDesc}',
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              var contain = cart.cartList.where((element) =>
                                  element['modelUrl'] ==
                                  product.prodModelUrl.value);
                              if (contain.isNotEmpty) {
                                Get.snackbar("Can't add item",
                                    'Item already exists in cart',
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.BOTTOM);
                              } else {
                                cart.addToCart(
                                    product.prodName.value,
                                    double.parse(product.prodPrice.value),
                                    product.prodModelUrl.value,
                                    product.prodImageUrl.value);
                                cart.quantity.add(TextEditingController());
                                Get.snackbar(
                                    'Successful', 'Item Added Successfully',
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: Colors.green,
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            },
                            child: const SizedBox(
                              height: 60,
                              width: 350,
                              child: Card(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.elliptical(5, 5)),
                                  side: BorderSide(
                                      color: Colors.grey, width: 0.7),
                                ),
                                elevation: 5,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                child: Center(child: Text('Add to Cart')),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cart.buyNow(
                                  product.prodName.value,
                                  double.parse(product.prodPrice.value),
                                  product.prodModelUrl.value,
                                  product.prodImageUrl.value);
                              // print(cart.buyList.value);
                              Get.to(() => const Checkout(), arguments: [
                                buyNow,
                                product.prodPrice.toString()
                              ]);
                            },
                            child: const SizedBox(
                              height: 60,
                              width: 350,
                              child: Card(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.elliptical(5, 5)),
                                  side: BorderSide(
                                      color: Colors.grey, width: 0.7),
                                ),
                                elevation: 5,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                child: Center(child: Text('Buy')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
