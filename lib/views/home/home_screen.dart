import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rashi_network/common/common_function.dart';
import 'package:rashi_network/services/api/api_access.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/widgets/progress_circle.dart';
import 'package:rashi_network/utils/assets_names.dart';
import 'package:rashi_network/utils/commonWidget.dart';
import 'package:rashi_network/utils/controller/get_profile_controller.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/viewmodel/model/horoscope_model.dart';
import 'package:rashi_network/viewmodel/model/live_astrologer.dart';
import 'package:rashi_network/viewmodel/model/pr_release_model.dart';
import 'package:rashi_network/viewmodel/provider/api_future_state.dart';
import 'package:rashi_network/viewmodel/provider/appstate.dart';
import 'package:rashi_network/views/blogs/blogs_details.dart';
import 'package:rashi_network/views/blogs/view_all_blogs.dart';
import 'package:rashi_network/views/coming_soon_screen.dart';
import 'package:rashi_network/views/connect/call/astrologer_call_profile.dart';
import 'package:rashi_network/views/connect/chat/astrologer_chat_profile.dart';
import 'package:rashi_network/views/connect/history/chat_screen.dart';
import 'package:rashi_network/views/connect/history/socket/socket_handler.dart';
import 'package:rashi_network/views/daily_horoscope/daily_horoscope.dart';
import 'package:rashi_network/views/home/home_first_view.dart';
import 'package:rashi_network/views/home/more_for_grid_view.dart';
import 'package:rashi_network/views/live_astrologer/live_astrologer.dart';

