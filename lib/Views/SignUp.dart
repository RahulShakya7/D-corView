import 'package:flutter/material.dart';
import 'package:fyp/Controller/AuthController.dart';
import 'package:fyp/Views/Login.dart';
import 'package:fyp/Widgets/DividerHeading.dart';
import 'package:get/get.dart';

import 'SignUpWithPhone.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthController auth = Get.find();
  var isLoading = false;
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // decoration: BoxDecoration(
            //
            //   image: DecorationImage(
            //     colorFilter: ColorFilter.linearToSrgbGamma(),
            //     image: AssetImage(
            //         "images/2.png"),
            //     fit: BoxFit.fill,
            //
            //   ),),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Text(
                      "Let's SIGN You UP !!",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            labelText: 'Full Name',
                          ),
                          controller: auth.name,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: auth.email,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: auth.password,
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffix: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(
                                _isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 18,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            //hintStyle: TextStyle(color: Colors.grey[800]),
                            labelText: 'Password',
                            // fillColor: Colors.grey[300]
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // ElevatedButton(onPressed: (){
                        //   auth.signupUserwithEmail(auth.email.text, auth.password.text);
                        // }, child: Text(
                        //   'Sign Up'
                        // )
                        // ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          height: 35,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              var log = await auth.signupUserwithEmail(
                                  auth.email.text,
                                  auth.password.text,
                                  auth.name.text);
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: Builder(builder: (context) {
                              if (isLoading == true) {
                                return const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                return const Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                );
                              }
                            }),
                          ),
                        ),

                        DividerHeading(heading: 'OR'),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Sign In with',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                auth.signInWithGoogle(context);
                              },
                              child: SizedBox(
                                  height: 50,
                                  child: Image.asset('images/google.png')),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => const SignUpWithPhoneNumber());
                              },
                              child: const Icon(
                                Icons.phone,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(fontSize: 14),
                              ),
                              InkWell(
                                  onTap: () {
                                    Get.to(() => const Login());
                                  },
                                  child: Text(
                                    "Login now!!",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Get.isDarkMode
                                            ? Colors.purpleAccent
                                            : Colors.deepPurpleAccent,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
