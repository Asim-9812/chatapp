import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:image_picker/image_picker.dart';

import '../constants/firebase_instances.dart';
import '../providers/room_provider.dart';

class ChatPage extends ConsumerStatefulWidget {
  final types.Room room;
  final String currentUser;
  final String token;
  const ChatPage(
      {required this.room, required this.currentUser, required this.token});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  bool _isAttachmentUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final roomMessage = ref.watch(messageStream(widget.room));

        return roomMessage.when(
            data: (data) {
              return Chat(
                showUserAvatars: true,
                showUserNames: true,
                isAttachmentUploading: _isAttachmentUploading,
                messages: data,
                onAttachmentPressed: () {
                  final ImagePicker _picker = ImagePicker();
                  _picker
                      .pickImage(source: ImageSource.gallery)
                      .then((value) async {
                    if (value != null) {
                      setState(() {
                        _isAttachmentUploading = true;
                      });
                      final ref = FirebaseInstances.fireStorage
                          .ref()
                          .child('chatImage/${value.name}');
                      await ref.putFile(File(value.path));
                      final url = await ref.getDownloadURL();
                      setState(() {
                        _isAttachmentUploading = false;
                      });
                      final imageMessage = types.PartialImage(
                          name: value.name,
                          uri: url,
                          size: File(value.path).lengthSync());
                      FirebaseChatCore.instance.sendMessage(
                        imageMessage,
                        widget.room.id,
                      );
                    }
                  });
                },
                onSendPressed: (types.PartialText message) async {
                  FirebaseChatCore.instance.sendMessage(
                    message,
                    widget.room.id,
                  );
                  final dio = Dio();
                  try {
                    final response =
                        await dio.post('https://fcm.googleapis.com/fcm/send',
                            data: {
                              "to" : widget.token,
                              "priority": "High",
                              "android_channel_id": "High_importance_channel",
                              "notification":{
                                "title": widget.currentUser,
                                "body": message.text,
                              }

                            },
                            options: Options(headers: {
                              HttpHeaders.authorizationHeader:
                                  'key=AAAAkixznTY:APA91bGBfOSQxEgu_n6U270JqzJZuBsacL2x2MsBK358s3vC4jhBwfZArkRNmS9SrBWj7e3yNQH67wLopRFNjWoRmzkUF8qh35Kpwzoxy3fqCPhMUVlp5_qZYbQtHiGtKKkRQrU1NST_'
                            }));
                    print(response.data);
                    print('token : ${widget.token}');
                  } on FirebaseException catch (err) {
                    print(err);
                  }
                },
                user: types.User(
                  id: FirebaseChatCore.instance.firebaseUser!.uid,
                ),
              );
            },
            error: (err, stack) => Center(child: Text('$err')),
            loading: () => Center(child: CircularProgressIndicator()));
      }),
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }
}