import 'controller/daily_horoscope_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _controller = PageController(viewportFraction: 0.95);
  int currentPage = 0;
  List<String> bannerAssets = [
    'assets/img/banner/1.png',
    'assets/img/banner/2.png',
    'assets/img/banner/1.png',
    'assets/img/banner/2.png',
  ];

  @override
  void initState() {
    // TODO: implement initState

    GetProfileController.to.getProfileApi(params: {});
    ApiAccess().liveAstrologer(data: {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appStateauto = ref.watch(appStateautoDispose);
    final homeBannerFuture = ref.watch(futureGetBanner);
    final latestBlogsFuture = ref.watch(futureLatestBlogs);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 0),
          Container(
            height: 220,
            width: double.maxFinite,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsName.imgbannerforwebsite),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: homeBannerFuture.when(
              data: (data) {
                return Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                          controller: _controller,
                          onPageChanged: (value) {
                            setState(() {
                              currentPage = value;
                            });
                          },
                          itemCount: bannerAssets.length,
                          itemBuilder: (context, index) {
                            final livedata = bannerAssets[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => const LiveAstrologer());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5, left: 5),
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    // border: Border.all(
                                    //   width: 1,
                                    // color: DesignColor.lightGrey,
                                    // ),
                                  ),
                                  child: Image.asset(
                                    livedata,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        bannerAssets.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 6),
                          height: 6,
                          width: currentPage == index ? 18 : 18,
                          decoration: BoxDecoration(
                            color: currentPage == index ? const Color(0xFF999999) : const Color(0xFFE6E6E6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                return const SizedBox(height: 24, width: 24, child: Center(child: DesignProgress(color: Colors.white)));
              },
              loading: () {
                return const SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(
                        child: DesignProgress(
                      color: Colors.white,
                    )));
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeFirstView(appStateauto: appStateauto),
                const SizedBox(height: 10),
                const DesignText(
                  'We have More for you',
                  fontSize: 20,
                  fontWeight: 600,
                ),
                const SizedBox(height: 10),
                MoreForYouCardGrid(appStateauto: appStateauto),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const DesignText(
                      'Daily Horoscope',
                      fontSize: 20,
                      fontWeight: 600,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const DailyHoroscope() /*DailyHoroscope()*/);
                      },
                      child: const DesignText(
                        'View all',
                        fontSize: 13,
                        fontWeight: 400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
                itemCount: HoroscopeModel.items.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final livedata = HoroscopeModel.items[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: GestureDetector(
                      onTap: () {
                        showProgress();
                        DailyHoroscopeController.to.getHoroscopeApi(
                            sign: livedata.title,
                            success: () {
                              hideProgress();
                              Get.dialog(Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Icon(Icons.close)),
                                      ],
                                    ),
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.green,
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(livedata.image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      livedata.title,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    DesignText(
                                      'Personal Life',
                                      fontSize: 10,
                                      fontWeight: 500,
                                      color: AppColors.blackBackground,
                                    ),
                                    DesignText(
                                      DailyHoroscopeController.to.dailyHoroscopeRes['prediction']?['personal_life'] ?? '',
                                      fontSize: 10,
                                      fontWeight: 500,
                                      color: AppColors.lightGrey1,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    DesignText(
                                      'Health',
                                      fontSize: 10,
                                      fontWeight: 500,
                                      color: AppColors.blackBackground,
                                    ),
                                    DesignText(
                                      DailyHoroscopeController.to.dailyHoroscopeRes['prediction']?['health'] ?? '',
                                      fontSize: 10,
                                      fontWeight: 500,
                                      color: AppColors.lightGrey1,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    DesignText(
                                      'Luck',
                                      fontSize: 10,
                                      fontWeight: 500,
                                      color: AppColors.blackBackground,
                                    ),
                                    DesignText(
                                      DailyHoroscopeController.to.dailyHoroscopeRes['prediction']?['luck'] ?? '',
                                      fontSize: 10,
                                      fontWeight: 500,
                                      color: AppColors.lightGrey1,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ]),
                                ),
                              ));
                            },
                            error: (e) {
                              hideProgress();
                              showSnackBar(title: ApiConfig.error, message: e.toString());
                            });
                      },
                      child: Column(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: AppColors.lightGrey,
                              ),
                            ),
                            child: Image.asset(
                              livedata.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                          DesignText(
                            livedata.title,
                            fontSize: 16,
                            fontWeight: 500,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DesignText(
                  'Live Astrologers',
                  fontSize: 20,
                  fontWeight: 600,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LiveAstrologer(),
                      ),
                    );
                  },
                  child: const DesignText(
                    'View all',
                    fontSize: 13,
                    fontWeight: 400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: StreamBuilder(
                stream: ApiAccess.liveAstrologers.stream,
                builder: (context, snapshot) {
                  return ApiAccess.liveAstrologers.isNotEmpty
                      ? ListView.builder(
                          itemCount: ApiAccess.liveAstrologers.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {
                                  Get.dialog(Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Icon(Icons.close)),
                                          ],
                                        ),
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppColors.green,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage('https://thetaramandal.com/public/astrologer/${ApiAccess.liveAstrologers[index]['photo']}'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ApiAccess.liveAstrologers[index]['name'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                        DesignText(
                                          astrologerLanguage(ApiAccess.liveAstrologers[index]?['language'] ??
                                              ''), // in Live api Currently no data available like: Language, Last Checked: 19/05/2023 Time: 1:02 PM i got  "language": "1,2",
                                          fontSize: 10,
                                          fontWeight: 500,
                                          color: AppColors.lightGrey1,
                                        ),
                                        DesignText(
                                          '${ApiAccess.liveAstrologers[index]['experience'] ?? 0} Years',

                                          /// in some astrologerhave `NUll` Experiece Last Checked: 19/05/2023 Time: 1:02 PM
                                          fontSize: 10,
                                          fontWeight: 500,
                                          color: AppColors.lightGrey1,
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            if (ApiAccess.liveAstrologers[index]['call']! == 'Yes')
                                              SizedBox(
                                                height: 31,
                                                width: 81,
                                                child: DesignButtons(
                                                  onPressed: () async {
                                                    if (double.parse((GetProfileController.to.profileRes['data']?['userdetail']?['walletamount'] ?? '0.00').toString()) <
                                                        double.parse((ApiAccess.liveAstrologers[index]['call_price'] ?? 0).toString())) {
                                                      Get.back();
                                                      insufficientBalancePopup(
                                                          context, "${double.parse((ApiAccess.liveAstrologers[index]['call_price'] ?? 0).toString())}", "call");
                                                    } else {
                                                      Get.back();
                                                      Get.to(() => AstrologerCallProfile(astrologerProfile: ApiAccess.liveAstrologers[index]));
                                                    }
                                                  },
                                                  textLabel: 'Call',
                                                  isTappedNotifier: ValueNotifier(false),
                                                  sideWidth: 1,
                                                  colorText: Colors.white,
                                                  borderSide: true,
                                                  colorBorderSide: AppColors.darkTeal1,
                                                  fontSize: 12,
                                                  fontWeight: 700,
                                                  color: AppColors.darkTeal1,
                                                ),
                                              ),
                                            if (ApiAccess.liveAstrologers[index]['chat']! == 'Yes') const SizedBox(width: 8),
                                            if (ApiAccess.liveAstrologers[index]['chat']! == 'Yes')
                                              SizedBox(
                                                height: 31,
                                                width: 81,
                                                child: DesignButtons(
                                                  onPressed: () async {
                                                    if (double.parse((GetProfileController.to.profileRes['data']?['userdetail']?['walletamount'] ?? '0.00').toString()) <
                                                        double.parse((ApiAccess.liveAstrologers[index]['chat_price'] ?? 0).toString())) {
                                                      Get.back();
                                                      insufficientBalancePopup(
                                                          context, "${double.parse((ApiAccess.liveAstrologers[index]['chat_price'] ?? 0).toString())}", "chat");
                                                    } else {
                                                      Get.back();
                                                      Get.to(() => AstrologerChatProfile(astrologerProfile: ApiAccess.liveAstrologers[index]));
                                                    }
                                                  },
                                                  textLabel: 'Chat',
                                                  isTappedNotifier: ValueNotifier(false),
                                                  sideWidth: 1,
                                                  colorText: AppColors.darkTeal1,
                                                  borderSide: true,
                                                  colorBorderSide: AppColors.darkTeal1,
                                                  fontSize: 12,
                                                  fontWeight: 700,
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                      ]),
                                    ),
                                  ));
                                },
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  width: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.lightGrey,
                                    ),
                                    image: const DecorationImage(image: AssetImage('assets/img/background.png'), fit: BoxFit.cover),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppColors.green,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage('https://thetaramandal.com/public/astrologer/${ApiAccess.liveAstrologers[index]['photo']}'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          ApiAccess.liveAstrologers[index]['name'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : const Center(
                          child: DesignProgress(),
                        );
                }),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DesignText(
                  'Latest Blogs',
                  fontSize: 20,
                  fontWeight: 600,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LatestBlogsAllView(),
                        ));
                  },
                  child: const DesignText(
                    'View all',
                    fontSize: 13,
                    fontWeight: 400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 134,
            child: latestBlogsFuture.when(
              data: (data) {
                return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemBuilder: (context, index) {
                      final livedata = data[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LatestBlogsDetails(text: livedata.body!, image: 'https://thetaramandal.com/public/post/${livedata.image!}'),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            width: 181,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: AppColors.lightGrey,
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 82,
                                  width: double.infinity,
                                  child: Image.network(
                                    'https://thetaramandal.com/public/post/${livedata.image!}',
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: DesignText(
                                    livedata.title!,
                                    fontSize: 9,
                                    fontWeight: 600,
                                    maxLines: 2,
                                  ),
                                )
                                // Padding(
                                //   padding: const EdgeInsets.all(4.0),
                                //   child: HtmlWidget(
                                //     livedata.body!,
                                //     textStyle: const TextStyle(
                                //       fontSize: 9,
                                //       fontWeight: FontWeight.w600,
                                //       overflow: TextOverflow.ellipsis,
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              error: (error, stackTrace) {},
              loading: () {},
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DesignText(
                  'PR Release',
                  fontSize: 20,
                  fontWeight: 600,
                ),
                // DesignText(
                //   'View all',
                //   fontSize: 13,
                //   fontWeight: 400,
                // ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 125,
            child: FutureBuilder<List<PrReleaseModel>>(
                future: ApiAccess().prRelease(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!;
                    return ListView.builder(
                        itemCount: snap.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemBuilder: (context, index) {
                          final data = snap[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              width: 125,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.lightGrey,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  print(data.desktopimg);
                                },
                                child: Image.network(
                                  "https://thetaramandal.com/public/banner/${data.desktopimg}",
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Container();
                  }
                }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
