import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:html/parser.dart';

class LatestBlogsDetails extends StatefulWidget {
  const LatestBlogsDetails(
      {super.key, required this.text, required this.image});
  final String text;
  final String image;
  @override
  State<LatestBlogsDetails> createState() => _LatestBlogsDetailsState();
}

class _LatestBlogsDetailsState extends State<LatestBlogsDetails> {
  @override
  void initState() {
    // TODO: implement initState
    GetAds.to.loadBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var document = parse(widget.text);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Blog Details',
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
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70,
        color: Colors.white,
        child: AdWidget(
          ad: GetAds.to.bannerAd,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DesignText(
                  document.body!.text,
                  fontSize: 14,
                  fontWeight: 400,
                )),

            /*Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child:
                    Html() */ /* DesignText(
                  document.body!.text,
                  fontSize: 14,
                  fontWeight: 400,
                )*/ /*
                )*/
          ],
        ),
      ),
    );
  }
}
