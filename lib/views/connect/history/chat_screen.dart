// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:rashi_network/services/api/api_service.dart';
// import 'package:rashi_network/services/web_view_screen/WebViewScreen.dart';
// import 'package:rashi_network/utils/commonWidget.dart';
// import 'package:rashi_network/utils/controller/get_profile_controller.dart';
// import 'package:rashi_network/utils/snackbar.dart';
// import 'package:rashi_network/views/connect/chat/controller/chatReq_controller.dart';
// import 'package:rashi_network/views/home_controller.dart';
//
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:rashi_network/ui/theme/text.dart';
// import 'package:rashi_network/utils/design_colors.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String name;
//   final String url;
//   final String convoId;
//
//   const ChatScreen({super.key, required this.name, required this.url, required this.convoId});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
//   bool openDocumentButtm = false;
//   final controller = ScrollController();
//   final text = TextEditingController();
//   List<Map<String, dynamic>> chatConversations = [
//     {
//       'messages': 'Hi Alice, how are you? admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hey Bob, what\'s up?',
//       'isAdminOnly': false,
//     },
//     {
//       'messages': 'Welcome to our chat app! admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hi Alice, how are you?',
//       'isAdminOnly': false,
//     },
//     {
//       'messages': 'Hi Alice, how are you? admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hey Bob, what\'s up?',
//       'isAdminOnly': false,
//     },
//     {
//       'messages': 'Welcome to our chat app! admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hi Alice, how are you?',
//       'isAdminOnly': false,
//     },
//     {
//       'messages': 'Hi Alice, how are you? admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hey Bob, what\'s up?',
//       'isAdminOnly': false,
//     },
//     {
//       'messages': 'Welcome to our chat app! admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hi Alice, how are you?',
//       'isAdminOnly': false,
//     },
//     {
//       'messages': 'Hi Alice, how are you? admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hey Bob, what\'s up?',
//       'isAdminOnly': false,
//     },
//     {
//       'messages': 'Welcome to our chat app! admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hi Alice, how are you?',
//       'isAdminOnly': false,
//     },
//     {
//       'messages': 'Hi Alice, how are you? admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hey Bob, what\'s up?',
//       'isAdminOnly': false,
//     },
//     {
//       'messages': 'Welcome to our chat app! admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hi Alice, how are you?',
//       'isAdminOnly': false,
//     },
//     {
//       'messages': 'Hi Alice, how are you? admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hey Bob, what\'s up?',
//       'isAdminOnly': false,
//     },
//     {
//       'messages': 'Welcome to our chat app! admin',
//       'isAdminOnly': true,
//     },
//     {
//       'messages': 'Hi Alice, how are you?',
//       'isAdminOnly': false,
//     },
//   ];
//
//   RxInt totalSecondSpent = 0.obs;
//   late Timer timer;
//
//   @override
//   void initState() {
//     log(widget.convoId, name: "CONVO ID");
//     WidgetsBinding.instance.addObserver(this);
//
//     // TODO: implement initState
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       totalSecondSpent.value = totalSecondSpent.value + 1;
//       log(totalSecondSpent.value.toString(), name: 'TIME SPENT IN SEC');
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     log('DISPOSE');
//     // TODO: implement dispose
//     timer.cancel();
//     WidgetsBinding.instance.removeObserver(this);
// /*
//     ChatController.to.endChatApi(
//         data: {"convoid": widget.convoId, "duration": totalSecondSpent.value, "endtime": DateTime.now().toString()},
//         success: () {
//           // Get.offAll(() => HomeController());
//         },
//         error: (e) {
//           showSnackBar(title: ApiConfig.error, message: e.toString());
//         });*/
//     super.dispose();
//   }
//
//   @override
//   didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);
//     switch (state) {
//       case AppLifecycleState.resumed:
//         log('AppLifecycleState resumed');
//
//         break;
//       case AppLifecycleState.inactive:
//         await ChatController.to.endChatApi(
//             data: {"convoid": widget.convoId, "duration": totalSecondSpent.value, "endtime": DateTime.now().toString()},
//             success: () {
//               // Get.offAll(() => HomeController());
//             },
//             error: (e) {
//               showSnackBar(title: ApiConfig.error, message: e.toString());
//             });
//         Get.offAll(() => const HomeController());
//         GetProfileController.to.getProfileApi(params: {});
//
//         log('AppLifecycleState inactive');
//         break;
//
//       // TODO: Handle this case.
//       case AppLifecycleState.detached:
//         log('AppLifecycleState detached');
//         break;
//       // TODO: Handle this case.
//
//       case AppLifecycleState.paused:
//         /* Get.offAll(() => const HomeController());
//         GetProfileController.to.getProfileApi(params: {});
//         timer.cancel();
//         ChatController.to.endChatApi(
//             data: {"convoid": widget.convoId, "duration": totalSecondSpent.value, "endtime": DateTime.now().toString()},
//             success: () {
//               // Get.offAll(() => HomeController());
//             },
//             error: (e) {
//               showSnackBar(title: ApiConfig.error, message: e.toString());
//             });*/
//         log('AppLifecycleState paused');
//         break;
//       default:
//         log('AppLifecycleState default');
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final userStream = Provider.of<UserStream>(context);
//     return WillPopScope(
//       onWillPop: () async {
//         log('POP');
//         ChatController.to.endChatApi(
//             data: {"convoid": widget.convoId, "duration": totalSecondSpent.value, "endtime": DateTime.now().toString()},
//             success: () {
//               // Get.offAll(() => HomeController());
//             },
//             error: (e) {
//               showSnackBar(title: ApiConfig.error, message: e.toString());
//             });
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           backgroundColor: AppColors.darkTeal2,
//           title: DesignText(
//             widget.name,
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: 600,
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
//               child: ElevatedButton(
//                 onPressed: () {
//                   showProgress();
//                   ChatController.to.endChatApi(
//                       data: {"convoid": widget.convoId, "duration": totalSecondSpent.value, "endtime": DateTime.now().toString()},
//                       success: () {
//                         hideProgress();
//                         timer.cancel();
//                         Get.offAll(() => const HomeController());
//                       },
//                       error: (e) {
//                         hideProgress();
//                         showSnackBar(title: ApiConfig.error, message: e.toString());
//                       });
//
//
//                 },
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Colors.transparent),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: AppColors.white)))),
//                 child: const DesignText(
//                   'Leave',
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: 400,
//                 ),
//               ),
//             )
//           ],
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(20),
//             ),
//           ),
//           centerTitle: true,
//         ),
//         // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         // floatingActionButton: Column(
//         //   mainAxisSize: MainAxisSize.min,
//         //   children: [
//         //     Padding(
//         //       padding: const EdgeInsets.symmetric(horizontal: 12),
//         //       child: TextFormField(
//         //         controller: text,
//         //         validator: (val) {
//         //           if (val == null || val.isEmpty) {
//         //             return "Field Required";
//         //           }
//         //           return null;
//         //         },
//         //         onTapOutside: (event) {
//         //           final currentFocus = FocusScope.of(context);
//         //           if (currentFocus.focusedChild != null) {
//         //             currentFocus.focusedChild!.unfocus();
//         //           }
//         //         },
//         //         onChanged: (value) {
//         //           if (text.text.trim().length == 1 || text.text.trim().isEmpty) {
//         //             setState(() {});
//         //           }
//         //           if (openDocumentButtm) {
//         //             openDocumentButtm = false;
//         //             setState(() {});
//         //           }
//         //         },
//         //         decoration: InputDecoration(
//         //           hintText: 'Type Message',
//         //           filled: true,
//         //           fillColor: Colors.white,
//         //           suffixIcon: AnimatedContainer(
//         //             duration: const Duration(milliseconds: 300),
//         //             width: text.text.trim().isEmpty ? 30 : 65,
//         //             child: SingleChildScrollView(
//         //               scrollDirection: Axis.horizontal,
//         //               physics: const NeverScrollableScrollPhysics(),
//         //               child: Row(
//         //                 mainAxisAlignment: MainAxisAlignment.center,
//         //                 children: [
//         //                   Material(
//         //                     borderRadius: BorderRadius.circular(60),
//         //                     clipBehavior: Clip.antiAlias,
//         //                     child: IconButton(
//         //                       constraints: const BoxConstraints(),
//         //                       padding: EdgeInsets.zero,
//         //                       onPressed: () {
//         //                         setState(() {
//         //                           openDocumentButtm = !openDocumentButtm;
//         //                         });
//         //                       },
//         //                       icon: const Icon(
//         //                         FontAwesomeIcons.link,
//         //                         color: Colors.black,
//         //                         size: 16,
//         //                       ),
//         //                     ),
//         //                   ),
//         //                   if (text.text.trim().isNotEmpty) const SizedBox(width: 8),
//         //                   if (text.text.trim().isNotEmpty)
//         //                     Material(
//         //                       borderRadius: BorderRadius.circular(60),
//         //                       clipBehavior: Clip.antiAlias,
//         //                       child: IconButton(
//         //                         constraints: const BoxConstraints(),
//         //                         padding: EdgeInsets.zero,
//         //                         onPressed: () {
//         //                           log('TAP');
//         //                           // addMassage();
//         //                         },
//         //                         icon: const Icon(
//         //                           Icons.send,
//         //                           color: Colors.black,
//         //                         ),
//         //                       ),
//         //                     ),
//         //                 ],
//         //               ),
//         //             ),
//         //           ),
//         //           floatingLabelBehavior: FloatingLabelBehavior.auto,
//         //           contentPadding: const EdgeInsets.all(16),
//         //           focusedBorder: OutlineInputBorder(
//         //             borderSide: const BorderSide(color: AppColors.darkGrey, width: 1.0),
//         //             borderRadius: BorderRadius.circular(6),
//         //           ),
//         //           enabledBorder: OutlineInputBorder(
//         //             borderSide: const BorderSide(color: AppColors.lightGrey3, width: 1.0),
//         //             borderRadius: BorderRadius.circular(6),
//         //           ),
//         //           border: OutlineInputBorder(
//         //             borderSide: const BorderSide(color: AppColors.lightGrey3, width: 1.0),
//         //             borderRadius: BorderRadius.circular(6),
//         //           ),
//         //           errorBorder: OutlineInputBorder(
//         //             borderSide: const BorderSide(color: AppColors.tapRed, width: 1.0),
//         //             borderRadius: BorderRadius.circular(6),
//         //           ),
//         //         ),
//         //         textCapitalization: TextCapitalization.sentences,
//         //         keyboardType: TextInputType.multiline,
//         //         maxLines: 4,
//         //         minLines: 1,
//         //       ),
//         //     ),
//         //     if (!openDocumentButtm) const SizedBox(height: 12),
//         //     AnimatedContainer(
//         //       duration: const Duration(milliseconds: 300),
//         //       height: openDocumentButtm ? 100 : 0,
//         //       color: Colors.white,
//         //       child: SingleChildScrollView(
//         //         physics: const NeverScrollableScrollPhysics(),
//         //         child: Column(
//         //           children: [
//         //             const SizedBox(height: 6),
//         //             const Padding(
//         //               padding: EdgeInsets.symmetric(horizontal: 12),
//         //               child: Divider(
//         //                 color: AppColors.lightGrey,
//         //                 height: 2,
//         //                 thickness: 2,
//         //               ),
//         //             ),
//         //             const SizedBox(height: 25),
//         //             Row(
//         //               mainAxisAlignment: MainAxisAlignment.spaceAround,
//         //               children: [
//         //                 CustomIconButton(
//         //                   onPressed: () {},
//         //                   icon: const Icon(
//         //                     FontAwesomeIcons.link,
//         //                     size: 16,
//         //                   ),
//         //                 ),
//         //                 CustomIconButton(
//         //                   onPressed: () {},
//         //                   icon: const Icon(
//         //                     FontAwesomeIcons.image,
//         //                     size: 16,
//         //                   ),
//         //                 ),
//         //                 CustomIconButton(
//         //                   onPressed: () {},
//         //                   icon: const Icon(
//         //                     FontAwesomeIcons.camera,
//         //                     size: 16,
//         //                   ),
//         //                 ),
//         //               ],
//         //             )
//         //           ],
//         //         ),
//         //       ),
//         //     )
//         //   ],
//         // ),
//         body: true
//             ? WebViewScreen(
//                 url: widget.url,
//               )
//             : SingleChildScrollView(
//                 reverse: true,
//                 controller: controller,
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 60),
//                   child: ListView.builder(
//                     itemCount: chatConversations.length,
//                     shrinkWrap: true,
//                     reverse: true,
//                     padding: const EdgeInsets.only(top: 10, bottom: 10),
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       final chatMessage = chatConversations[index];
//                       return ChatCard(
//                         chatConversations: chatMessage,
//                       );
//                     },
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
//
// class CustomIconButton extends StatelessWidget {
//   const CustomIconButton({
//     super.key,
//     required this.onPressed,
//     required this.icon,
//   });
//
//   final void Function()? onPressed;
//   final Widget icon;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.antiAlias,
//       height: 45,
//       width: 45,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(60),
//         border: Border.all(
//           width: 1,
//           color: AppColors.lightGrey,
//         ),
//       ),
//       alignment: Alignment.center,
//       child: Material(
//         borderRadius: BorderRadius.circular(60),
//         clipBehavior: Clip.antiAlias,
//         child: IconButton(onPressed: onPressed, icon: icon),
//       ),
//     );
//   }
// }
//
// class ChatCard extends StatelessWidget {
//   const ChatCard({
//     super.key,
//     required this.chatConversations,
//   });
//
//   final Map chatConversations;
//
//   @override
//   Widget build(BuildContext context) {
//     //final userStream = Provider.of<UserStream>(context);
//     // final currentUid = FirebaseAuth.instance.currentUser?.uid;
//     return Container(
//       padding: EdgeInsets.only(
//         left: chatConversations['isAdminOnly'] ? 60 : 8,
//         right: chatConversations['isAdminOnly'] ? 14 : 60,
//         top: 10,
//         bottom: 10,
//       ),
//       child: Align(
//         alignment: chatConversations['isAdminOnly'] ? Alignment.topRight : Alignment.topLeft,
//         child: IntrinsicWidth(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               // if (chatMessage.uid != currentUid)
//               //   Container(
//               //     clipBehavior: Clip.antiAlias,
//               //     decoration:
//               //     BoxDecoration(borderRadius: BorderRadius.circular(60)),
//               //     child: Image.network(
//               //       chatMessage.profilePhoto!,
//               //       height: 30,
//               //       width: 30,
//               //       fit: BoxFit.cover,
//               //     ),
//               //   ),
//               // if (chatMessage.uid != currentUid) const SizedBox(width: 4),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: chatConversations['isAdminOnly'] ? const Radius.circular(12) : const Radius.circular(2),
//                     bottomRight: chatConversations['isAdminOnly'] ? const Radius.circular(2) : const Radius.circular(12),
//                     topLeft: const Radius.circular(12),
//                     topRight: const Radius.circular(12),
//                   ),
//                   color: chatConversations['isAdminOnly'] ? AppColors.teal : AppColors.aqua,
//                 ),
//                 padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
//                 width: MediaQuery.of(context).size.width * 0.7,
//                 child: IntrinsicWidth(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Flexible(
//                       //   child: DesignText(
//                       //     chatConversations['isAdminOnly'].toString(),
//                       //     fontSize: 14,
//                       //   ),
//                       // ),
//                       // const SizedBox(height: 6),
//                       // if (chatMessage.type ==
//                       //     EnumWhatsAppMessageType.image.name)
//                       //   GestureDetector(
//                       //     onTap: () {
//                       //       // Navigator.push(
//                       //       //   context,
//                       //       //   CupertinoPageRoute(
//                       //       //     builder: (context) =>
//                       //       //         PhotoView(imageUrl: chatMessage.link!),
//                       //       //   ),
//                       //       // );
//                       //     },
//                       //     child: Container(
//                       //       clipBehavior: Clip.antiAlias,
//                       //       decoration: BoxDecoration(
//                       //           borderRadius: BorderRadius.circular(6)),
//                       //       child: Image.network(
//                       //         chatMessage.link!,
//                       //         width: MediaQuery.of(context).size.width / 2.3,
//                       //       ),
//                       //     ),
//                       //   ),
//                       const SizedBox(height: 6),
//                       // if (chatMessage.type ==
//                       //     EnumWhatsAppMessageType.message.name)
//                       Flexible(
//                         child: DesignText(
//                           chatConversations['messages'],
//                           fontSize: 12,
//                           fontWeight: 400,
//                         ),
//                       ),
//
//                       const SizedBox(height: 6),
//                       Container(
//                         alignment: Alignment.bottomRight,
//                         child: const DesignText(
//                           '7:00 PM',
//                           //timeago.format(chatMessage.date!.toDate()),
//                           fontSize: 10, fontWeight: 400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ChatOption extends StatelessWidget {
//   const ChatOption({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.account_balance),
//           highlightColor: Colors.red,
//           hoverColor: Colors.red,
//           focusColor: Colors.red,
//         ),
//         const DesignText(
//           "Redeem",
//         ),
//       ],
//     );
//   }
// }
