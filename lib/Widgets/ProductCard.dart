import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ProductCard extends StatelessWidget {
  dynamic productModel, name, price;

  ProductCard({this.productModel, this.price, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, offset: Offset(-2, -1), blurRadius: 0.2),
            ]),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: <Widget>[
                    // Positioned.fill(
                    //     child: Align(
                    //       alignment: Alignment.center,
                    //       child: Loading(),
                    //     )),
                    Center(
                      child: Container(
                        height: 120,
                        width: 125,
                        child: ModelViewer(
                          src: '$productModel', // a bundled asset file
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$name \n',
                    style: const TextStyle(fontSize: 20),
                  ),

                  TextSpan(
                    text: 'Rs $price \t',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // TextSpan(
                  //   text: product.sale ? 'ON SALE ' : "",
                  //
                  //   style: TextStyle(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w400,
                  //       color: Colors.red),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
