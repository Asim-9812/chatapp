import 'package:division/division.dart';
import 'package:firebase/screens/signup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'mystatus_screen.dart';

class ChoosingScrenn extends StatelessWidget {
  const ChoosingScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Txt(
                  "Spark conversations with \n          Chitchat app ",
                  style: TxtStyle()
                    ..fontSize(28)
                    ..fontWeight(FontWeight.bold)
                    ..padding(top: 500, left: 40)
                    ..textColor(Colors.black),
                ),
                Txt(
                  "Discover a world of endless conversations with Chitchat - your virtual social hub and lets enjoy.",
                  style: TxtStyle()
                    ..fontSize(16)
                    ..padding(left: 28, right: 28, top: 8)
                    ..fontWeight(FontWeight.normal)
                    ..textColor(Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 36, left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 60,
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    16), // Adjust the radius value to make it rounder
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors
                                      .white; // Color when button is pressed
                                }
                                return Colors.pink
                                    .withOpacity(0.3); // Default color
                              },
                            ),
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered))
                                  return Colors.redAccent;
                                return null; // Defer to the widget's default.
                              },
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => SignUpScreen());
                            },
                            child: const Text(
                              'Lets Start',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 460,
            width: 600,
            decoration: BoxDecoration(
                color: const Color(0xffdc95fb),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/ok9.png"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
