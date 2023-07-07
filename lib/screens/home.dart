import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:firebase/constants/firebase_instances.dart';
import 'package:firebase/notication_service.dart';
import 'package:firebase/providers/post_provider.dart';
import 'package:firebase/screens/create_page.dart';
import 'package:firebase/screens/detail_screen.dart';
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




class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final userId = FirebaseInstances.firebaseAuth.currentUser!.uid;
  late types.User user;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  //   // 1. This method call when app in terminated state and you get a notification
  //   // when you click on notification app open from terminated state and you can get notification data in this method
  //
  //   FirebaseMessaging.instance.getInitialMessage().then(
  //     (message) {
  //       print("FirebaseMessaging.instance.getInitialMessage");
  //       if (message != null) {
  //         print("New Notification");
  //         // if (message.data['_id'] != null) {
  //         //   Navigator.of(context).push(
  //         //     MaterialPageRoute(
  //         //       builder: (context) => DemoScreen(
  //         //         id: message.data['_id'],
  //         //       ),
  //         //     ),
  //         //   );
  //         // }
  //         LocalNotificationService.createanddisplaynotification(message);
  //       }
  //     },
  //   );
  //
  //   // 2. This method only call when App in foreground it mean app must be opened
  //   FirebaseMessaging.onMessage.listen(
  //     (message) {
  //       print("FirebaseMessaging.onMessage.listen");
  //       if (message.notification != null) {
  //         print(message.notification!.title);
  //         print(message.notification!.body);
  //         print("message.data11 ${message.data}");
  //         LocalNotificationService.createanddisplaynotification(message);
  //       }
  //     },
  //   );
  //
  //   // 3. This method only call when App in background and not terminated(not closed)
  //   FirebaseMessaging.onMessageOpenedApp.listen(
  //     (message) {
  //       print("FirebaseMessaging.onMessageOpenedApp.listen");
  //       if (message.notification != null) {
  //         print(message.notification!.title);
  //         print(message.notification!.body);
  //         print("message.data22 ${message.data['_id']}");
  //         LocalNotificationService.createanddisplaynotification(message);
  //       }
  //     },
  //   );
  //   getToken();
  // }
  //
  // Future<void> getToken() async {
  //   final response = await FirebaseMessaging.instance.getToken();
  //   print('notification token : $response');
  // }

  Future<void> fetchData() async {
    // Simulate an asynchronous data fetching process
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }


  Widget build(BuildContext context) {
    final userData = ref.watch(userStream(userId));
    final users = ref.watch(usersStream);
    final postData = ref.watch(postStream);
    int _indexSelected = 0;
    userData.when(
        data: (data) {
          user = data;
        },
        error: (err, stack) => Text('$err'),
        loading: () => const Center(child: CircularProgressIndicator()));

    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Txt(
                "Friends",
                style: TxtStyle()
                  ..padding(right: 308, top: 8)
                  ..textColor(Colors.grey)
                  ..fontWeight(FontWeight.bold)
                  ..fontSize(19),
              ),
              Container(
                height: 118,
                child: users.when(
                    data: (data) {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                        () => UserDetailPage(
                                        data[index], user.firstName!),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 79,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(52),
                                        color: const Color.fromARGB(
                                            255, 204, 54, 43)
                                            .withOpacity(0.4),
                                      ),
                                      child: CircleAvatar(
                                        radius: 36,
                                        backgroundImage:
                                        NetworkImage(data[index].imageUrl!),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(data[index].firstName!)
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    error: (err, stack) => Center(child: Text('$err')),
                    loading: () => Center(child: CircularProgressIndicator())

                  //
                ),
              ),
              Container(
                height: 2,
                color: Colors.grey[300],
                margin: EdgeInsets.symmetric(horizontal: 20),
              ),
              Expanded(
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : postData.when(
                      data: (data) {
                        return ListView.builder(
                            padding: EdgeInsets.only(top: 8),
                            itemCount: data.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              padding:
                                              EdgeInsets.only(left: 14),
                                              width: 290,
                                              child: Txt(
                                                data[index].title,
                                                style: TxtStyle()
                                                  ..fontWeight(FontWeight.w500)
                                                  ..fontSize(15),
                                              )),
                                          if (data[index].userId == userId)
                                            Container(
                                              child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  constraints: BoxConstraints(),
                                                  onPressed: () {
                                                    Get.defaultDialog(
                                                        title: 'Customize Post',
                                                        titleStyle:
                                                        const TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                        content: const Text(
                                                            'Edit or Remove Post'),
                                                        actions: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              Parent(
                                                                style:
                                                                ParentStyle()
                                                                  ..height(
                                                                      60)
                                                                  ..width(
                                                                      90)
                                                                  ..borderRadius(
                                                                      topLeft:
                                                                      6,
                                                                      topRight:
                                                                      6)
                                                                  ..alignmentContent
                                                                      .center(
                                                                      true)
                                                                  ..elevation(
                                                                      3)
                                                                  ..background
                                                                      .color(
                                                                      const Color(0xffAECBD6)),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                    Get.to(() =>
                                                                        UpdatePage(
                                                                            data[index]));
                                                                  },
                                                                  child:
                                                                  const Text(
                                                                    "Edit",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                              Parent(
                                                                style:
                                                                ParentStyle()
                                                                  ..height(
                                                                      60)
                                                                  ..borderRadius(
                                                                      topLeft:
                                                                      6,
                                                                      topRight:
                                                                      6)
                                                                  ..width(
                                                                      90)
                                                                  ..alignmentContent
                                                                      .center(
                                                                      true)
                                                                  ..elevation(
                                                                      3)
                                                                  ..background
                                                                      .color(
                                                                      const Color(0xffAECBD6)),
                                                                child:
                                                                const Text(
                                                                  "Delete",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ]);
                                                  },
                                                  icon: const Icon(
                                                    Icons.more_horiz_rounded,
                                                    color: Colors.black,
                                                  )),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      // InkWell(
                                      //   onTap: () {
                                      //     Get.to(() => DetailPageScreen(
                                      //         data[index], user));
                                      //   },
                                      //   child: CachedNetworkImage(
                                      //     height: 280,
                                      //     fit: BoxFit.cover,
                                      //     width: double.infinity,
                                      //     imageUrl: data[index].imageUrl,
                                      //   ),
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => DetailPageScreen(
                                              data[index], user));
                                        },
                                        child: Container(
                                          height: 270,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(40),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 2,
                                                  blurRadius: 20,
                                                  offset: Offset(0, 10),
                                                ),
                                              ],
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      data[index].imageUrl)
                                              )
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 12,
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                        thickness: 2.0,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              data[index].detail,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              if (data[index].userId != userId)
                                                IconButton(
                                                  onPressed: () {
                                                    if (data[index]
                                                        .like
                                                        .usernames
                                                        .contains(user.firstName)) {
                                                      ScaffoldMessenger.of(context)
                                                          .hideCurrentSnackBar();
                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          duration:
                                                          Duration(seconds: 1),
                                                          content: Text(
                                                              'You have already liked this post'),
                                                        ),
                                                      );
                                                    } else {
                                                      ref
                                                          .read(
                                                          postProvider.notifier)
                                                          .addLike(
                                                        [
                                                          ...data[index]
                                                              .like
                                                              .usernames,
                                                          user.firstName!
                                                        ],
                                                        data[index].postId,
                                                        data[index].like.likes,
                                                      );
                                                    }
                                                  },
                                                  icon: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 66),
                                                    child: Icon(
                                                      Icons.thumb_up_alt_outlined,
                                                      size: 20,
                                                      color: data[index]
                                                          .like
                                                          .usernames
                                                          .contains(
                                                          user.firstName)
                                                          ? Colors
                                                          .red // Change the color to red when the post is already liked
                                                          : Colors
                                                          .black, // Default color when the post is not liked
                                                    ),
                                                  ),
                                                  padding:
                                                  EdgeInsets.only(right: 76),
                                                ),
                                              if (data[index].like.likes != 0)
                                                Text('${data[index].like.likes}'),
                                            ]
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      error: (err, stack) => Center(child: Text('$err')),
                      loading: () =>
                      const Center(child: CircularProgressIndicator()
                      )
                  )
              )
            ],
          ),
        )
        );
  }
}
