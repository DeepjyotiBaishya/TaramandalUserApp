import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:rashi_network/common/common_function.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/viewmodel/model/astrologer_model.dart';
import 'package:rashi_network/views/connect/chat/chat_screen.dart';

import '../history/chat_screen.dart';
import 'enter_detail_chat_Screen.dart';

class AstrologerChatProfile extends StatefulWidget {
  const AstrologerChatProfile({super.key, required this.astrologerProfile});

  final Map astrologerProfile;
  @override
  State<AstrologerChatProfile> createState() => _AstrologerChatProfileState();
}

class _AstrologerChatProfileState extends State<AstrologerChatProfile> {
  @override
  Widget build(BuildContext context) {
    var document = parse('LONG Bio' ?? '');
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Astrologer Profile',
          color: Colors.white,
          fontSize: 20,
          fontWeight: 600,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: FloatingActionButton.extended(
              backgroundColor: AppColors.darkTeal,
              onPressed: () {
                Get.to(() => EnterDetailChatScreen(
                      astrologerProfile: widget.astrologerProfile,
                    ));
              },
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              label: const DesignText(
                "Chat now",
                color: Colors.white,
                fontSize: 16,
                fontWeight: 700,
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DesignContainer(
                color: AppColors.white,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.green),
                            borderRadius: BorderRadius.circular(60), // assuming height/width is 83
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              /* 'https://thetaramandal.com/public/astrologer/${widget.astrologerProfile.photo!}',*/
                              'https://thetaramandal.com/public/astrologer/${widget.astrologerProfile['photo']}',
                              height: 83,
                              width: 83,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 20,
                          child: ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.only(right: 2),
                              child: DesignText(
                                '⭐',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DesignText(
                            widget.astrologerProfile['name'],
                            fontSize: 12,
                            fontWeight: 600,
                          ),
                          const DesignText(
                            'Vaastu, Horoscope',
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.lightGrey1,
                          ),
                          DesignText(
                            astrologerLanguage(widget.astrologerProfile['language']),
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.lightGrey1,
                          ),
                          DesignText(
                            '${widget.astrologerProfile['experience'] ?? 0} Years',
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.lightGrey1,
                          ),
                          DesignText(
                            'Rs.${widget.astrologerProfile['chat_price'] ?? 0}/Min',
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.red,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const DesignText(
                'Skills',
                fontSize: 15,
                fontWeight: 700,
              ),
              const SizedBox(height: 10),
              widget.astrologerProfile['categories'] == null || widget.astrologerProfile['categories'] == ''
                  ? const SizedBox()
                  : SizedBox(
                      height: 30,
                      child: ListView.builder(
                        itemCount: widget.astrologerProfile['categories'].toString().split(',').length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: DesignContainer(
                              borderAllColor: AppColors.gold,
                              bordered: true,
                              allPadding: 6,
                              alignment: Alignment.center,
                              child: DesignText(
                                widget.astrologerProfile['categories'].toString().split(',')[index] == '2'
                                    ? 'Vedic Astrology'
                                    : widget.astrologerProfile['categories'].toString().split(',')[index] == '3'
                                        ? 'Tarot'
                                        : 'Jyotish Vigyanam',
                                fontSize: 12,
                                fontWeight: 500,
                                color: AppColors.gold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(height: 20),
              const DesignText(
                'About me',
                fontSize: 16,
                fontWeight: 600,
              ),
              const SizedBox(height: 10),
              DesignText(
                widget.astrologerProfile['name'] ?? 'N/A',
                fontSize: 11,
                fontWeight: 400,
              ),
              DesignText(
                "Date Of Birth: " + '${widget.astrologerProfile['dob'] ?? 'N/A'}',
                fontSize: 11,
                fontWeight: 400,
              ),
              DesignText(
                widget.astrologerProfile['long_bio'] ?? '',
                fontSize: 11,
                fontWeight: 400,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
