import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/controller/get_profile_controller.dart';
import '../../../../utils/design_colors.dart';
import '../../../../utils/snackbar.dart';
import '../../../home_controller.dart';
import '../controller/chatReq_controller.dart';
import 'bloc/chat_screen_bloc.dart';
import 'model/chat_screen_models.dart';

class ChatScreenPage extends StatefulWidget {
  final int requestId;
  final int receiverId;
  final name;
  const ChatScreenPage(this.requestId, this.receiverId, this.name, {Key? key}): super(key: key);

  @override
  _ChatScreenPageState createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  final ChatScreenBloc _bloc = ChatScreenBloc();
  final TextEditingController _messageController = TextEditingController();
  List<Message> _messages = [];
  List<Communication> _communication = [];
  ScrollController _scrollController =  ScrollController();

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
        title: Text(widget.name),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: OutlinedButton(
              onPressed: () {
                ChatController.to.endChatApi(
                    data: {"chatreqid": widget.requestId,
                    },
                    success: () {
                      // Get.offAll(() => HomeController());
                    },
                    error: (e) {
                      showSnackBar(title: ApiConfig.error, message: e.toString());
                    });
                Get.offAll(() => const HomeController());
                GetProfileController.to.getProfileApi(params: {});
              },
              child: Text(
                'Leave', // You can replace 'Leave' with the desired text
                style: TextStyle(
                  color: Colors.white, // Text color
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white), // Border color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                var item = _messages[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: () {
                      final astroId = GetProfileController.to.profileRes;
                      final int newId = astroId.value["data"]?['user']?["id"] ?? 0;
                      final String? incomingMsgId = _messages[index].incomingMsgId;

                      if (incomingMsgId != null && int.tryParse(incomingMsgId) == newId) {
                        return MainAxisAlignment.start;
                      } else {
                        return MainAxisAlignment.end;
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
                            // color: _messages[index].sender: senderId ? Colors.blue : Colors.grey, // Customize colors as needed
                            color: () {
                              final astroId = GetProfileController.to.profileRes;
                              final int newId = astroId.value["data"]?['user']?["id"] ?? 0;
                              final String? incomingMsgId = _messages[index].incomingMsgId;

                              if (incomingMsgId != null && int.tryParse(incomingMsgId) == newId) {
                                return  Color(0xFFE3F0F1);
                              } else {
                                return  Color(0xFF61CDD5);
                              }
                            }(),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            _messages[index].textMessage ?? '',
                            style: TextStyle(fontSize: 16, color: Colors.black), // You can adjust the font size and color as needed
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: () {
                      final astroId = GetProfileController.to.profileRes;
                      final int newId = astroId.value["data"]?['user']?["id"] ?? 0;
                      final String? incomingMsgId = _messages[index].incomingMsgId;

                      if (incomingMsgId != null && int.tryParse(incomingMsgId) == newId) {
                        return MainAxisAlignment.start;
                      } else {
                        return MainAxisAlignment.end;
                      }
                    }(),
                    children: [
                      Text(
                        _messages[index].currDate ?? '',
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
                        _messages[index].currTime ?? '',
                        style: TextStyle(
                          color: Color(0xFF8A8A8A),
                          fontSize: 10,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 0.35,
                        ), // You can adjust the font size as needed
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type Message',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      suffixIcon: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(60),
                                clipBehavior: Clip.antiAlias,
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(60),
                                clipBehavior: Clip.antiAlias,
                                child: IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                                    _sendMessage();
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      // GetProfileController.to.profileRes['data']?['userdetail']?['walletamount'] ?? '';
      var res = GetProfileController.to.profileRes;
      var senderId = res.value["data"]?['user']?["id"] ?? 0;
      // debugPrint("senderId $senderId");

      MessageChat message = MessageChat(
        reqid: widget.requestId,
        sender: senderId,
        receiver: widget.receiverId,
        message: _messageController.text,
      );

      try {
        var response = await _bloc.sendMessage(
            message.toJson());
        setState(() {
          _messages = response.message ?? [];
          _communication = response.communication ?? [];
        });
        // Handle the response here
        // debugPrint("response $response");
      } catch (e) {
        // Handle error
        print("Failed to send message: $e");
      }
      _messageController.clear();
    }
  }
}

class MessageChat {
  int reqid;
  int sender;
  int receiver;
  String message;

  MessageChat({
    required this.reqid,
    required this.sender,
    required this.receiver,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      "reqid": reqid,
      "sender": sender,
      "receiver": receiver,
      "message": message,
    };
  }
}
