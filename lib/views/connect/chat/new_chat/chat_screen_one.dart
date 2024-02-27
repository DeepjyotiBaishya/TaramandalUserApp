import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/controller/get_profile_controller.dart';
import '../../../../utils/design_colors.dart';
import '../../../../utils/snackbar.dart';
import '../../../home_controller.dart';
import '../controller/chatReq_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import 'model/model_chat.dart';

class ChatScreenPage extends StatefulWidget {
  final int requestId;
  final int receiverId;
  final name;
  final String max_chat_duration;
  const ChatScreenPage(this.requestId, this.receiverId, this.name, this.max_chat_duration, {Key? key}): super(key: key);

  @override
  _ChatScreenPageState createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Message> messageList = [];
  ScrollController _scrollController = ScrollController();
  late WebSocketChannel _channel;
  final channel = IOWebSocketChannel.connect('ws://thetaramandal.com:8091');
  bool _isSendingMessage = false;
  late CountdownController _controller;
  late int maxChatDurationInSeconds = 0;


  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        ChatController.to.endChatApi(
          data: {"chatreqid": widget.requestId},
          success: () {
          },
          error: (e) {
            showSnackBar(
              title: ApiConfig.error,
              message: e.toString(),
            );
          },
        );
        Get.offAll(() => const HomeController());
        GetProfileController.to.getProfileApi(params: {});
      }
    });
    _channel = IOWebSocketChannel.connect('ws://thetaramandal.com:8091');
    _channel.stream.listen(_handleWebSocketData);
    _controller = CountdownController();
    maxChatDurationInSeconds = parseDurationInSeconds(widget.max_chat_duration);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _controller.restart();
    });
  }

  int parseDurationInSeconds(String durationString) {
    List<String> parts = durationString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    return hours * 3600 + minutes * 60 + seconds;
  }


  void _sendMessage() {
    if (_messageController.text.isNotEmpty && !_isSendingMessage) {
      setState(() {
        _isSendingMessage = true;
      });

      String messageText = _messageController.text;
      print('Sending message: $messageText');

      var senderId = GetProfileController.to.profileRes.value["data"]?['user']?["id"] ?? 0;

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('MMMM d, y').format(now);
      String formattedTime = DateFormat('jm').format(now);

      final Map<String, dynamic> messageJson = {
        'type': 'chat_message',
        'sender_id': senderId,
        'recipient_id': widget.receiverId,
        'reqid': widget.requestId,
        'message': messageText,
        'date': formattedDate,
        'time': formattedTime,
      };

      final String jsonString = jsonEncode(messageJson);
      channel.sink.add(jsonString);

      _messageController.clear();

      setState(() {
        _isSendingMessage = false;
      });
    }
  }

  void main() {
    final channel = IOWebSocketChannel.connect('ws://thetaramandal.com:8091');
    channel.stream.listen(
          (message) {
        print('Received: $message');
      },
      onDone: () {
        print('WebSocket closed');
      },
      onError: (error) {
        print('Error: $error');
      },
    );

    Future.delayed(Duration(seconds: 3), () {
      channel.sink.close();
    });
  }

  void _handleWebSocketData(dynamic data) {
    Map<String, dynamic> jsonData = json.decode(data);
    Message receivedMessage = Message.fromJson(jsonData);
    if (mounted) {
      print('Received Message: ${receivedMessage.textMessage}');
      setState(() {
        Future.delayed(Duration(milliseconds: 50), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
        messageList.add(receivedMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: Text(widget.name),
        actions: <Widget>[
          Row(
            children: [
              Countdown(
                controller: _controller,
                seconds: maxChatDurationInSeconds,
                build: (BuildContext context, double time) => Text(
                  '${formatDuration(Duration(seconds: time.toInt()))}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                interval: Duration(seconds: 1),
                onFinished: () {
                  // This code will be executed when the countdown reaches zero
                  ChatController.to.endChatApi(
                    data: {"chatreqid": widget.requestId},
                    success: () {
                      // Handle success if needed
                    },
                    error: (e) {
                      showSnackBar(
                        title: ApiConfig.error,
                        message: e.toString(),
                      );
                    },
                  );
                  Get.offAll(() => const HomeController());
                  GetProfileController.to.getProfileApi(params: {});
                },
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  onPressed: () {
                    ChatController.to.endChatApi(
                        data: {"chatreqid": widget.requestId},
                        success: () {
                          // Handle success if needed
                        },
                        error: (e) {
                          showSnackBar(
                            title: ApiConfig.error,
                            message: e.toString(),
                          );
                        });
                    Get.offAll(() => const HomeController());
                    GetProfileController.to.getProfileApi(params: {});
                  },
                  child: Text(
                    'Leave',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white), // Border color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messageList.length,
              itemBuilder: (BuildContext context, int index) {
                var item = messageList[index];
                return ListTile(
                  title:  Row(
                    mainAxisAlignment: () {
                      final astroId = GetProfileController.to.profileRes;
                      final int newId = astroId.value["data"]?['user']?["id"] ?? 0;
                      final int? incomingMsgId = messageList[index].senderId;

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
                                  final astroId = GetProfileController.to.profileRes;
                                  final int newId = astroId.value["data"]?['user']?["id"] ?? 0;
                                  final int? incomingMsgId = messageList[index].senderId;
                                  if (incomingMsgId == newId) {
                                    return Color(0xFF61CDD5);
                                  } else {
                                    return Color(0xFFE3F0F1);
                                  }
                            }(),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            messageList[index].textMessage ?? '',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                subtitle:
                  Row(
                    mainAxisAlignment: () {
                      final astroId = GetProfileController.to.profileRes;
                      final int newId = astroId.value["data"]?['user']?["id"] ?? 0;
                      final int? incomingMsgId = messageList[index].senderId;

                      if (incomingMsgId == newId) {
                        return MainAxisAlignment.end;
                      } else {
                        return MainAxisAlignment.start;
                      }
                    }(),
                    children: [
                      Text(
                        messageList[index].date ?? '',
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
                        messageList[index].time ?? '',
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
                        borderRadius: BorderRadius.circular(10.0),
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
                                    _scrollController.animateTo(
                                        _scrollController.position
                                            .maxScrollExtent,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                    {
                                      _sendMessage();
                                    }
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
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}