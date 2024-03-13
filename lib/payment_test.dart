import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CcavenuePaymentScreen extends StatefulWidget {
  final String paymentRequestUrl;

  const CcavenuePaymentScreen({Key? key, required this.paymentRequestUrl,}) : super(key: key);

  @override
  State<CcavenuePaymentScreen> createState() => _CcavenuePaymentScreenState();
}

class _CcavenuePaymentScreenState extends State<CcavenuePaymentScreen> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Payment',
          color: Colors.white,
          fontSize: 20,
          fontWeight: 600,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
      ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: InAppWebView(
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        mediaPlaybackRequiresUserGesture: false,
                        javaScriptEnabled: true,
                        javaScriptCanOpenWindowsAutomatically: true,
                      ),
                      android: AndroidInAppWebViewOptions(
                        useWideViewPort: false,
                        useHybridComposition: true,
                        loadWithOverviewMode: true,
                        domStorageEnabled: true,
                      ),
                      ios: IOSInAppWebViewOptions(
                          allowsInlineMediaPlayback: true,
                          enableViewportScale: true,
                          ignoresViewportScaleLimits: true)),
                  initialData: InAppWebViewInitialData(data: _loadHTML()),
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    final uri = navigationAction.request.url!;
                    print("uri = " + uri.toString());
                    if (uri.toString().contains("phonepe://pay?") ||
                        uri.toString().contains("paytmmp://pay?") ||
                        uri.toString().contains("tez://upi/pay?") ||
                        uri.toString().contains("upi://pay?")) {
                      if (!await launchUrl(uri)) {
                        // throw Exception('Could not launch $uri');
                      }
                      return NavigationActionPolicy.CANCEL;
                    }
                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadError: (controller, url, code, message) {},
                  onLoadStop:
                      (InAppWebViewController controller, Uri? pageUri) async {
                    setState(() {
                      loading = false;
                    });
                    final page = pageUri.toString();

                    if (page == widget.paymentRequestUrl ||
                        page == widget.paymentRequestUrl) {
                      var html = await controller.evaluateJavascript(
                          source:
                          "window.document.getElementsByTagName('html')[0].outerHTML;");

                      String html1 = html.toString();
                      var htmlArr1 = html1.split('<tbody>');
                      if (htmlArr1.length > 1) {
                        var htmlStr1 = htmlArr1[1];
                        var htmlArr2 = htmlStr1.split('</tbody>');
                        if (htmlArr2.length > 0) {
                          var jsonString = htmlArr2[0];
                          jsonString = jsonString.replaceAll('<td>', '\"');
                          jsonString = jsonString.replaceAll('<tr>', '');
                          jsonString = jsonString.replaceAll('</tr>', ',');

                          jsonString = jsonString.replaceAll('</td>', '\" : ');
                          jsonString = jsonString.replaceAll(' : ,', ',');

                          if (jsonString.length > 0) {
                            jsonString =
                                jsonString.substring(0, jsonString.length - 1);
                          }

                          jsonString = '{$jsonString}';

                          Map<String, dynamic> map = jsonDecode(jsonString);
                          String status = map['order_status'];

                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (_) {
                            return CcavenuePaymentScreen(paymentRequestUrl: widget.paymentRequestUrl,);
                          }));
                        }
                      }
                    }
                  },
                ),
              ),
              (loading)
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : const Center(),
            ],
          ),
        ),
      );
  }
  String _loadHTML() {
    final url = widget.paymentRequestUrl;

    String html =
        "<html> <head><meta name='viewport' content='width=device-width, initial-scale=1.0'></head> <body onload='document.f.submit();'> <form id='f' name='f' method='post' action='$url'>";
    return html + "</form> </body> </html>";
  }
}
