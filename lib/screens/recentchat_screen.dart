import 'package:division/division.dart';
import 'package:firebase/constants/firebase_instances.dart';
import 'package:firebase/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../providers/room_provider.dart';
import 'chat_page.dart';

class RecentChats extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final roomData = ref.watch(roomStream);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(top: 400),
                        color: Colors.white,
                        child: roomData.when(
                            data: (data) {
                              return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final currentUser = FirebaseInstances
                                        .firebaseAuth.currentUser!.uid;
                                    final otherUser = data[index]
                                        .users
                                        .firstWhere((element) =>
                                            element.id != currentUser);
                                    final user = data[index].users.firstWhere(
                                        (element) => element.id == currentUser);

                                    return ListTile(
                                      onTap: () {
                                        Get.to(() => ChatPage(
                                              room: data[index],
                                              currentUser: user.firstName!,
                                              token:
                                                  otherUser.metadata!['token'],
                                            ));
                                      },
                                      leading:
                                          Image.network(data[index].imageUrl!),
                                      title: Text(data[index].name!),
                                      subtitle:
                                          Text("Click here to see the chat"),
                                      trailing: Icon(
                                        Icons.chat,
                                        color: Colors.blue,
                                      ),
                                    );
                                  });
                            },
                            error: (err, stack) => Center(child: Text('$err')),
                            loading: () =>
                                Center(child: CircularProgressIndicator()))),
                  )
                ],
              ),
            ),
            Container(
              height: 400,
              width: 600,
              decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 22,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Txt(
                        "Welcome to Recent chats",
                        style: TxtStyle()
                          ..fontSize(28)
                          ..alignmentContent.center()
                          ..fontWeight(FontWeight.bold)
                          ..textColor(Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        "assets/images/ok9.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
