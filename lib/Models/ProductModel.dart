import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/Controller/ProductController.dart';

class ProductModel{
  String? name;
  String? description;
  String? category;
  String? modelUrl;
  String? imageUrl;
  dynamic price;
  ProductModel({this.name,this.category,this.description,this.modelUrl,this.price,this.imageUrl});
  ProductModel.fromMap(DocumentSnapshot data){
    name=data['name'];
    category=data['category'];
    description=data['description'];
    modelUrl=data['modelUrl'];
    price=data['price'];
    imageUrl=data['imageUrl'];
  }
}