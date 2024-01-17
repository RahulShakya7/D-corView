import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Controller/AuthController.dart';
import 'package:fyp/Views/Admin_Panel/AdminPanel.dart';
import 'package:fyp/Views/MyOrders.dart';
import 'package:fyp/Views/profile_screen.dart';
import 'package:get/get.dart';

import '../Helper/theme_toggle.dart';

class NavDrawer extends StatelessWidget {
  AuthController auth = Get.find();

  NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // key:MainPage().drawerscaffoldkey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //image: AssetImage('images/erp-gold.png')
              // )
            ),
            child: Text(
              'Settings',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () async {
              Get.to(() => const ProfileScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('My Orders'),
            onTap: () async {
              Get.to(() => const MyOrders());
            },
          ),
          Builder(builder: (context) {
            return ListTile(
              leading: Get.isDarkMode
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
              title: Get.isDarkMode
                  ? const Text('Light Mode')
                  : const Text('Dark Mode'),
              trailing:
                  const SizedBox(height: 30, width: 40, child: ThemeToggle()),
            );
          }),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () async {
              auth.logoutUser();
            },
          ),
          Builder(builder: (context) {
            if (FirebaseAuth.instance.currentUser!.email.toString() ==
                'shayaniqbal515@gmail.com') {
              return ListTile(
                leading: const Icon(Icons.person_outlined),
                title: const Text('Admin Panel'),
                onTap: () async {
                  Get.to(() => const AdminPanel());
                },
              );
            } else {
              return const Text('');
            }
          }),
        ],
      ),
    );
  }
}
