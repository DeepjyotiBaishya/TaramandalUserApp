// import 'dart:developer';
//
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class socketController {
//   late IO.Socket socket;
//   initData() async {
//     try {
//       IO.Socket socket = IO.io(
//           'ws://35.154.43.70:8090/chatdemo/php-socket.php',
//           IO.OptionBuilder()
//               .setTransports(['websocket']) // for Flutter or Dart VM
//               // disable auto-connection
//               /* .setExtraHeaders({'foo': 'bar'}) // optional*/
//               .build());
//       socket.connect();
//
//       socket.onConnectError((_) {
//         print('onConnectError ${_.toString()}');
//         socket.emit('msg', 'test');
//       });
//       socket.onConnect((_) {
//         print('connect');
//         socket.emitWithAck('msg', 'init', ack: (data) {
//           print('ack $data');
//           if (data != null) {
//             print('from server $data');
//           } else {
//             print("Null");
//           }
//         });
//         socket.emit('msg', 'test');
//       });
//       socket.on('event', (data) => print(data));
//       socket.onDisconnect((_) => print('disconnect'));
//       socket.on('fromServer', (_) => print(_));
//     } catch (e) {
//       log(e.toString(), name: "onerror");
//     }
//   }
//
//   disconnect() async {
//     socket.disconnect();
//   }
// }
