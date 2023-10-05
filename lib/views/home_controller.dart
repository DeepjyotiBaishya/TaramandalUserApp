import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rashi_network/services/api/api_access.dart';
import 'package:rashi_network/ui/custom/bottom_bar.dart';
import 'package:rashi_network/utils/assets_names.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/viewmodel/darkmode_state.dart';
import 'package:rashi_network/views/app_drawer.dart';
import 'package:rashi_network/views/bottom_controller.dart';
import 'package:rashi_network/views/coming_soon_screen.dart';
import 'package:rashi_network/views/connect/call/call.dart';
import 'package:rashi_network/views/connect/chat/chat.dart';
import 'package:rashi_network/views/home/home_screen.dart';
import 'package:rashi_network/views/notification_screen.dart';
import 'package:rashi_network/views/wallet/wallet.dart';
import '../utils/controller/get_profile_controller.dart';
import 'home/search_astrologer.dart';

class HomeController extends ConsumerStatefulWidget {
  const HomeController({super.key});
  @override
  ConsumerState<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends ConsumerState<HomeController> {
  // final InAppReview _inAppReview = InAppReview.instance;
  @override
  void initState() {
    GetProfileController.to.getProfileApi(params: {});
    // GetProfileController.to.getLiveAstrologerApi(params: {});
    // ApiAccess().liveAstrologer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeRef);
    // final appStateauto = ref.watch(appStateautoDispose);
    return WillPopScope(
      onWillPop: () async {
        if (BottomController.to.selectedIndOfBottom.value != 0) {
          BottomController.to.selectedIndOfBottom.value = 0;
          return false;
        }
        return true;
      },
      child: Obx(() {
        return Scaffold(
          appBar: BottomController.to.selectedIndOfBottom.value == 0
              ? AppBar(
                  elevation: 0,
                  title: SvgPicture.asset(
                    AssetsName.svgLogo,
                    alignment: Alignment.centerLeft,
                    height: 30,
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        log('SEARCH');
                        Get.to(() => const SearchAstrologerScreen());

                        // Get.to(() => SearchScreen());
                      },
                      child: Center(
                        child: Image.asset('assets/img/search.png', height: 20, width: 20, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Get.to(() => const NotificationScreen());
                      },
                      child: Center(
                        child: Image.asset(
                          'assets/img/notification.png',
                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Get.to(() => const Wallet());
                      },
                      child: Center(
                        child: Image.asset(
                          'assets/img/wallet_ICON.png',
                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                )
              : null,
          drawer: AppDrawer(),
          body: getBody(darkMode),
          bottomNavigationBar: _buildBottomBar(darkMode),
        );
      }),
    );
  }

  ///  done
  Widget _buildBottomBar(DarkMode darkMode) {
    return Obx(() {
      return CustomBottomBar(
        backgroundColor: darkMode.isDark ? AppColors.blackCard : null,
        bottomColor: darkMode.isDark ? AppColors.blackCard : null,
        containerHeight: 60,
        iconSize: 25,
        itemCornerRadius: 8,
        selectedIndex: BottomController.to.selectedIndOfBottom.value,
        showElevation: true,
        curve: Curves.linear,
        animationDuration: const Duration(milliseconds: 400),
        onItemSelected: (index) {
          ApiAccess().liveAstrologer(data: {});
          BottomController.to.selectedIndOfBottom.value = index;
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: const Icon(
              PhosphorIcons.house,
              size: 22,
            ),
            title: const Text('Home'),
            activeColor: AppColors.darkTeal,
            inactiveColor: AppColors.darkGrey,
          ),
          BottomBarItem(
            icon: const Icon(
              PhosphorIcons.chat,
              size: 22,
            ),
            title: const Text('Chat'),
            activeColor: AppColors.darkTeal,
            inactiveColor: AppColors.darkGrey,
          ),
          BottomBarItem(
            activeColor: AppColors.darkTeal,
            icon: const Icon(
              PhosphorIcons.phone,
              size: 22,
            ),
            title: const Text('Call'),
            inactiveColor: AppColors.darkGrey,
          ),
          BottomBarItem(
            icon: const Icon(
              PhosphorIcons.shopping_bag,
              size: 22,
            ),
            title: const Text('Shop'),
            activeColor: AppColors.darkTeal,
            inactiveColor: AppColors.darkGrey,
          ),
        ],
      );
    });
  }

  Widget getBody(DarkMode darkMode) {
    List<Widget> pages = const [
      HomeScreen(),
      Chat(),
      // ComingSoonScreen(),
      Call(),
      ComingSoonScreen(),
      // GemStone(),
    ];
    return Obx(() {
      return IndexedStack(index: BottomController.to.selectedIndOfBottom.value, children: pages);
    });
  }
}
