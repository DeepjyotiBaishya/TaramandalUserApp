import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rashi_network/ui/custom/design_single_tap.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/viewmodel/provider/appstate.dart';
import 'package:rashi_network/views/connect/chat/astrologer_chat_profile.dart';
import 'package:rashi_network/views/connect/chat/chat_screen.dart';

class ConsultationHistory extends ConsumerStatefulWidget {
  const ConsultationHistory({super.key});

  @override
  ConsumerState<ConsultationHistory> createState() => _ConsultationHistoryState();
}

class _ConsultationHistoryState extends ConsumerState<ConsultationHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: true
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
                    "Ohhh!! you do not have any Consultation History.",
                    fontSize: 18,
                    fontWeight: 400,
                    color: AppColors.lightGrey1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: 10,
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
                                'https://cdn.pixabay.com/photo/2023/01/28/16/55/woman-7751363_960_720.jpg',
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
                                    const DesignText(
                                      'Astro Kunal Khemu',
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
                                const DesignText(
                                  '26th April 2023, 09:28',
                                  fontSize: 12,
                                  fontWeight: 500,
                                  color: AppColors.lightGrey1,
                                ),

                                const DesignText(
                                  'Duration: 10 mins',
                                  fontSize: 12,
                                  fontWeight: 500,
                                  color: AppColors.lightGrey1,
                                ),
                                const DesignText(
                                  'Rate: 15/min',
                                  fontSize: 12,
                                  fontWeight: 600,
                                  color: AppColors.lightGrey1,
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
                                const DesignText(
                                  'Completed',
                                  fontSize: 10,
                                  fontWeight: 500,
                                  color: AppColors.green,
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
            ),
    );
  }
}
