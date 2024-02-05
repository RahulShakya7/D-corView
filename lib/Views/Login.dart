import 'package:flutter/material.dart';
import 'package:fyp/Controller/AuthController.dart';
import 'package:fyp/Views/SignUp.dart';
import 'package:fyp/Views/SignUpWithPhone.dart';
import 'package:fyp/Widgets/DividerHeading.dart';
import 'package:get/get.dart';

import 'ResetPassword.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
            // image: DecorationImage(
            //   colorFilter: ColorFilter.linearToSrgbGamma(),
            //   image: AssetImage(
            //       "images/1.jpg"),
            //   fit: BoxFit.fill,
            //
            // ),),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Text(
                      "Let's LOGIN First !!",
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
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => const ForgotPasswordWidget());
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(fontSize: 20),
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
                              var log = await auth.signinUserwithEmail(
                                  auth.email.text, auth.password.text);
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
                                  "Login",
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
                                  child:
                                      Image.asset('assets/images/google.png')),
                            ),
                            // InkWell(
                            //     onTap: (){
                            //       auth.signInWithFacebook(context);
                            //     },
                            //     child: Container(
                            //         height: 50,
                            //         child: Image.asset('images/fb.png')),
                            // ),
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
                                "Dont' have an account? ",
                                style: TextStyle(fontSize: 14),
                              ),
                              InkWell(
                                  onTap: () {
                                    Get.to(() => const SignUp());
                                  },
                                  child: Text(
                                    "Sign Up now!!",
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
