import 'package:flutter/material.dart';
import 'package:fyp/Controller/ProductController.dart';
import 'package:fyp/Views/ProductDetailsPage.dart';
import 'package:get/get.dart';

class ProductPageCategoryWise extends StatefulWidget {
  const ProductPageCategoryWise({Key? key}) : super(key: key);

  @override
  State<ProductPageCategoryWise> createState() =>
      _ProductPageCategoryWiseState();
}

class _ProductPageCategoryWiseState extends State<ProductPageCategoryWise> {
  ProductController product = Get.find();
  var arg = Get.arguments;
  var catName;
  List prods = [];
  @override
  void initState() {
    super.initState();
    catName = arg[0].toString();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < product.products.length; i++) {
      //var contain = prods.where((element) => catName == "${product.products[i].category.toString()}");
      if (catName == "${product.products[i].category.toString()}") {
        Map catMap = {
          'name': product.products[i].name.toString(),
          'price': product.products[i].price.toString(),
          'description': product.products[i].description.toString(),
          'category': product.products[i].category.toString(),
          'modelUrl': product.products[i].modelUrl.toString(),
          'imageUrl': product.products[i].imageUrl.toString()
        };
        prods.add(catMap);
      }
    }
    print(prods);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          catName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: prods.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Get.to(() => const ProductDetails(), arguments: [
                        '${prods[index]['name']}',
                        '${prods[index]['description']}',
                        '${prods[index]['modelUrl']}',
                        '${prods[index]['price']}',
                        '${prods[index]['imageUrl']}'
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 110,
                                width: 110,
                                child: Image.network(prods[index]['imageUrl'])
                                // child: ModelViewer(
                                //       src: '${prods[index]['modelUrl']}', // a bundled asset file
                                //
                                //   ),
                                ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${prods[index]['name']} \n',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '\Rs ${prods[index]['price']} \t',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
