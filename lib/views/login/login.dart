import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rashi_network/services/web_view_screen/WebViewScreen.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/ui/widgets/progress_circle.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/utils/design_utlis.dart';
import 'package:rashi_network/views/login/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String verificationIdCode = "";
  final phoneNo = TextEditingController();
  bool isloading = false;
  final formKey = GlobalKey<FormState>();
//   late IOWebSocketChannel channel;
//
//   @override
//   void initState() {
//     // TODO: implement initState
// //     if (true) {
// //       try {
// //         channel = IOWebSocketChannel.connect(
// //             'ws://35.154.43.70:8090/chatdemo/php-socket.php');
// // /*
// //         channel.stream.listen((message) {
// //           // channel?.sink.add('received!');
// //           log(message.toString(), name: 'EVENT listen');
// //         });*/
// //
// //         channel.stream.asBroadcastStream().listen((event) {
// //           log(event.toString(), name: 'EVENT');
// //         });
// //       } on WebSocketChannelException catch (e) {
// //         log(e.toString(), name: 'CATCH');
// //       }
// //     } else {
// //       socketController().initData();
// //     }
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    //HomeController
    return Form(
      key: formKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const DesignText(
                'Welcome !',
                fontSize: 20,
                fontWeight: 600,
              ),
              const SizedBox(height: 10),
              const DesignText(
                'Enlightening Your Path with Astrology',
                fontSize: 14,
                fontWeight: 400,
                color: AppColors.lightGrey1,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneNo,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Field Can't be empty";
                  } else if (val.length < 10) {
                    return "Mobile number must be 10 in digit";
                  }
                  return null;
                },
                onTapOutside: (event) {
                  final currentFocus = FocusScope.of(context);
                  if (currentFocus.focusedChild != null) {
                    currentFocus.focusedChild!.unfocus();
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Enter Your Phone no',
                  // hintText: 'Enter Your Email or Phone no',
                  filled: true,
                  isDense: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                    child: Text('+91'),
                  ),
                  // prefixText: "+91 ",
                  // prefixStyle: TextStyle(
                  //   color: Colors.black,
                  // ),
                  // fillColor: Colors.transparent,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: EdgeInsets.all(16),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.darkGrey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.lightGrey3, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.lightGrey3, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.tapRed, width: 2.0),
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.number,
                maxLength: 10,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: DesignButtons(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OTPScreen(
                            verificationId: "",
                            resendToken: 0,
                            phoneNumber: phoneNo.text,
                          ),
                        ),
                      );*/
                      setState(() => isloading = true);
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+91${phoneNo.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {
                          setState(() => isloading = false);
                          DesignUtlis.flutterToast(e.message.toString());
                        },
                        timeout: const Duration(seconds: 60),
                        codeSent: (String verificationId, int? resendToken) {
                          setState(() => isloading = false);
                          log('MSG SENT');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPScreen(
                                verificationId: verificationId,
                                resendToken: resendToken!,
                                phoneNumber: phoneNo.text,
                              ),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          log('MSG TIMEOUT');
                        },
                      );
                    }
                  },
                  textLabel: 'Continue',
                  isTappedNotifier: ValueNotifier(false),
                  colorText: Colors.white,
                  fontSize: 14,
                  fontWeight: 600,
                  color: AppColors.darkTeal,
                  child: isloading
                      ? const DesignProgress(size: 18, color: Colors.white)
                      : const DesignText(
                          "Continue",
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: 600,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              // Container(
              //   alignment: Alignment.center,
              //   child: const DesignText(
              //     'OR',
              //     fontSize: 16,
              //     fontWeight: 500,
              //     color: DesignColor.lightGrey1,
              //   ),
              // ),
              // const SizedBox(height: 20),
              // SizedBox(
              //   height: 48,
              //   width: double.infinity,
              //   child: DesignButtons(
              //     onPressed: () async {
              //       await ApiAccess()
              //           .orderGenerate(paymentRequestId: 'paymentRequestId')
              //           .then((value) {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => InstamojoPaymentScreen(
              //                   paymentRequestUrl: value['longurl'],
              //                   paymentRequestId: value['id']),
              //             )).then((value) => print(value));
              //       });
              //     },
              //     textLabel: 'Continue with Google',
              //     isTappedNotifier: ValueNotifier(false),
              //     colorText: Colors.white,
              //     fontSize: 14,
              //     fontWeight: 600,
              //     color: Colors.transparent,
              //     borderSide: true,
              //     colorBorderSide: DesignColor.darkTeal,
              //     child: Row(
              //       children: const [
              //         SizedBox(width: 6),
              //         Icon(
              //           FontAwesomeIcons.google,
              //           color: DesignColor.darkTeal,
              //           size: 18,
              //         ),
              //         SizedBox(width: 6),
              //         DesignText(
              //           'Continue with Google',
              //           fontSize: 12,
              //           fontWeight: 500,
              //           color: DesignColor.darkTeal,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
              // SizedBox(
              //   height: 48,
              //   width: double.infinity,
              //   child: DesignButtons(
              //     onPressed: () async {
              //       ApiAccess().getBanner().then((value) => print(value));
              //     },
              //     textLabel: 'Continue with Google',
              //     isTappedNotifier: ValueNotifier(false),
              //     colorText: Colors.white,
              //     fontSize: 14,
              //     fontWeight: 600,
              //     color: Colors.transparent,
              //     borderSide: true,
              //     colorBorderSide: DesignColor.darkTeal,
              //     child: Row(
              //       children: const [
              //         SizedBox(width: 6),
              //         Icon(
              //           FontAwesomeIcons.facebook,
              //           color: DesignColor.darkTeal,
              //           size: 18,
              //         ),
              //         SizedBox(width: 6),
              //         DesignText(
              //           'Continue with Facebook',
              //           fontSize: 12,
              //           fontWeight: 500,
              //           color: DesignColor.darkTeal,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
