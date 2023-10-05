import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:rashi_network/utils/assets_names.dart';

class HomeFirstModel {
  static List<HomeFirstModelItem> items = [
    HomeFirstModelItem(
      title: 'Call',
      image: 'assets/img/calls.png',
      iconData: PhosphorIcons.phone,
    ),
    HomeFirstModelItem(
      title: 'Chat',
      image: 'assets/img/chat.png',
      iconData: PhosphorIcons.chat,
    ),
    HomeFirstModelItem(
      title: 'Free Kundli',
      image: 'assets/img/kundali.png',
      iconData: FontAwesomeIcons.phone,
      svg: AssetsName.svgPremiumkundli,
    ),
    HomeFirstModelItem(
      title: 'Tarot',
      image: 'assets/img/blog.png',
      iconData: PhosphorIcons.clipboard,
    ),
  ];
}

class HomeFirstModelItem {
  final String title;
  final IconData iconData;
  final String image;
  final String? svg;

  HomeFirstModelItem({
    required this.title,
    required this.iconData,
    required this.image,
    this.svg,
  });
}
