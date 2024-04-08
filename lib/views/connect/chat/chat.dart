import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rashi_network/common/common_function.dart';
import 'package:rashi_network/services/api/api_access.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/ui/custom/design_single_tap.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/commonWidget.dart';
import 'package:rashi_network/utils/controller/get_profile_controller.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/views/bottom_controller.dart';
import 'package:rashi_network/views/connect/book_slot/book_slot_screen.dart';
import 'package:rashi_network/views/connect/chat/astrologer_chat_profile.dart';
import 'package:rashi_network/views/connect/chat/chat_screen.dart';
import 'package:rashi_network/views/connect/chat/rating_screen.dart';

import '../history/chat_screen.dart';
import 'search_chat_screen.dart';

class Chat extends ConsumerStatefulWidget {
  final bool isBack;

  const Chat({
    super.key,
    this.isBack = false,
  });

  @override
  ConsumerState<Chat> createState() => _ChatState();
}

class _ChatState extends ConsumerState<Chat> {
  bool isFilterApplied = false;
  List chatList = ['1', '1', '1', '1'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColors.darkTeal2,
          title: const DesignText(
            'Current Chats',
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
              if (widget.isBack) {
                Get.back();
              } else {
                BottomController.to.selectedIndOfBottom.value = 0;
              }
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => SearchChatScreen());
                },
                icon: const Icon(Icons.search)),
            const SizedBox(width: 8),
          ],
        ),
        body: Column(
            children: [
              // Add your outline button here
              OutlinedButton(
                onPressed: () {
                  // Toggle the filter state
                  setState(() {
                    isFilterApplied = !isFilterApplied;
                  });
                },
                child: Text(isFilterApplied ? 'Clear' : 'Live Astro', style: TextStyle(color: isFilterApplied ? Colors.red : AppColors.darkTeal2),) ,
                style: OutlinedButton.styleFrom(
                  // Set border color based on filter state
                  side: BorderSide(
                    color: isFilterApplied ? Colors.red : AppColors.darkTeal2,
                  ),
                ),
              ),
          Expanded(child: Obx(() {
            return ApiAccess.liveAstrologers.isEmpty
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
                          "Ohhh!! There is no Ongoing Chats",
                          fontSize: 18,
                          fontWeight: 400,
                          color: AppColors.lightGrey1,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: ApiAccess.liveAstrologers.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      final astrologer = ApiAccess.liveAstrologers[index];
                      // final livedata = data[index];
                      if (isFilterApplied && !(astrologer['is_online'] == 1 && astrologer['available_chat'] == 'yes')) {
                        return SizedBox.shrink();
                      }
                      return DesignSingleTap(
                        isTappedNotifier: ValueNotifier(false),
                        onTap: () async {
                          var astrologerData = ApiAccess.liveAstrologers[index];
                          var astrologer_id = astrologerData is Map ? astrologerData['astrologer_id'] ?? 0 : 0;

                          Get.to(() => RatingScreen(astrologer_id));

                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: DesignContainer(
                            color: AppColors.white,
                            // height: 140,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: Colors.green,
                                              ),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  'https://thetaramandal.com/public/astrologer/${ApiAccess.liveAstrologers[index]['photo']}',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              // assuming height/width is 83
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                            right: 5,
                                            child: CircleAvatar(
                                                radius: 6,
                                                backgroundColor: () {
                                                  final astrologer = ApiAccess.liveAstrologers[index];
                                                  final isOnline = astrologer['is_online'] == 1;
                                                  final isAvailableChat = astrologer['available_chat'] == 'yes';
                                                  final isBusy = astrologer['is_busy'] == 'yes';

                                                  if (isAvailableChat && isOnline && !isBusy) {
                                                    return AppColors.green;
                                                  } else if (isAvailableChat && !isOnline && !isBusy) {
                                                    return AppColors.blackTextSecond;
                                                  } else if (isAvailableChat && isOnline && isBusy) {
                                                    return AppColors.red;
                                                  } else if (isAvailableChat && !isOnline && isBusy) {
                                                    return AppColors.red;
                                                  } else if (!isAvailableChat && !isOnline && isBusy) {
                                                    return AppColors.blackTextSecond;
                                                  } else if (!isAvailableChat && !isOnline && !isBusy) {
                                                    return AppColors.blackTextSecond;
                                                  } else {
                                                    return AppColors.blackTextSecond;
                                                  }
                                                }()),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DesignText(
                                            ApiAccess.liveAstrologers[index]
                                                    ['name'] ??
                                                '-',
                                            fontSize: 16,
                                            fontWeight: 600,
                                          ),
                                          SizedBox(height: 2),
                                          DesignText(
                                            'Vastu, Horoscope',
                                            fontSize: 12,
                                            fontWeight: 500,
                                            color: AppColors.lightGrey1,
                                          ),
                                          DesignText(
                                            astrologerLanguage(
                                                ApiAccess.liveAstrologers[index]
                                                        ?['language'] ??
                                                    ''),
                                            fontSize: 12,
                                            fontWeight: 500,
                                            color: AppColors.lightGrey1,
                                          ),
                                          DesignText(
                                            '${ApiAccess.liveAstrologers[index]?['experience'] ?? 0} Years',
                                            fontSize: 12,
                                            fontWeight: 500,
                                            color: AppColors.lightGrey1,
                                          ),
                                          DesignText(
                                            'Ratings : ⭐⭐⭐',
                                            fontSize: 12,
                                            fontWeight: 500,
                                            color: Colors.orange,
                                          ),
                                          DesignText(
                                            'Rs.${ApiAccess.liveAstrologers[index]?['chat_price'] ?? 0}/Min',
                                            fontSize: 12,
                                            fontWeight: 500,
                                            color: AppColors.red,
                                          ),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 31,
                                      width: 90,
                                      child: DesignButtons(
                                        onPressed: () async {
                                          if (double.parse((GetProfileController
                                                                  .to
                                                                  .profileRes['data']
                                                              ?['userdetail']
                                                          ?['walletamount'] ??
                                                      '0.00')
                                                  .toString()) <
                                              double.parse(
                                                  (ApiAccess.liveAstrologers[
                                                                  index]
                                                              ['chat_price'] ??
                                                          0)
                                                      .toString())) {
                                            insufficientBalancePopup(
                                                context,
                                                "${double.parse((ApiAccess.liveAstrologers[index]['chat_price'] ?? 0).toString())}",
                                                "chat");
                                          } else {
                                            Get.dialog(Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      DesignText(
                                                        'Payment',
                                                        fontSize: 18,
                                                        fontWeight: 600,
                                                        color: AppColors.gold,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 12),
                                                        child: DesignText(
                                                          'You need to pay Rs.${ApiAccess.liveAstrologers[index]['chat_price'] ?? 0}/Min to access this',
                                                          fontSize: 16,
                                                          fontWeight: 400,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 120,
                                                        child: DesignButtons(
                                                          onPressed: () async {
                                                            // final astroId = GetProfileController.to.profileRes;
                                                            // final int newId = astroId.value["data"]?['user']?["id"] ?? 0;
                                                            // var astrologer_id = ApiAccess.liveAstrologers[index]['astrologer_id']?? 0;

                                                            var astrologerData = ApiAccess.liveAstrologers[index];
                                                            var astrologer_id = astrologerData is Map ? astrologerData['astrologer_id'] ?? 0 : 0;
                                                            var name = astrologerData is Map ? astrologerData['name'] ?? '' : '';

                                                            Get.back();
                                                            Get.to(() => AstrologerChatProfile(astrologerProfile: astrologerData, astrologer_id: astrologer_id, name: name,));
                                                            // showSnackBar(title: ApiConfig.success, message: 'Payment SuccessFull...');
                                                            print(
                                                                'Type of astrologer_id: ${astrologer_id.runtimeType}');
                                                          },
                                                          textLabel: 'Pay Now',
                                                          isTappedNotifier:
                                                              ValueNotifier(
                                                                  false),
                                                          sideWidth: 1,
                                                          colorText:
                                                              AppColors.white,
                                                          borderSide: true,
                                                          colorBorderSide:
                                                              AppColors
                                                                  .darkTeal2,
                                                          fontSize: 12,
                                                          fontWeight: 700,
                                                          color: AppColors
                                                              .darkTeal2,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ));
                                          }
                                          /*Get.defaultDialog(
                                          backgroundColor: Colors.white,
                                          content: ,
                                          title: '',
                                          actions: [const Text('')],
                                          barrierDismissible: true,
                                        );*/
                                        },
                                        textLabel: 'Chat',
                                        isTappedNotifier: ValueNotifier(false),
                                        sideWidth: 1,
                                        colorText: AppColors.white,
                                        borderSide: true,
                                        colorBorderSide: AppColors.darkTeal2,
                                        fontSize: 12,
                                        fontWeight: 700,
                                        color: AppColors.darkTeal2,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SizedBox(
                                      height: 31,
                                      width: 90,
                                      child: DesignButtons(
                                        onPressed: () async {
                                          Get.to(() => BookSlotScreen(
                                                astrologerProfile: ApiAccess
                                                    .liveAstrologers[index],
                                                type: 'Chat',
                                              ));
                                        },
                                        textLabel: 'Book Slot',
                                        isTappedNotifier: ValueNotifier(false),
                                        sideWidth: 1,
                                        colorText: AppColors.darkTeal2,
                                        borderSide: true,
                                        colorBorderSide: AppColors.darkTeal2,
                                        fontSize: 12,
                                        fontWeight: 700,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }))
        ]));
  }
}
