import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rashi_network/ui/custom/design_single_tap.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';

import '../../../ui/theme/buttons/buttons.dart';
import 'chat_data.dart';
import 'controller/history_controller.dart';

class ChatHistory extends ConsumerStatefulWidget {
  const ChatHistory({super.key});

  @override
  ConsumerState<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends ConsumerState<ChatHistory> {
  @override
  void initState() {
    log('INIT CALL HISTORY');
    HistoryController.to.userChatHistoryApi(params: {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return HistoryController.to.userChatHistoryRes.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(color: AppColors.darkTeal1),
              )
            : (HistoryController.to.userChatHistoryRes['data'] ?? []).isEmpty
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
                          "Ohhh!! you do not have any Chat History.",
                          fontSize: 18,
                          fontWeight: 400,
                          color: AppColors.lightGrey1,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: (HistoryController.to.userChatHistoryRes['data'] ?? []).length,
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
                                      'https://thetaramandal.com/public/astrologer/${(HistoryController.to.userChatHistoryRes['data'] ?? [])[index]?['photo'] ?? ''}',
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
                                            (HistoryController.to.userChatHistoryRes['data'] ?? [])[index]?['name'] ?? '-',
                                            fontSize: 14,
                                            fontWeight: 600,
                                          ),
                                        ],
                                      ),
                                      DesignText(
                                        'Date: ${(HistoryController.to.userChatHistoryRes['data'] ?? [])[index]?['created_at'] ?? ''}',
                                        fontSize: 12,
                                        fontWeight: 500,
                                        color: AppColors.lightGrey1,
                                      ),
                                      DesignText(
                                        'Chat rate: Rs.${(HistoryController.to.userChatHistoryRes['data'] ?? [])[index]?['chat_price'] ?? 0}/min',
                                        fontSize: 12,
                                        fontWeight: 500,
                                        color: AppColors.lightGrey1,
                                      ),
                                      DesignText(
                                        'Duration: ${(HistoryController.to.userChatHistoryRes['data'] ?? [])[index]?['duration'] ?? 0} seconds',
                                        fontSize: 12,
                                        fontWeight: 500,
                                        color: AppColors.lightGrey1,
                                      ),
                                      DesignText(
                                        'Deduction: ${(HistoryController.to.userChatHistoryRes['data'] ?? [])[index]?['chat_charges'] ?? '0'}',
                                        fontSize: 12,
                                        fontWeight: 500,
                                        color: AppColors.red,
                                      ),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            DesignText(
                                              getStatusText((HistoryController.to.userChatHistoryRes['data'] ?? [])[index]?['status'] ?? 0),
                                              fontSize: 12,
                                              fontWeight: 500,
                                              color: getStatusColor((HistoryController.to.userChatHistoryRes['data'] ?? [])[index]?['status'] ?? 0),
                                            ),
                                            SizedBox(
                                              height: 31,
                                            width: 81,
                                            child: DesignButtons(
                                              onPressed: () async {
                                                var name = (HistoryController.to.userChatHistoryRes['data'] ?? [])[index]?['name'] ?? '-';
                                                var chatId = (HistoryController.to.userChatHistoryRes['data'] ?? [])[index]?['chatid'] ?? 0;
                                                Navigator.push(
                                                    context, MaterialPageRoute( builder: (context) => ChatData(chatId,name)));
                                              },
                                              textLabel: 'Info',
                                              isTappedNotifier: ValueNotifier(false),
                                              sideWidth: 1,
                                              colorText: AppColors.darkTeal1,
                                              borderSide: true,
                                              colorBorderSide: AppColors.darkTeal1,
                                              fontSize: 12,
                                              fontWeight: 700,
                                              color: Colors.transparent,
                                            ),
                                          ),
                                        ],
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

String getStatusText(int status) {
  switch (status) {
    case 0:
      return 'Pending';
    case 1:
      return 'Accepted';
    case 2:
      return 'Completed';
    case 3:
      return 'Declined';
    case 4:
      return 'Unanswered';
    case 5:
      return 'Failedtoconnect';
    default:
      return 'Unknown Status';
  }
}

Color getStatusColor(int status) {
  switch (status) {
    case 0:
      return Colors.amber;
    case 1:
      return Colors.green;
    case 2:
      return Colors.green;
    case 3:
      return Colors.red;
    case 4:
      return Colors.red;
    case 5:
      return Colors.red;
    default:
      return Colors.red;
  }
}