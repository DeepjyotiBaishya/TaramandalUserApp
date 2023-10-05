import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:rashi_network/app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'services/notification_service/push_notification_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService().setupInteractedMessage();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('settings');
  runApp(const ProviderScope(child: App()));
}

/// remove me `Just for Checking New Push 01`
