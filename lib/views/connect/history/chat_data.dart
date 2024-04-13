import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../utils/design_colors.dart';
import '../../../ui/theme/text.dart';
import '../../../utils/controller/get_profile_controller.dart';
import 'controller/history_controller.dart';

class ChatData extends StatefulWidget {
  final int requestId;
  final name;
  const ChatData(this.requestId, this.name, {Key? key}): super(key: key);

  @override
  _ChatDataState createState() => _ChatDataState();
}

class _ChatDataState extends State<ChatData> {

  @override
  void initState() {
    super.initState();
    HistoryController.to.chatInfoApi(
      params: {"chatreqid": widget.requestId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: Text(widget.name),
        actions: <Widget>[
        ],
      ),
      body:  Obx(() {
        return HistoryController.to.chatInfoRes.isEmpty
            ? const Center(
          child: CupertinoActivityIndicator(color: AppColors.darkTeal1),
        )
            : (HistoryController.to.chatInfoRes['data'] ?? []).isEmpty
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
          itemCount: (HistoryController.to.chatInfoRes['data'] ?? []).length,
          padding: const EdgeInsets.all(5),
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                mainAxisAlignment: () {
                  final astroId = GetProfileController.to.profileRes;
                  final int newId = astroId.value["data"]?['user']?["id"] ?? 0;
                  // final newId = '157';
                  final incomingMsgId = (HistoryController.to.chatInfoRes['data'] ?? [])[index]?['incoming_msg_id'] ?? '';

                  print('incomingMsgId $incomingMsgId');

                  if (incomingMsgId == newId) {
                    return MainAxisAlignment.end;
                  } else {
                    return MainAxisAlignment.start;
                  }
                }(),
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 13,
                        left: 12,
                        right: 10,
                        bottom: 16,
                      ),
                      decoration: BoxDecoration(
                        color: () {
                          // final astroId = GetProfileController.to.profileRes;
                          // final int newId = astroId.value["data"]?['user']?["id"] ?? 0;
                          final newId = '157';
                          final incomingMsgId = (HistoryController.to.chatInfoRes['data'] ?? [])[index]?['incoming_msg_id'] ?? '';

                          print('incomingMsgId $incomingMsgId');

                          if (incomingMsgId == newId) {
                            return Color(0xFF61CDD5);
                          } else {
                            return Color(0xFFE3F0F1);
                          }
                        }(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '${(HistoryController.to.chatInfoRes['data'] ?? [])[index]?['text_message'] ?? ''}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: () {
                    // final astroId = GetProfileController.to.profileRes;
                    // final int newId = astroId.value["data"]?['user']?["id"] ?? 0;
                    final newId = '157';
                    final incomingMsgId = (HistoryController.to.chatInfoRes['data'] ?? [])[index]?['incoming_msg_id'] ?? '';

                    print('incomingMsgId $incomingMsgId');

                    if (incomingMsgId == newId) {
                      return MainAxisAlignment.end;
                    } else {
                      return MainAxisAlignment.start;
                    }
                  }(),
                  children: [
                    Text(
                      '${(HistoryController.to.chatInfoRes['data'] ??
                          [])[index]?['curr_date'] ?? ''}',
                      style: TextStyle(
                        color: Color(0xFF8A8A8A),
                        fontSize: 10,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.35,
                      ), // You can adjust the font size as needed
                    ),
                    SizedBox(width: 5),
                    Text(
                      '${(HistoryController.to.chatInfoRes['data'] ??
                          [])[index]?['curr_time'] ?? ''}',
                      style: TextStyle(
                        color: Color(0xFF8A8A8A),
                        fontSize: 10,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.35,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
      ),
    );
  }
}