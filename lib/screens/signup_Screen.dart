import 'dart:io';

import 'package:division/division.dart';
import 'package:firebase/common_widgets/snack_show.dart';
import 'package:firebase/providers/auth_provider.dart';
import 'package:firebase/providers/common_provider.dart';
import 'package:firebase/screens/forgot_password.dart';
import 'package:firebase/screens/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class SignUpScreen extends ConsumerWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(authProvider, (previous, next) {
      if (next.isError) {
        SnackShow.showFailure(context, next.errMessage);
      } else if (next.isSuccess) {
        SnackShow.showSuccess(context, "success");
      }
    });
    final auth = ref.watch(authProvider);
    final isLogin = ref.watch(loginProvider);
    final image = ref.watch(imageProvider);
    final mod = ref.watch(mode);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              autovalidateMode: mod,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/choosing1.png'),
                      )),
                    ),
                  ),
                  Positioned(
                    left: 140,
                    top: 270,
                    child: Center(
                      child: Text(
                        isLogin ? 'Login Form' : 'SignUp ',
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 1, 1, 1)),
                      )
                          .animate()
                          .fadeIn() // uses `Animate.defaultDuration`
                          .scale() // inherits duration from fadeIn
                          .move(delay: 300.ms, duration: 600.ms),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 320),
                      height: 420,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 242, 238, 238),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //     color: Color.fromRGBO(143, 148, 251, .2),
                                    //     blurRadius: 20.0,
                                    //     offset: Offset(0, 10))
                                  ]),
                              child: isLogin
                                  ? SizedBox.shrink()
                                  : TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(20)
                                      ],
                                      controller: nameController,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Please provide valid username';
                                        } else if (val.length > 20) {
                                          return "minimum characters reeached";
                                        }
                                      },
                                      key: const Key('txtUsername'),
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          border: InputBorder.none,
                                          hintText: "Username"),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 12),
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 235, 233, 233),
                                border: Border.all(color: Colors.white24),
                                borderRadius: BorderRadius.circular(12),
                                // boxShadow: const [
                                //   BoxShadow(
                                //       color: Color.fromRGBO(143, 148, 251, .2),
                                //       blurRadius: 20.0,
                                //       offset: Offset(0, 10))
                                // ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please provide valid email';
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)) return null;
                                  },
                                  controller: emailController,
                                  key: const Key('txtUsername'),
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.mail),
                                      border: InputBorder.none,
                                      hintText: "Email"),
                                ),
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn() // uses `Animate.defaultDuration`
                              .scale() // inherits duration from fadeIn
                              .move(delay: 300.ms, duration: 600.ms),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 18, top: 12),
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 234, 233, 233),
                                  border: Border.all(color: Colors.white24),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //     color: Color.fromRGBO(143, 148, 251, .2),
                                    //     blurRadius: 20.0,
                                    //     offset: Offset(0, 10))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please provide password';
                                    } else if (val.length > 16) {
                                      return "minimum characters reached";
                                    }
                                  },
                                  controller: passwordController,
                                  key: const Key('txtUsername'),
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.password_outlined),
                                      border: InputBorder.none,
                                      hintText: "Password"),
                                ),
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn() // uses `Animate.defaultDuration`
                              .scale() // inherits duration from fadeIn
                              .move(delay: 300.ms, duration: 600.ms),
                          InkWell(
                            onTap: () {
                              Get.to(() => ForgotPasswordScreen());
                            },
                            child: Txt(
                              isLogin ? 'Forgot Password?' : "",
                              style: TxtStyle()
                                ..textColor(Colors.grey)
                                ..padding(left: 200, top: 8)
                                ..fontSize(14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: isLogin
                                ? SizedBox.shrink()
                                : InkWell(
                                    onTap: () {
                                      Get.defaultDialog(
                                          title: 'Select',
                                          content: Text("Choose form"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  ref
                                                      .read(imageProvider
                                                          .notifier)
                                                      .ImagePick(true);
                                                },
                                                child: Text("Camera")),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();

                                                  ref
                                                      .read(imageProvider
                                                          .notifier)
                                                      .ImagePick(false);
                                                },
                                                child: Text("Gallery")),
                                          ]);
                                    },
                                    child: Container(
                                      height: 70,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 201, 196, 196),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, .2),
                                                blurRadius: 20.0,
                                                offset: Offset(0, 10))
                                          ]),
                                      child: Center(
                                          child: image == null
                                              ? const Center(
                                                  child: Text(
                                                      "Please select and image"),
                                                )
                                              : Image.file(File(image.path))),
                                    ),
                                  ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            height: 60,
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                      _form.currentState!.save();
                                      FocusScope.of(context).unfocus();

                                      if (_form.currentState!.validate()) {
                                        if (isLogin) {
                                          ref
                                              .read(authProvider.notifier)
                                              .userLogin(
                                                  email: emailController
                                                      .text
                                                      .trim(),
                                                  password: passwordController
                                                      .text
                                                      .trim()).then((value) => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => StatusPage(),
                                            ),
                                          ));
                                        } else {
                                          if (image == null) {
                                            SnackShow.showFailure(context,
                                                "please upload an image");
                                          } else {
                                            ref
                                                .read(authProvider.notifier)
                                                .userSignUp(
                                                    email: emailController.text
                                                        .trim(),
                                                    password: passwordController
                                                        .text
                                                        .trim(),
                                                    username: nameController
                                                        .text
                                                        .trim(),
                                                    image: image).then((value) => Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => StatusPage(),
                                              ),
                                            ));
                                          }
                                        }
                                      } else {
                                        ref.read(mode.notifier).toogle();
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: Colors.pink.withOpacity(0.3),
                              ),
                              child: auth.isLoad
                                  ? CircularProgressIndicator()
                                  : Text(
                                      isLogin ? 'Login' : 'SignUp',
                                      style: const TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: Row(
                              children: [
                                Text(isLogin
                                    ? 'Don\'t have an account'
                                    : "Already a member?"),
                                TextButton(
                                    onPressed: () {
                                      _form.currentState!.reset();
                                      ref.read(mode.notifier).disable();

                                      ref.read(loginProvider.notifier).toogle();
                                    },
                                    child: Expanded(
                                      child: Text(
                                        isLogin ? "SignUp" : "Login",
                                        style: const TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
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
