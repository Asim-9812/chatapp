// import 'package:division/division.dart';
// import 'package:firebase/common_widgets/snack_show.dart';
// import 'package:firebase/constants/firebase_instances.dart';
// import 'package:firebase/providers/auth_provider.dart';
// import 'package:firebase/screens/aboutus_screen.dart';
// import 'package:firebase/screens/edit_profile.dart';
// import 'package:firebase/screens/help_screen.dart';
// import 'package:firebase/screens/home.dart';
// import 'package:firebase/screens/my_profile_screen.dart';
// import 'package:firebase/screens/status_page.dart';
// import 'package:firebase/screens/user_detail_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// import '../main.dart';
// import '../models/post.dart';
// import '../providers/room_provider.dart';
// import '../services/auth_service.dart';
// import '../services/post_service.dart';

// class Mystatus extends ConsumerWidget {
//   const Mystatus({super.key});

//   @override
//   Widget build(BuildContext context, ref) {
//        final userData = ref.watch(userStream(userId));
//     final users = ref.watch(usersStream);
//     final postData = ref.watch(postStream);
//     final userId = FirebaseInstances.firebaseAuth.currentUser!.uid;
//     late types.User user;
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//             child: Stack(
//           children: [
//             Container(
//               height: 800,
//               color: Colors.white,
//             ),
//             Container(
//               height: 300,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: Colors.pink.withOpacity(0.6),
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(60),
//                       bottomRight: Radius.circular(60))),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 16, top: 26),
//                     child: InkWell(
//                         onTap: () {
//                           Get.to(() => HomeScreen());
//                         },
//                         child: Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.white,
//                         )),
//                   ),
//                   Txt(
//                     "Edit Profile",
//                     style: TxtStyle()
//                       ..fontSize(26)
//                       ..padding(top: 32)
//                       ..alignmentContent.center()
//                       ..fontWeight(FontWeight.bold)
//                       ..textColor(Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 250),
//               child: Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                         height: 118,
//                         child: userData.when(data: (data) {
//                           user = data;
//                           return CircleAvatar(
//                             radius: 40,
//                             backgroundImage: NetworkImage(data.imageUrl!),
//                           );
//                         })),
//                     const SizedBox(height: 26),
//                     ListTile(
//                       onTap: () {
//                         Get.to(() => AboutusScreen());
//                       },
//                       title: Text(
//                         "About US",
//                         style: TextStyle(
//                             fontSize: 18.sp, fontWeight: FontWeight.bold),
//                       ),
//                       trailing: Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16.sp,
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () {
//                         Get.to(() => HelpScreen());
//                       },
//                       title: Text(
//                         "Help",
//                         style: TextStyle(
//                             fontSize: 18.sp, fontWeight: FontWeight.bold),
//                       ),
//                       trailing: Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16.sp,
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () async {
//                         await ref
//                             .read(authProvider.notifier)
//                             .userLogout()
//                             .then((value) => SnackShow.showSuccess(
//                                 context, 'user logged out'))
//                             .then((value) => Get.offAll(StatusPage()));
//                         // Get.to(() => HelpScreen());
//                       },
//                       title: Text(
//                         "Log out",
//                         style: TextStyle(
//                             fontSize: 18.sp, fontWeight: FontWeight.bold),
//                       ),
//                       trailing: Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         )),
//       ),
//     );
//   }
// }
