// Flutter web plugin registrant file.
//
// Generated file. Do not edit.
//

// @dart = 2.13
// ignore_for_file: type=lint

import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:connectivity_plus/src/connectivity_plus_web.dart';
import 'package:device_info_plus/src/device_info_plus_web.dart';
import 'package:firebase_analytics_web/firebase_analytics_web.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_messaging_web/firebase_messaging_web.dart';
import 'package:firebase_remote_config_web/firebase_remote_config_web.dart';
import 'package:flutter_keyboard_visibility_web/flutter_keyboard_visibility_web.dart';
import 'package:fluttertoast/fluttertoast_web.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:instamojo/instamojo_web.dart';
import 'package:rive_common/rive_web.dart';
import 'package:share_plus/src/share_plus_web.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  FirebaseFirestoreWeb.registerWith(registrar);
  ConnectivityPlusWebPlugin.registerWith(registrar);
  DeviceInfoPlusWebPlugin.registerWith(registrar);
  FirebaseAnalyticsWeb.registerWith(registrar);
  FirebaseAuthWeb.registerWith(registrar);
  FirebaseCoreWeb.registerWith(registrar);
  FirebaseMessagingWeb.registerWith(registrar);
  FirebaseRemoteConfigWeb.registerWith(registrar);
  FlutterKeyboardVisibilityPlugin.registerWith(registrar);
  FluttertoastWebPlugin.registerWith(registrar);
  GoogleMapsPlugin.registerWith(registrar);
  GoogleSignInPlugin.registerWith(registrar);
  ImagePickerPlugin.registerWith(registrar);
  InstamojoWeb.registerWith(registrar);
  RivePlugin.registerWith(registrar);
  SharePlusWebPlugin.registerWith(registrar);
  SharedPreferencesPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
