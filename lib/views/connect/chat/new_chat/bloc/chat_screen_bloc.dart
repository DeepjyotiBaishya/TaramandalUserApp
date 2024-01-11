// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../../../../services/shared_prefrence/pref_controller.dart';
// import '../model/chat_screen_models.dart';
//
// class ChatScreenBloc {
//   final String apiUrl = "https://www.thetaramandal.com/api/send_chat_message";
//
//
//   Future<ChatScreenModels> sendMessage(Map<String, dynamic> message) async {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer ' + PrefrenceDataController.to.token.value},
//
//       body: jsonEncode(message),
//     );
//     // log('body response ${(response.body)}');
//     if (response.statusCode == 200) {
//       return ChatScreenModels.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to send message');
//     }
//   }
// }
