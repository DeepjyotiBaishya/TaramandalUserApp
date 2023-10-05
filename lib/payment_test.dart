import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rashi_network/utils/design_utlis.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_flutter_android/webview_flutter_android.dart';

import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'services/api/api_service.dart';
import 'utils/controller/get_profile_controller.dart';
import 'views/wallet/controller/add_money_controller.dart';

class InstamojoPaymentScreen extends StatefulWidget {
  final String paymentRequestUrl;
  final String paymentRequestId;

  const InstamojoPaymentScreen(
      {super.key,
      required this.paymentRequestUrl,
      required this.paymentRequestId});

  @override
  State<InstamojoPaymentScreen> createState() => _InstamojoPaymentScreenState();
}

class _InstamojoPaymentScreenState extends State<InstamojoPaymentScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          // onProgress: (int progress) {
          //   debugPrint('WebView is loading (progress : $progress%)');
          // },
          // onPageStarted: (String url) {
          //   debugPrint('Page started loading: $url');
          // },
          // onPageFinished: (String url) {
          //   debugPrint('Page finished loading: $url');
          // },
          onNavigationRequest: (NavigationRequest request) async {
            // Check if the URL is your redirect_url
            debugPrint('Url:->${request.url}');
            if (request.url
                .startsWith('https://www.instamojo.com/order/status/')) {
              return NavigationDecision.navigate;
            }
            if (request.url.startsWith('http://www.example.com/redirect/')) {
              //https://thetaramandal.com/user/wallet/payments/success/?orderId=191
              // await ApiAccess()
              //     .verifyInstamojoPayment(
              //         paymentRequestId: widget.paymentRequestId)
              //     .then((isDone) => Navigator.pop(context, isDone));
              final Uri url = Uri.parse(request.url);
              // Get the payment status from the URL
              final String paymentStatus =
                  url.queryParameters['payment_status'] ?? '';
              // Get the payment request ID from the URL
              // final String paymentRequestId =
              //     url.queryParameters['payment_request_id'] ?? '';
              // Handle the payment status
              if (paymentStatus == 'Credit') {
                Navigator.pop(context, request.url);
              }
              //else {
              //   Navigator.pop(context, request.url);
              // }
            }
            if (request.url.startsWith('intent')) {
              print('object 44${request.url}');
              DesignUtlis.launchURL(request.url.replaceAll('intent', 'upi'));
              // return NavigationDecision.prevent;
              // if (platform.isAndroid) {
              // AndroidIntent intent = AndroidIntent(
              //     action: 'action_view',
              //     data: request.url,
              //     package: 'package=net.one97.paytm',
              //     // arguments: {'authAccount': currentUserEmail},
              //     );
              // await intent.launch();
              // }
            }
            // Prevent the WebView from loading the redirect_url
            return NavigationDecision.prevent;
          },
          // onUrlChange: (UrlChange change) {
          //   debugPrint('url change to ${change.url}');
          // },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.paymentRequestUrl));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          log('BACK BY');
          await AddMoneyController.to.addMoneyStatusApi(
              params: {
                "paymentrequestid": widget.paymentRequestId,
              },
              success: () {
                Get.back();
                GetProfileController.to.getProfileApi(params: {});
                // showSnackBar(title: ApiConfig.error, message: e.toString());
              },
              error: (e) {
                Get.back();
                showSnackBar(title: ApiConfig.error, message: e.toString());
              });
          return false;
        },
        child: Scaffold(
          body: WebViewWidget(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
