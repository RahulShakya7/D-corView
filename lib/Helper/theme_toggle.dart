import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({Key? key}) : super(key: key);

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  bool darkTheme = false;
  RxBool isLightTheme = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ObxValue(
        (data) => Switch(
          value: isLightTheme.value,
          onChanged: (val) {
            isLightTheme.value = val;
            Get.changeThemeMode(
              isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
            );
            //saveThemeStatus();
          },
        ),
        false.obs,
      ),
    );
  }
}
