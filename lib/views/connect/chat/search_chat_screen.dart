import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rashi_network/common/common_function.dart';
import 'package:rashi_network/services/api/api_access.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/ui/custom/custom_text_form.dart';
import 'package:rashi_network/ui/custom/design_single_tap.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/viewmodel/model/astrologer_model.dart';
import 'package:rashi_network/views/connect/chat/astrologer_chat_profile.dart';
import 'package:rashi_network/views/connect/history/chat_screen.dart';

class SearchChatScreen extends StatefulWidget {
  SearchChatScreen({Key? key}) : super(key: key);

  @override
  State<SearchChatScreen> createState() => _SearchChatScreenState();
}

class _SearchChatScreenState extends State<SearchChatScreen> {
  TextEditingController _searchAstrology = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        log('pop');
        ApiAccess().liveAstrologer(data: {"search": ""});

        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: AppColors.darkTeal2,
            title: const DesignText(
              'Search Astrologer',
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
                ApiAccess().liveAstrologer(data: {"search": ""});
              },
            ),
            // actions: [
            //   IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            //   const SizedBox(width: 8),
            // ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DesignFormField(
                  controller: _searchAstrology,
                  onChanged: (value) {
                    ApiAccess().liveAstrologer(data: {"search": _searchAstrology.text});
                  },
                  hintText: 'Search astrologer',
                  prefix: Icon(Icons.search, color: AppColors.lightGrey1),
                ),
              ),
              Expanded(
                child: Obx(() {
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
                                "Ohhh!! There is no Astrologer",
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
                                                      border: Border.all(width: 2, color: Colors.green),
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          'https://thetaramandal.com/public/astrologer/${ApiAccess.liveAstrologers[index]['photo']}',
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )
                                                      // assuming height/width is 83
                                                      ),
                                                ),
                                                Positioned(
                                                    bottom: 5,
                                                    right: 5,
                                                    child: CircleAvatar(
                                                      radius: 6,
                                                      backgroundColor:(){
                                                        final astrologer = ApiAccess.liveAstrologers[index];
                                                        final isOnline = astrologer['is_online'] == 1;
                                                        final isAvailableChat = astrologer['available_chat'] == 'yes';
                                                        final isBusy = astrologer['is_busy'] == 'yes';

                                                        if ( isAvailableChat && isOnline && !isBusy) {
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
                                                        }  else {
                                                          return AppColors.blackTextSecond;
                                                        }
                                                      }()
                                                    ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                DesignText(
                                                  ApiAccess.liveAstrologers[index]['name'] ?? '-',
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
                                                  astrologerLanguage(ApiAccess.liveAstrologers[index]?['language'] ?? ''),
                                                  fontSize: 12,
                                                  fontWeight: 500,
                                                  color: AppColors.lightGrey1,
                                                ),
                                                DesignText(
                                                  '${ApiAccess.liveAstrologers[index]['experience']} Years',
                                                  fontSize: 12,
                                                  fontWeight: 500,
                                                  color: AppColors.lightGrey1,
                                                ),
                                                DesignText(
                                                  'Rs.${ApiAccess.liveAstrologers[index]['call_price']}/Min',
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
                                                Get.dialog(Dialog(
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                                                      DesignText(
                                                        'Payment',
                                                        fontSize: 18,
                                                        fontWeight: 600,
                                                        color: AppColors.gold,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 12),
                                                        child: DesignText(
                                                          'You need to pay Rs.${ApiAccess.liveAstrologers[index]['chat_price']}/Min to access this',
                                                          fontSize: 16,
                                                          fontWeight: 400,
                                                          textAlign: TextAlign.center,
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
                                                            Get.back();

                                                            Get.to(() => AstrologerChatProfile(astrologerProfile: ApiAccess.liveAstrologers[index], astrologer_id: ApiAccess.liveAstrologers[index]['astrologer_id'] ?? 0, name: ApiAccess.liveAstrologers[index]['name'] ?? '',));
                                                            // showSnackBar(title: ApiConfig.success, message: 'Payment SuccessFull...');
                                                          },
                                                          textLabel: 'Pay Now',
                                                          isTappedNotifier: ValueNotifier(false),
                                                          sideWidth: 1,
                                                          colorText: AppColors.white,
                                                          borderSide: true,
                                                          colorBorderSide: AppColors.darkTeal1,
                                                          fontSize: 12,
                                                          fontWeight: 700,
                                                          color: AppColors.darkTeal1,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ));
                                                /* Get.defaultDialog(
                                                  backgroundColor: Colors.white,
                                                  content: Column(children: [
                                                    DesignText(
                                                      'Payment',
                                                      fontSize: 18,
                                                      fontWeight: 600,
                                                      color: AppColors.gold,
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      child: DesignText(
                                                        'You need to pay Rs.${ApiAccess.liveAstrologers[index]['chat_price']}/Min to access this',
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
                                                          Get.back();

                                                          Get.to(() =>
                                                              AstrologerChatProfile(
                                                                  astrologerProfile:
                                                                      ApiAccess
                                                                              .liveAstrologers[
                                                                          index]));
                                                          showSnackBar(
                                                              title: ApiConfig
                                                                  .success,
                                                              message:
                                                                  'Payment SuccessFull...');
                                                        },
                                                        textLabel: 'Pay Now',
                                                        isTappedNotifier:
                                                            ValueNotifier(false),
                                                        sideWidth: 1,
                                                        colorText:
                                                            AppColors.white,
                                                        borderSide: true,
                                                        colorBorderSide:
                                                            AppColors.darkTeal1,
                                                        fontSize: 12,
                                                        fontWeight: 700,
                                                        color:
                                                            AppColors.darkTeal1,
                                                      ),
                                                    ),
                                                  ]),
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
                                              colorBorderSide: AppColors.darkTeal1,
                                              fontSize: 12,
                                              fontWeight: 700,
                                              color: AppColors.darkTeal1,
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
                }),
              ),
            ],
          )),
    );
  }
}
