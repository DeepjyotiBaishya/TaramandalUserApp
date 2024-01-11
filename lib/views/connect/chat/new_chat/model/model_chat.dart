class Message {
  String? type;
  int? senderId;
  int? recipientId;
  int? reqId;
  String? textMessage;
  String? date;
  String? time;

  Message({
    this.type,
    this.senderId,
    this.recipientId,
    this.reqId,
    this.textMessage,
    this.date,
    this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      type: json['type'] ?? '',
      senderId: json['sender_id'] ?? 0,
      recipientId: json['recipient_id'] ?? 0,
      reqId: json['reqid'] ?? 0,
      textMessage: json['message'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
    );
  }
}