import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rashi_network/ui/custom/design_single_tap.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'controller/history_controller.dart';

class CallHistory extends ConsumerStatefulWidget {
  const CallHistory({super.key});

  @override
  ConsumerState<CallHistory> createState() => _CallHistoryState();
}

class _CallHistoryState extends ConsumerState<CallHistory> {
  @override
  void initState() {
    // TODO: implement initState
    log('INIT CALL HISTORY');
    HistoryController.to.userCallHistoryApi(params: {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   backgroundColor: DesignColor.darkTeal2,
      //   title: const DesignText(
      //     'Call',
      //     color: Colors.white,
      //     fontSize: 20,
      //     fontWeight: 700,
      //   ),
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(20),
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      //     const SizedBox(width: 14),
      //   ],
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () => appStateauto.currentIndex = 0,
      //   ),
      // ),

      body: Obx(() {
        return HistoryController.to.userCallHistoryRes.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(color: AppColors.darkTeal1),
              )
            : (HistoryController.to.userCallHistoryRes['data'] ?? []).isEmpty
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
                          "Ohhh!! you do not have any Call History.",
                          fontSize: 18,
                          fontWeight: 400,
                          color: AppColors.lightGrey1,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: (HistoryController.to.userCallHistoryRes['data'] ?? []).length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      return DesignSingleTap(
                        isTappedNotifier: ValueNotifier(false),
                        onTap: () async {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => AstrologerProfile(index: index),
                          //   ),
                          // );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: DesignContainer(
                            color: AppColors.white,
                            // height: 140,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2, color: Colors.green),
                                    borderRadius: BorderRadius.circular(60), // assuming height/width is 83
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.network(
                                      'https://thetaramandal.com/public/astrologer/${(HistoryController.to.userCallHistoryRes['data'] ?? [])[index]?['photo'] ?? ''}',
                                      height: 83,
                                      width: 83,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          DesignText(
                                            (HistoryController.to.userCallHistoryRes['data'] ?? [])[index]?['name'] ?? '',
                                            fontSize: 14,
                                            fontWeight: 600,
                                          ),
                                          // SizedBox(
                                          //   height: 20,
                                          //   child: ListView.builder(
                                          //     itemCount: 3,
                                          //     shrinkWrap: true,
                                          //     scrollDirection: Axis.horizontal,
                                          //     itemBuilder: (context, index) =>
                                          //         const Padding(
                                          //       padding: EdgeInsets.only(right: 6),
                                          //       child: DesignText('⭐'),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      DesignText(
                                        'Date: ${(HistoryController.to.userCallHistoryRes['data'] ?? [])[index]?['call_starttime'] ?? ''}',
                                        fontSize: 12,
                                        fontWeight: 500,
                                        color: AppColors.lightGrey1,
                                      ),
                                      DesignText(
                                        'Call rate: Rs.${(HistoryController.to.userCallHistoryRes['data'] ?? [])[index]?['call_price'] ?? 0}/min',
                                        fontSize: 12,
                                        fontWeight: 500,
                                        color: AppColors.lightGrey1,
                                      ),
                                      DesignText(
                                        'Duration: ${(HistoryController.to.userCallHistoryRes['data'] ?? [])[index]?['callduration'] ?? ''} seconds',
                                        fontSize: 12,
                                        fontWeight: 500,
                                        color: AppColors.lightGrey1,
                                      ),
                                      DesignText(
                                        'Deduction: ${(HistoryController.to.userCallHistoryRes['data'] ?? [])[index]?['callcharges'] ?? '0'}',
                                        fontSize: 12,
                                        fontWeight: 500,
                                        color: AppColors.red,
                                      ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   crossAxisAlignment: CrossAxisAlignment.center,
                                      //   children: [
                                      //     const DesignText(
                                      //       'Rs.10/Min',
                                      //       fontSize: 10,
                                      //       fontWeight: 500,
                                      //       color: AppColors.red,
                                      //     ),
                                      //     SizedBox(
                                      //       height: 31,
                                      //       width: 81,
                                      //       child: DesignButtons(
                                      //         onPressed: () async {
                                      //           // Navigator.push(
                                      //           //     context,
                                      //           //     MaterialPageRoute(
                                      //           //       builder: (context) =>
                                      //           //           const ChatScreen(),
                                      //           //     ));
                                      //         },
                                      //         textLabel: 'Call',
                                      //         isTappedNotifier: ValueNotifier(false),
                                      //         sideWidth: 1,
                                      //         colorText: AppColors.darkTeal1,
                                      //         borderSide: true,
                                      //         colorBorderSide: AppColors.darkTeal1,
                                      //         fontSize: 12,
                                      //         fontWeight: 700,
                                      //         color: Colors.transparent,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      DesignText(
                                        '${(HistoryController.to.userCallHistoryRes['data'] ?? [])[index]?['status'] ?? ''}',
                                        fontSize: 12,
                                        fontWeight: 500,
                                        color: ((HistoryController.to.userCallHistoryRes['data'] ?? [])[index]?['status'] ?? '') == 'Completed'
                                            ? AppColors.green
                                            : /*((HistoryController.to.userCallHistoryRes['data'] ?? [])[index]?['status'] ?? '') == 'busy'
                                                ? AppColors.gold
                                                : AppColors.red*/
                                            Colors.redAccent,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
      }),
    );
  }
}
