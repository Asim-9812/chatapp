import 'package:division/division.dart';
import 'package:firebase/common_widgets/snack_show.dart';
import 'package:firebase/screens/help_screen.dart';
import 'package:firebase/screens/home.dart';
import 'package:firebase/screens/status_page.dart';
import 'package:firebase/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../constants/firebase_instances.dart';
import '../providers/auth_provider.dart';
import '../services/post_service.dart';
import 'aboutus_screen.dart';
import 'edit_profile.dart';

class StatusScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends ConsumerState<StatusScreen> {
  final userId = FirebaseInstances.firebaseAuth.currentUser!.uid;
  late types.User user;
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userStream(userId));
    userData.when(
        data: (data) {
          user = data;
        },
        error: (err, stack) => Text('$err'),
        loading: () => const Center(child: CircularProgressIndicator()));

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Stack(
          children: [
            Container(
              height: 800,
              color: Colors.white,
            ),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.6),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 62),
                    child: InkWell(
                        onTap: () {
                          Get.to(() => HomeScreen());
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                  ),
                  Txt(
                    "Edit Profile",
                    style: TxtStyle()
                      ..fontSize(26)
                      ..padding(top: 32)
                      ..alignmentContent.center()
                      ..fontWeight(FontWeight.bold)
                      ..textColor(Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 140),
                      child: Stack(
                        children: [
                          Container(
                            height: 118,
                            child: userData.when(
                                data: (data) {
                                  user = data;
                                  return Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            NetworkImage(data.imageUrl!),
                                      ),
                                      Text(data.firstName!)
                                    ],
                                  );
                                },
                                error: (err, stack) => Text('$err'),
                                loading: () => const Center(
                                    child: CircularProgressIndicator())),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60, left: 38),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => EditProfile(
                                      user: user,
                                    ));
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    ListTile(
                      onTap: () {
                        Get.to(() => AboutusScreen());
                      },
                      title: Text(
                        "About US",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => HelpScreen());
                      },
                      title: Text(
                        "Help",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        await ref
                            .read(authProvider.notifier)
                            .userLogout()
                            .then((value) => SnackShow.showSuccess(
                                context, 'user logged out'))
                            .then((value) => Get.offAll(StatusPage()));
                        // Get.to(() => HelpScreen());
                      },
                      title: Text(
                        "Log out",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
    ;
  }
}
