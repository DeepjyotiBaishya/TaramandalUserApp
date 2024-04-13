import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';

import '../../../ui/custom/design_single_tap.dart';
import 'controller/chatReq_controller.dart';

class RatingScreen extends ConsumerStatefulWidget {
  final int astrologerid;

  const RatingScreen(this.astrologerid, {Key? key}) : super(key: key);

  @override
  ConsumerState<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends ConsumerState<RatingScreen> {
  @override
  void initState() {
    super.initState();
    ChatController.to.showReviewRatingsApi(data: {
      "astrologerid": widget.astrologerid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColors.darkTeal2,
          title: const DesignText(
            'Reviews & Ratings',
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          actions: const [
            // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            // const SizedBox(width: 14),
          ],
        ),
        body: Obx(() {
          return ChatController.to.showReviewRatingsRes.isEmpty
              ? const Center(
                  child: CupertinoActivityIndicator(color: AppColors.darkTeal1),
                )
              : (ChatController.to.showReviewRatingsRes['data'] ?? []).isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/no_data.png',
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(height: 20),
                          const DesignText(
                            "Ohhh!! you do not have any rating",
                            fontSize: 18,
                            fontWeight: 400,
                            color: AppColors.lightGrey1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          (ChatController.to.showReviewRatingsRes['data'] ?? [])
                              .length,
                      padding: const EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        // final livedata = data[index];
                        return DesignSingleTap(
                          isTappedNotifier: ValueNotifier(false),
                          onTap: () async {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => AstrologerProfile(
                            //         index: index, astrologerModel: livedata),
                            //   ),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: DesignContainer(
                              color: AppColors.white,
                              // height: 140,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Hero(
                                          tag: index,
                                          child: Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.green),
                                                shape: BoxShape.circle,
                                                ),
                                            child: ClipOval(
                                          child: Image.asset(
                                          'assets/img/user_icon.png',
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DesignText(
                                              "${(ChatController.to.showReviewRatingsRes['data']?[index]?['name'] ?? '')}",
                                              fontSize: 16,
                                              fontWeight: 600,
                                            ),
                                            SizedBox(height: 2),
                                            DesignText(
                                              'Date:${(ChatController.to.showReviewRatingsRes['data']?[index]?['created_at'] ?? '')}',
                                              fontSize: 12,
                                              fontWeight: 500,
                                              color: AppColors.lightGrey1,
                                            ),
                                            RatingBar.builder(
                                              initialRating: double.parse(
                                                  '${ChatController.to.showReviewRatingsRes['data']?[index]?['star_rating'] ?? '0'}'),
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemSize: 20,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (_) {},
                                            ),
                                            DesignText(
                                              '${(ChatController.to.showReviewRatingsRes['data']?[index]?['comments'] ?? '')}',
                                              fontSize: 12,
                                              fontWeight: 500,
                                              color: AppColors.lightGrey1,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
        }));
  }
}
