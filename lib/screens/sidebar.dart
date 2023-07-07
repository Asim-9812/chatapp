import 'package:firebase/screens/create_page.dart';
import 'package:firebase/screens/recentchat_screen.dart';
import 'package:firebase/screens/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:firebase/constants/firebase_instances.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../providers/auth_provider.dart';
import '../services/auth_service.dart';
import '../services/post_service.dart';

class SideMenuScreen extends ConsumerStatefulWidget {
  const SideMenuScreen({super.key});

  @override
  ConsumerState<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends ConsumerState<SideMenuScreen> {
  @override
  final userId = FirebaseInstances.firebaseAuth.currentUser!.uid;
  late types.User user;
  Widget build(BuildContext context) {
    final userData = ref.watch(userStream(userId));
    final users = ref.watch(usersStream);
    final postData = ref.watch(postStream);
    return Scaffold(
      body: Container(
        width: 312,
        color: const Color(0xff17203A),
        child: userData.when(
            data: (data) {
              user = data;
              return ListView(
                children: [
                  ListTile(
                    onTap: () => Get.to(UserDetailPage(user, user.firstName!)),
                    leading: CircleAvatar(
                      radius: 30.sp,
                      backgroundImage: NetworkImage(data.imageUrl!),
                    ),
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.firstName!,
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          data.metadata!['email'],
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                    indent: 20.w,
                    endIndent: 20.w,
                    height: 30.h,
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => RecentChats());
                    },
                    leading: const Icon(
                      Icons.chat,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Recent Chats',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => CreatePageScreen());
                    },
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    title: const Text("Create Post",
                        style: TextStyle(color: Colors.white)),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      ref.read(authProvider.notifier).userLogout();
                    },
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    title: const Text("Signout",
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              );
            },
            error: (err, stack) => Text('$err'),
            loading: () => const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
