import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Views/MainPage.dart';
import 'package:get/get.dart';

import '../Models/user_model.dart';
import '../Widgets/TextField.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Form(
        key: key,
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).snapshots(),
          builder: (context,snapshot){

            if(snapshot.data==null){
              return Container();
            }
            name.text=snapshot.data!['name'].toString();
            email.text=snapshot.data!['email'].toString();
            phone.text=snapshot.data!['userPhone'].toString();
            print(snapshot.data!['name']);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                child: Column(
                  children: [

                    CustomTextField(
                      controllers: name,
                      labelText: 'Full Name',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Field Required";
                        }
                      },
                    ),CustomTextField(
                      controllers: email,
                      labelText: 'Email Address',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Field Required";
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration( border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                            filled: true,
                            labelText: 'Phone Number'
                        ),
                        autovalidateMode: AutovalidateMode.always,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Field Required";
                          }
                        },
                      ),
                    ),
                    ElevatedButton(onPressed: () async{
    if (key.currentState!.validate()) {
      UserModel userModel = UserModel();
      userModel.userPhone=phone.text;
      userModel.email = email.text;
      userModel.userId = FirebaseAuth.instance.currentUser!.uid.toString();
      //userModel.address='';
      userModel.name = name.text;
      await FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid.toString()).update(
          userModel.asMap());
      Get.snackbar('Successful', 'User Data Updated Successfully',duration: const Duration(seconds: 2),backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);

    }
    Get.off(MainPage());
    }, child: Text('Save Data'))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
