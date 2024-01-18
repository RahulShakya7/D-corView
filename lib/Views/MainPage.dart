import 'package:flutter/material.dart';
import 'package:fyp/Controller/ProductController.dart';
import 'package:fyp/Views/AllProducts.dart';
import 'package:fyp/Views/ProductDetailsPage.dart';
import 'package:fyp/Views/cartPage.dart';
import 'package:get/get.dart';

import '../Controller/CartController.dart';
import '../Widgets/NavDrawer.dart';
import '../Widgets/SmallerDivider.dart';
import 'ProductPageCategoryWise.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ProductController product = Get.find();
  CartController cart = Get.find();
  // initializeFirebase() async{
  //   FirebaseApp app=await Firebase.initializeApp();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Welcome',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          //

          IconButton(
              onPressed: () {
                Get.to(() => const Cart());
              },
              icon: const Icon(Icons.add_shopping_cart)),

          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(const Duration(seconds: 2), () async {
            await product.catGet();
            // print(product.categories);
          });
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SmallerDividerHeading(
                heading: 'Categories',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 110.0,
                    child: ListView.builder(
                      itemCount: product.categories.length,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) => Column(
                        children: [
                          SizedBox(
                            height: 75.0,
                            width: 100,
                            child: InkWell(
                                onTap: () {
                                  Get.to(() => const ProductPageCategoryWise(),
                                      arguments: [
                                        product.categories[index]['Category']
                                            .toString()
                                      ]);
                                },
                                // child: Card(elevation: 8,
                                //   shape:  OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(60),
                                //       borderSide: BorderSide(color: Colors.black26)
                                //   ),
                                child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                  product.categories[index]['imageUrl']
                                      .toString(),
                                ))
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(8.0),
                                //   child:  Image.network(product.categories.value[index]['imageUrl'].toString(),
                                //     height: 150.0,
                                //     width: 100.0,
                                //   ),
                                // )
                                // Center(
                                //     child:
                                //     Image.network(product.categories.value[index]['imageUrl'].toString()),
                                //     //Image.asset(product.categories.value[index]['Category'].toString()=='Chair'?'images/chair.png':product.categories.value[index]['Category'].toString()=='Bed'?'images/bed.png':product.categories.value[index]['Category'].toString()=='Bench'?'images/bench.png':product.categories.value[index]['Category'].toString()=='Couch'?'images/couch.png':product.categories.value[index]['Category'].toString()=='Table'?'images/table.png':'images/mix.png')
                                //     //ModelViewer(src: product.categories.value[index]['modelUrl'].toString())
                                // ),
                                ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // ),
                          Center(
                              child: Text(product
                                  .categories.value[index]['Category']
                                  .toString()))
                        ],
                      ),
                    )),
              ),
              SmallerDividerHeading(
                heading: 'Featured Products',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: product.products.length > 6
                          ? 6
                          : product.products.length,
                      //itemCount: product.products.length,

                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Get.to(() => const ProductDetails(), arguments: [
                            '${product.products[index].name}',
                            '${product.products[index].description}',
                            '${product.products[index].modelUrl}',
                            '${product.products[index].price}',
                            '${product.products[index].imageUrl}'
                          ]);
                        },
                        child: Card(
                          elevation: 8,
                          shadowColor:
                              Get.isDarkMode ? Colors.black45 : Colors.black45,
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
                                Container(
                                  height: 110,
                                  width: 110,
                                  child: Image.network(
                                      product.products[index].imageUrl!),
                                  // child: ModelViewer(
                                  //       src: '${product.products[index].modelUrl}', // a bundled asset file
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
                                      '${product.products[index].name!} \n',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '\Rs ${product.products[index].price.toString()} \t',
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28.0, top: 10),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const AllProducts());
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'See All Products',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  // Future<RxList> catGet(){
  //   for(int i=0;i<product.products.length;i++){
  //
  //   var contain = product.categories.where((element) => element['Category'] == "${product.products[i].category.toString()}");
  //   if(contain.isEmpty){
  //     Map catMap={
  //       'Category':product.products[i].category,
  //       'imageUrl':product.products[i].imageUrl
  //     };product.categories.add(catMap);
  //   }
  //
  // }
  //   return Future(() => product.categories);
  // }
}
