// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1707891752226935/4249100450';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1707891752226935/4249100450';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4558540915051122/5263092433';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4558540915051122/5263092433';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialVideoAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/8691691433';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/8691691433';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
