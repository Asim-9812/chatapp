import 'package:division/division.dart';

import 'package:firebase/screens/edit_profile.dart';
import 'package:firebase/screens/home.dart';
import 'package:firebase/services/post_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

import '../models/book.dart';
import '../providers/room_provider.dart';
import 'chat_page.dart';

class UserDetailPage extends ConsumerWidget {
  final types.User user;
  final String currentUserName;
  UserDetailPage(this.user, this.currentUserName);

  @override
  Widget build(BuildContext context, ref) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final postData = ref.watch(postStream);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios_new)),
                  if (user.id == uid)
                    InkWell(
                        onTap: () {
                          Get.to(EditProfile(
                            user: user,
                          ));
                        },
                        child: Icon(Icons.edit)),
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  height: 500,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(30))),
                        padding: EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              ' You can ',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 25),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Message',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Discover your friends',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 200,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  promoCard('assets/images/recent1.jpeg'),
                                  promoCard('assets/images/walkthrough_3.png'),
                                  promoCard('assets/images/walkthrough_2.png'),
                                  promoCard('assets/images/walthrough_1.png'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/Chitchat.png')),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      stops: [
                                        0.3,
                                        0.9
                                      ],
                                      colors: [
                                        Colors.black.withOpacity(.8),
                                        Colors.black.withOpacity(.2)
                                      ]),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'Best Design',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(user.imageUrl!),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Txt("Username"),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffD9D9D9),
                                        border:
                                            Border.all(color: Colors.white24),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  143, 148, 251, .2),
                                              blurRadius: 20.0,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: Txt(
                                      user.firstName!,
                                      style: TxtStyle()
                                        ..alignmentContent.center(true)
                                        ..width(160),
                                    ),
                                  ),
                                ),

                                // Text(user.firstName!),
                                // Text(user.metadata!['email']),

                                if (user.id != uid)
                                  Center(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(90, 54),
                                          primary: Colors.pink.withOpacity(0.3),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                        ),
                                        onPressed: () async {
                                          final response = await ref
                                              .read(roomProvider)
                                              .createRoom(user);
                                          if (response != null) {
                                            Get.to(() => ChatPage(
                                                  room: response,
                                                  token:
                                                      user.metadata!['token'],
                                                  currentUser: currentUserName,
                                                ));
                                          }
                                        },
                                        child: Text('Message')),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
              // Expanded(
              //     child: postData.when(
              //         data: (data) {
              //           final userPost = data
              //               .where((element) => element.userId == user.id)
              //               .toList();
              //           return GridView.builder(
              //               itemCount: userPost.length,
              //               gridDelegate:
              //                   SliverGridDelegateWithFixedCrossAxisCount(
              //                       crossAxisCount: 3,
              //                       childAspectRatio: 2 / 3,
              //                       crossAxisSpacing: 5,
              //                       mainAxisSpacing: 5),
              //               itemBuilder: (context, index) {
              //                 return Image.network(userPost[index].imageUrl);
              //               });
              //         },
              //         error: (err, stack) => Center(child: Text('$err')),
              //         loading: () =>
              //             Center(child: CircularProgressIndicator())))
            ],
          ),
        ),
      ),
    );
  }
}
//   }
// }

Widget promoCard(image) {
  return AspectRatio(
    aspectRatio: 2.62 / 3,
    child: Container(
      margin: EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
              0.1,
              0.9
            ], colors: [
              Colors.black.withOpacity(.8),
              Colors.black.withOpacity(.1)
            ])),
      ),
    ),
  );
}
