import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:firebase/constants/firebase_instances.dart';
import 'package:firebase/notication_service.dart';
import 'package:firebase/providers/post_provider.dart';
import 'package:firebase/screens/create_page.dart';
import 'package:firebase/screens/detail_screen.dart';
import 'package:firebase/screens/home.dart';
import 'package:firebase/screens/mystatus_screen.dart';
import 'package:firebase/screens/recentchat_screen.dart';
import 'package:firebase/screens/sidebar.dart';
import 'package:firebase/screens/update_page_screen.dart';
import 'package:firebase/screens/user_detail_page.dart';
import 'package:firebase/services/auth_service.dart';
import 'package:firebase/services/post_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_nav_bar/google_nav_bar.dart';

import '../providers/auth_provider.dart';

class DefaultScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<DefaultScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<DefaultScreen> {
  final userId = FirebaseInstances.firebaseAuth.currentUser!.uid;
  late types.User user;

  int _indexSelected = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    CreatePageScreen(),
    RecentChats(),
    StatusScreen()
  ];


  @override
  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    getToken();
  }

  Future<void> getToken() async {
    final response = await FirebaseMessaging.instance.getToken();
    print('notification token : $response');
  }

  Widget build(BuildContext context) {
    final userData = ref.watch(userStream(userId));
    final users = ref.watch(usersStream);
    final postData = ref.watch(postStream);

    userData.when(
        data: (data) {
          user = data;
        },
        error: (err, stack) => Text('$err'),
        loading: () => const Center(child: CircularProgressIndicator()));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.withOpacity(0.3),
          title: Text("Welcome to ChitChat"),
        ),
        bottomNavigationBar: GNav(
          activeColor: const Color(0xffd36868),
          color: Colors.black45,
          tabBackgroundColor: const Color(0xFFF1EFEF),
          padding: const EdgeInsets.all(16),
          gap: 10,
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 400),
          tabs: [
            GButton(
              onPressed: (){
                setState(() {
                  _indexSelected=0;
                });
              },
              icon: Icons.home,
              text: 'Home',
              textSize: 12,
            ),
            GButton(
                onPressed: (){
                  setState(() {
                    _indexSelected=1;
                  });
                },
                icon: Icons.upload_file_outlined,
                text: 'Upload',
                textSize: 12),
            GButton(
                onPressed: (){
                  setState(() {
                    _indexSelected=2;
                  });
                },
                icon: Icons.chat_bubble_outline_outlined,
                text: 'Chat',
                textSize: 12),
            GButton(
                onPressed: (){
                  setState(() {
                    _indexSelected=3;
                  });
                },
                icon: Icons.logout_outlined,
                text: '',
                textSize: 12),
          ],

          selectedIndex: _indexSelected,
          onTabChange: (index) {
            _indexSelected = index;
          },
        ),
        drawer: Drawer(
          shadowColor: Colors.red,
          child: userData.when(
              data: (data) {
                user = data;
                return ListView(
                  children: [
                    ListTile(
                      onTap: () =>
                          Get.to(UserDetailPage(user, user.firstName!)),
                      leading: CircleAvatar(
                        radius: 30.sp,
                        backgroundImage: NetworkImage(data.imageUrl!),
                      ),
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.firstName!),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(data.metadata!['email'])
                        ],
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.black,
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
                      leading: const Icon(Icons.chat),
                      title: Text('Recent Chats'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => CreatePageScreen());
                      },
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text("Create Post"),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        ref.read(authProvider.notifier).userLogout();
                      },
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text("Signout"),
                    )
                  ],
                );
              },
              error: (err, stack) => Text('$err'),
              loading: () => const Center(child: CircularProgressIndicator())),
        ),
        body: _pages.elementAt(_indexSelected),);
  }
}
