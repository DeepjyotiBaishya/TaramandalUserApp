import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ads_helper.dart';

class GetAds extends GetxController {
  static GetAds get to => Get.put(GetAds());

  static const _adAfter = 7;
  static const AdRequest request = AdRequest();

  RxInt life = 0.obs;
  RxInt maxFailedLoadAttempts = 3.obs;
  late BannerAd bannerAd;
  RxBool isBannerAdReady = false.obs;
  RxBool isVideoAdsOff = false.obs;

  InterstitialAd? interstitialAd;
  RxInt _numInterstitialLoadAttempts = 0.obs;

  RewardedAd? _rewardedAd;
  RxInt _numRewardedLoadAttempts = 0.obs;

  RewardedInterstitialAd? _rewardedInterstitialAd;
  RxInt _numRewardedInterstitialLoadAttempts = 0.obs;

  late NativeAd nativeAds;

  // Ads creation starts here
  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isBannerAdReady.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          isBannerAdReady.value = false;
          ad.dispose();
          print("failed to load banner adddd");
        },
      ),
    );
    bannerAd.load();
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            interstitialAd = ad;
            _numInterstitialLoadAttempts.value = 0;
            interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts.value += 1;
            interstitialAd = null;
            if (_numInterstitialLoadAttempts.value <
                maxFailedLoadAttempts.value) {
              createInterstitialAd();
            } else {
              // Get.back();
            }
          },
        ));
  }

  void showInterstitialAd() {
    // if (interstitialAd == null) {
    //   print('Warning: attempt to show interstitial before loaded.');
    //   return;
    // }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

  void createInterstitialVideoAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialVideoAd,
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded.');
          interstitialAd = ad;
          _numInterstitialLoadAttempts.value = 0;
          // showInterstitialVideoAd();
          // isVideoAdsOff.value = false;
        },
        onAdFailedToLoad: (LoadAdError error) {
          interstitialAd = null;
          _numInterstitialLoadAttempts.value += 1;
          if (_numInterstitialLoadAttempts.value <
              maxFailedLoadAttempts.value) {
            createInterstitialVideoAd();
          }
        },
      ),
    );
  }

  Future<bool> showInterstitialVideoAd() async {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return false;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
      isVideoAdsOff.value = true;
      print("close add ${isVideoAdsOff.value}");
      ad.dispose();
      createInterstitialVideoAd();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      print('$ad onAdFailedToShowFullScreenConte00nt: $error');
      ad.dispose();
      createInterstitialVideoAd();
    });
    interstitialAd!.show();
    interstitialAd = null;
    return isVideoAdsOff.value;
  }
}

/*
class GetFacebookAds extends GetxController {
  static GetFacebookAds get to => Get.put(GetFacebookAds());
  bool _isInterstitialAdLoaded = false;
  bool _isRewardedAdLoaded = false;
  Widget _currentAd = Container(color: Colors.black,);

  initAds() {
    FacebookAudienceNetwork.init(
      testingId: "a77955ee-3304-4635-be65-81029b0f5201",
      iOSAdvertiserTrackingEnabled: true,
    );
  }

  void loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          loadInterstitialAd();
        }
      },
    );
  }

  void loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) _isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)

        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          _isRewardedAdLoaded = false;
          loadRewardedVideoAd();
        }
      },
    );
  }

  showBannerAd() {
    _currentAd = FacebookBannerAd(

      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        print("Banner Ad: $result -->  $value");
      },
    );
  }

  showNativeAd() {
    _currentAd = _nativeAd();
  }

  Widget _nativeAd() {
    return FacebookNativeAd(
      placementId: "IMG_16_9_APP_INSTALL#E5B8D3D6D9145D585A1732E0A07866BD",
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }

   showNativeBannerAd() {
    _currentAd = _nativeBannerAd();

  }

  Widget _nativeBannerAd() {
    return FacebookNativeAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
      adType: NativeAdType.NATIVE_BANNER_AD,
      bannerAdSize: NativeBannerAdSize.HEIGHT_100,
      width: double.infinity,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    );
  }

  showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstial Ad not yet loaded!");
  }

  showRewardedAd() {
    if (_isRewardedAdLoaded == true)
      FacebookRewardedVideoAd.showRewardedVideoAd();
    else
      print("Rewarded Ad not yet loaded!");
  }
}
*/

class GetFaceBookAds extends GetxController {
  static GetFaceBookAds get to => Get.put(GetFaceBookAds());
  bool _isInterstitialAdLoaded = false;

// void loadInterstitialAd() {
//   FacebookInterstitialAd.loadInterstitialAd(
//     // placementId: "YOUR_PLACEMENT_ID",
//     placementId:
//         "${ApiAdController.to.apiAdResData['data']?['facebook']?[0]?['interstial'] ?? ""}",
//     listener: (result, value) {
//       print(">> FAN > Interstitial Ad: $result --> $value");
//       if (result == InterstitialAdResult.LOADED)
//         _isInterstitialAdLoaded = true;
//
//       /// Once an Interstitial Ad has been dismissed and becomes invalidated,
//       /// load a fresh Ad by calling this function.
//       if (result == InterstitialAdResult.DISMISSED &&
//           value["invalidated"] == true) {
//         _isInterstitialAdLoaded = false;
//         loadInterstitialAd();
//       }
//     },
//   );
// }
//
// showInterstitialAd() {
//   if (_isInterstitialAdLoaded == true)
//     FacebookInterstitialAd.showInterstitialAd();
//   else
//     print("Interstial Ad not yet loaded!");
// }
//
// Widget nativeAd() {
//   return FacebookNativeAd(
//     placementId:
//         "${ApiAdController.to.apiAdResData['data']?['facebook']?[0]?['netive'] ?? ""}",
//     adType: NativeAdType.NATIVE_AD_VERTICAL,
//     width: double.infinity,
//     height: 300,
//     // backgroundColor: Colors.blue,
//     // titleColor: Colors.white,
//     // descriptionColor: Colors.white,
//     // buttonColor: Colors.deepPurple,
//     // buttonTitleColor: Colors.white,
//     // buttonBorderColor: Colors.white,
//     listener: (result, value) {
//       print("Native Ad: $result --> $value");
//     },
//     keepExpandedWhileLoading: false,
//     expandAnimationDuraion: 300,
//   );
// }
}
