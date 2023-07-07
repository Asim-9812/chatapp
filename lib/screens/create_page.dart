// import 'dart:io';

// import 'package:division/division.dart';
// import 'package:firebase/common_widgets/snack_show.dart';
// import 'package:firebase/constants/firebase_instances.dart';
// import 'package:firebase/providers/common_provider.dart';
// import 'package:firebase/providers/post_provider.dart';
// import 'package:firebase/screens/home.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';

// class CreatePageScreen extends ConsumerWidget {
//   final detailController = TextEditingController();
//   final titleController = TextEditingController();
//   final _form = GlobalKey<FormState>();
//   final uid = FirebaseInstances.fireChat.firebaseUser!.uid;

//   @override
//   Widget build(BuildContext context, ref) {
//     ref.listen(postProvider, (previous, next) {
//       if (next.isError) {
//         SnackShow.showFailure(context, next.errMessage);
//       } else if (next.isSuccess) {
//         Get.back();
//         SnackShow.showSuccess(context, "sucess");
//       }
//     });
//     final post = ref.watch(postProvider);
//     final image = ref.watch(imageProvider);
//     final mod = ref.watch(mode);
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 238, 235, 224),
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: SafeArea(
//           child: Form(
//             key: _form,
//             autovalidateMode: mod,
//             child: Stack(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Get.to(() => HomeScreen());
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     child: const Icon(Icons.arrow_back),
//                   ),
//                 ),
//                 const Positioned(
//                   left: 120,
//                   top: 40,
//                   child: Center(
//                       child: const Text(
//                     'Create Post',
//                     style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   )),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 80),
//                   child: Container(
//                     height: 230,
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image:
//                                 AssetImage('assets/images/create post.png'))),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 260),
//                   height: 460,
//                   child: Column(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.all(10.0),
//                       ),
//                       Txt(
//                         "Title",
//                         style: TxtStyle()
//                           ..fontWeight(FontWeight.w400)
//                           ..padding(right: 280),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Container(
//                           height: 64,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: Colors.white24),
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Color.fromRGBO(143, 148, 251, .2),
//                                     blurRadius: 20.0,
//                                     offset: Offset(0, 10))
//                               ]),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 20),
//                             child: TextFormField(
//                               validator: (val) {
//                                 if (val!.isEmpty) {
//                                   return 'Please provide title';
//                                 }
//                                 return null;
//                               },
//                               controller: titleController,
//                               decoration: const InputDecoration(
//                                 prefixIcon: Icon(Icons.mail),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Txt(
//                         "Detail",
//                         style: TxtStyle()
//                           ..fontWeight(FontWeight.w400)
//                           ..padding(right: 280),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Container(
//                           height: 64,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: Colors.white24),
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Color.fromRGBO(143, 148, 251, .2),
//                                     blurRadius: 20.0,
//                                     offset: Offset(0, 10))
//                               ]),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 20),
//                             child: TextFormField(
//                               validator: (val) {
//                                 if (val!.isEmpty) {
//                                   return 'Please provide detail';
//                                 }
//                               },
//                               controller: detailController,
//                               decoration: const InputDecoration(
//                                 prefixIcon: Icon(Icons.password_outlined),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: InkWell(
//                           onTap: () {
//                             Get.defaultDialog(
//                                 title: 'Select',
//                                 content: const Text("Choose form"),
//                                 actions: [
//                                   TextButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                         ref
//                                             .read(imageProvider.notifier)
//                                             .ImagePick(true);
//                                       },
//                                       child: const Text("Camera")),
//                                   TextButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();

//                                         ref
//                                             .read(imageProvider.notifier)
//                                             .ImagePick(false);
//                                       },
//                                       child: const Text("Gallery")),
//                                 ]);
//                           },
//                           child: Container(
//                             height: 80,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                                 color: const Color(0xffD9D9D9),
//                                 border: Border.all(color: Colors.white24),
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Color.fromRGBO(143, 148, 251, .2),
//                                       blurRadius: 20.0,
//                                       offset: Offset(0, 10))
//                                 ]),
//                             child: Center(
//                                 child: image == null
//                                     ? Center(
//                                         child: Text("Please select and image"),
//                                       )
//                                     : Image.file(File(image.path))),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           fixedSize: const Size(190, 54),
//                           primary: Color.fromARGB(255, 228, 148, 146),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0)),
//                         ),
//                         onPressed: post.isLoad
//                             ? null
//                             : () {
//                                 _form.currentState!.save();
//                                 FocusScope.of(context).unfocus();

//                                 if (_form.currentState!.validate()) {
//                                   if (image == null) {
//                                     SnackShow.showFailure(
//                                         context, "please upload an image");
//                                   } else {
//                                     ref.read(postProvider.notifier).postAdd(
//                                         title: titleController.text.trim(),
//                                         detail: detailController.text.trim(),
//                                         userId: uid,
//                                         image: image);
//                                   }
//                                 } else {
//                                   ref.read(mode.notifier).toogle();
//                                 }
//                               },
//                         child: post.isLoad
//                             ? Center(child: CircularProgressIndicator())
//                             : Text(
//                                 'Submit',
//                                 style: TextStyle(
//                                     fontSize: 20, color: Colors.white),
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../common_widgets/snack_show.dart';
import '../constants/firebase_instances.dart';
import '../providers/auth_provider.dart';
import '../providers/common_provider.dart';
import '../providers/post_provider.dart';

class CreatePageScreen extends ConsumerWidget {
  final titleController = TextEditingController();
  final detailController = TextEditingController();

  final _form = GlobalKey<FormState>();

  final uid = FirebaseInstances.fireChat.firebaseUser!.uid;
  @override
  Widget build(BuildContext context, ref) {
    ref.listen(postProvider, (previous, next) {
      if (next.isError) {
        SnackShow.showFailure(context, next.errMessage);
      } else if (next.isSuccess) {
        Get.back();
        SnackShow.showSuccess(context, 'success');
      }
    });

    final post = ref.watch(postProvider);

    final image = ref.watch(imageProvider);
    final mod = ref.watch(mode);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SafeArea(
            child: Form(
              key: _form,
              autovalidateMode: mod,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Create Form',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'please provide title';
                      }
                      return null;
                    },
                    controller: titleController,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        prefixIcon: Icon(Icons.mail),
                        hintText: "Title",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    controller: detailController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'please provide detai;';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        prefixIcon: Icon(Icons.lock),
                        hintText: "detail",
                        border: OutlineInputBorder()),
                  ),
                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          title: 'Select',
                          content: Text('Choose From'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ref
                                      .read(imageProvider.notifier)
                                      .ImagePick(true);
                                },
                                child: Text('Camera')),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ref
                                      .read(imageProvider.notifier)
                                      .ImagePick(false);
                                },
                                child: Text('Gallery')),
                          ]);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: image == null
                          ? Center(child: Text('please select an image'))
                          : Image.file(File(image.path)),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ElevatedButton(
                      onPressed: post.isLoad
                          ? null
                          : () {
                              _form.currentState!.save();
                              FocusScope.of(context).unfocus();
                              if (_form.currentState!.validate()) {
                                if (image == null) {
                                  SnackShow.showFailure(
                                      context, 'please select an image');
                                } else {
                                  ref.read(postProvider.notifier).postAdd(
                                      title: titleController.text.trim(),
                                      detail: detailController.text.trim(),
                                      userId: uid,
                                      image: image);
                                }
                              } else {
                                ref.read(mode.notifier).toogle();
                              }
                            },
                      child: post.isLoad
                          ? Center(child: CircularProgressIndicator())
                          : Text('submit')),
                  SizedBox(
                    height: 6.h,
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
