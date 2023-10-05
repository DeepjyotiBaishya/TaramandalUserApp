import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // GetAds.to.loadBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   backgroundColor: AppColors.darkTeal2,
      //   title: const DesignText(
      //     'Pooja & Jaap',
      //     color: Colors.white,
      //     fontSize: 20,
      //     fontWeight: 600,
      //   ),
      //   actions: [
      //     // IconButton(
      //     //   onPressed: () {
      //     //     Get.to(() => const WalletHistoryScreen());
      //     //   },
      //     //   icon: Icon(
      //     //     Icons.history,
      //     //     size: 25,
      //     //     color: AppColors.white,
      //     //   ),
      //     // ),
      //     // SizedBox(
      //     //   width: 15,
      //     // ),
      //   ],
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(20),
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      backgroundColor: AppColors.darkTeal2,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Coming Soon',
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
      body: Container(
        child: Image.asset(
          'assets/img/comingsoon.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
