import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/views/kundali/controller/free_kundly_controller.dart';

class FreeKundaliDetails extends StatefulWidget {
  final String name;
  final String date;
  final String day;
  final String month;
  final String year;
  final String hour;
  final String min;
  final String time;
  final String place;
  final String latitude;
  final String longitude;
  final String timeZone;
  final String gender;
  const FreeKundaliDetails(
      {super.key,
      required this.name,
      required this.date,
      required this.time,
      required this.latitude,
      required this.longitude,
      required this.timeZone,
      required this.day,
      required this.month,
      required this.year,
      required this.hour,
      required this.min,
      required this.place,
      required this.gender});

  @override
  State<FreeKundaliDetails> createState() => _FreeKundaliDetailsState();
}

class _FreeKundaliDetailsState extends State<FreeKundaliDetails> {
  final PageController _pageController = PageController(initialPage: 0);
  final ScrollController _scrollController = ScrollController();

  List<String> dataInfo = [
    'General',
    'Birth Details',
    'Lagan',
    'Basic Panchang',
    'Planets',
    /* 'Ghat Chakra',
    'Dasha',
    'Sadhe Sati',*/

    /* 'Planetary',
    'Dasha',*/
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Results',
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
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0, right: 12, left: 12),
        child: Column(
          children: [
            SizedBox(
              height: 34,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: dataInfo.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  String st = dataInfo[index];
                  bool isSelected = selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      height: 31,
                      child: DesignButtons(
                        onPressed: () async {
                          _pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                          setState(() => selectedIndex = index);
                        },
                        textLabel: st,
                        isTappedNotifier: ValueNotifier(false),
                        sideWidth: 1,
                        colorText: isSelected ? AppColors.darkGrey : AppColors.gold,
                        borderSide: true,
                        colorBorderSide: AppColors.gold,
                        fontSize: 12,
                        fontWeight: 700,
                        color: isSelected ? AppColors.gold : Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: PageView(
                  onPageChanged: (value) {
                    if (selectedIndex > value) {
                      _scrollController.animateTo(
                        _scrollController.offset - (MediaQuery.of(context).size.width * 0.20),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    } else {
                      _scrollController.animateTo(
                        _scrollController.offset + (MediaQuery.of(context).size.width * 0.20),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }

                    setState(() => selectedIndex = value);
                  },
                  controller: _pageController,
                  children: [
                    BasicDetails(
                        name: widget.name,
                        date: widget.date,
                        day: widget.day,
                        month: widget.month,
                        year: widget.year,
                        hour: widget.hour,
                        min: widget.min,
                        time: widget.time,
                        place: widget.place,
                        latitude: widget.latitude,
                        longitude: widget.longitude,
                        gender: widget.gender),
                    BasicKundli(
                        name: widget.name,
                        date: widget.date,
                        day: widget.day,
                        month: widget.month,
                        year: widget.year,
                        hour: widget.hour,
                        min: widget.min,
                        time: widget.time,
                        place: widget.place,
                        latitude: widget.latitude,
                        longitude: widget.longitude),
                    LaganChart(
                        name: widget.name,
                        date: widget.date,
                        day: widget.day,
                        month: widget.month,
                        year: widget.year,
                        hour: widget.hour,
                        min: widget.min,
                        time: widget.time,
                        place: widget.place,
                        latitude: widget.latitude,
                        longitude: widget.longitude),
                    BasicPanchang(
                        name: widget.name,
                        date: widget.date,
                        day: widget.day,
                        month: widget.month,
                        year: widget.year,
                        hour: widget.hour,
                        min: widget.min,
                        time: widget.time,
                        place: widget.place,
                        latitude: widget.latitude,
                        longitude: widget.longitude),
                    PlanetsScreen(
                      name: widget.name,
                      date: widget.date,
                      day: widget.day,
                      month: widget.month,
                      year: widget.year,
                      hour: widget.hour,
                      min: widget.min,
                      time: widget.time,
                      place: widget.place,
                      latitude: widget.latitude,
                      longitude: widget.longitude,
                    ),
                    /*  GhatChakra(
                      name: widget.name,
                      date: widget.date,
                      day: widget.day,
                      month: widget.month,
                      year: widget.year,
                      hour: widget.hour,
                      min: widget.min,
                      time: widget.time,
                      place: widget.place,
                      latitude: widget.latitude,
                      longitude: widget.longitude,
                    ),
                    MajorDasha(
                      name: widget.name,
                      date: widget.date,
                      day: widget.day,
                      month: widget.month,
                      year: widget.year,
                      hour: widget.hour,
                      min: widget.min,
                      time: widget.time,
                      place: widget.place,
                      latitude: widget.latitude,
                      longitude: widget.longitude,
                    ),
                    SadheSatiScreen(
                      name: widget.name,
                      date: widget.date,
                      day: widget.day,
                      month: widget.month,
                      year: widget.year,
                      hour: widget.hour,
                      min: widget.min,
                      time: widget.time,
                      place: widget.place,
                      latitude: widget.latitude,
                      longitude: widget.longitude,
                    ),*/
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

///1
class BasicDetails extends StatefulWidget {
  final String name;
  final String date;
  final String day;
  final String month;
  final String year;
  final String hour;
  final String min;
  final String time;
  final String place;
  final String latitude;
  final String longitude;
  final String gender;
  const BasicDetails({
    Key? key,
    required this.name,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.min,
    required this.time,
    required this.place,
    required this.latitude,
    required this.longitude,
    required this.gender,
  }) : super(key: key);

  @override
  State<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  @override
  void initState() {
    // TODO: implement initState
    FreeKundlyController.to.basicDataApi(
      params: {
        "day": widget.day,
        "month": widget.month,
        "year": widget.year,
        "hour": widget.hour,
        "min": widget.min,
        "lat": widget.latitude,
        "lon": widget.longitude,
        "tzone": DateTime.now().timeZoneOffset.toString(),
        'gender': widget.gender.toLowerCase()
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return FreeKundlyController.to.basicDataRes.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.teal,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const DesignText(
                      'General Events :',
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    FreeKundlyController.to.basicDataRes['report']?['general_events'].runtimeType == List
                        ? Column(
                            children: List.generate(
                                (FreeKundlyController.to.basicDataRes['report']?['general_events'] ?? []).length,
                                (index) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: DesignText(
                                        FreeKundlyController.to.basicDataRes['report']?['general_events']?[index] ?? 'N/A',
                                        fontSize: 14,
                                        fontWeight: 400,
                                      ),
                                    )),
                          )
                        : const DesignText(
                            'N/A',
                            fontSize: 14,
                            fontWeight: 400,
                          ),
                    const SizedBox(
                      height: 12,
                    ),
                    const DesignText(
                      'Family Life :',
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    FreeKundlyController.to.basicDataRes['report']?['family_life'].runtimeType == List
                        ? Column(
                            children: List.generate(
                                (FreeKundlyController.to.basicDataRes['report']?['family_life'] ?? []).length,
                                (index) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      child: DesignText(
                                        FreeKundlyController.to.basicDataRes['report']?['family_life']?[index] ?? 'N/A',
                                        fontSize: 14,
                                        fontWeight: 400,
                                      ),
                                    )),
                          )
                        : const DesignText(
                            'N/A',
                            fontSize: 14,
                            fontWeight: 400,
                          ),
                    const SizedBox(
                      height: 12,
                    ),
                    const DesignText(
                      'Education Profession :',
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    FreeKundlyController.to.basicDataRes['report']?['education_profession'].runtimeType == List
                        ? Column(
                            children: List.generate(
                                (FreeKundlyController.to.basicDataRes['report']?['education_profession'] ?? []).length,
                                (index) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      child: DesignText(
                                        FreeKundlyController.to.basicDataRes['report']?['education_profession']?[index] ?? 'N/A',
                                        fontSize: 14,
                                        fontWeight: 400,
                                      ),
                                    )),
                          )
                        : const DesignText(
                            'N/A',
                            fontSize: 14,
                            fontWeight: 400,
                          ),
                    const SizedBox(
                      height: 12,
                    ),
                    const DesignText(
                      'Physical Features :',
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    FreeKundlyController.to.basicDataRes['report']?['physical_features'].runtimeType == List
                        ? Column(
                            children: List.generate(
                                (FreeKundlyController.to.basicDataRes['report']?['physical_features'] ?? []).length,
                                (index) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      child: DesignText(
                                        FreeKundlyController.to.basicDataRes['report']?['physical_features']?[index] ?? 'N/A',
                                        fontSize: 14,
                                        fontWeight: 400,
                                      ),
                                    )),
                          )
                        : const DesignText(
                            'N/A',
                            fontSize: 14,
                            fontWeight: 400,
                          ),
                    const SizedBox(
                      height: 12,
                    ),
                    const DesignText(
                      'Generalised :',
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    FreeKundlyController.to.basicDataRes['report']?['generalised'].runtimeType == List
                        ? Column(
                            children: List.generate(
                                (FreeKundlyController.to.basicDataRes['report']?['generalised'] ?? []).length,
                                (index) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      child: DesignText(
                                        FreeKundlyController.to.basicDataRes['report']?['physical_features']?[index] ?? 'N/A',
                                        fontSize: 14,
                                        fontWeight: 400,
                                      ),
                                    )),
                          )
                        : const DesignText(
                            'N/A',
                            fontSize: 14,
                            fontWeight: 400,
                          ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              );
      }),
    );
  }
}

///2
class BasicKundli extends StatefulWidget {
  final String name;
  final String date;
  final String day;
  final String month;
  final String year;
  final String hour;
  final String min;
  final String time;
  final String place;
  final String latitude;
  final String longitude;
  const BasicKundli({
    Key? key,
    required this.name,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.min,
    required this.time,
    required this.place,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<BasicKundli> createState() => _BasicKundliState();
}

class _BasicKundliState extends State<BasicKundli> {
  @override
  void initState() {
    // TODO: implement initState
    FreeKundlyController.to.freeKundlyApi(
      params: {
        "day": widget.day,
        "month": widget.month,
        "year": widget.year,
        "hour": widget.hour,
        "min": widget.min,
        "lat": widget.latitude,
        "lon": widget.longitude,
        "tzone": DateTime.now().timeZoneOffset.toString(),
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return FreeKundlyController.to.freeKundlyRes.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.teal,
                ),
              )
            : Table(
                border: TableBorder.all(color: AppColors.prepInk02, borderRadius: BorderRadius.circular(8)),
                children: [
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Date",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        widget.date,
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Time",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        widget.time,
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Place",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        widget.place,
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Latitude",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        widget.latitude,
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Longitude",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        widget.longitude,
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Timezone",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        DateTime.now().timeZoneOffset.toString(),
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Sunrise",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        (FreeKundlyController.to.freeKundlyRes['sunrise'] ?? '-').toString(),
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Sunset",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        (FreeKundlyController.to.freeKundlyRes['sunset'] ?? '-').toString(),
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Ayanamsha",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        (FreeKundlyController.to.freeKundlyRes['ayanamsha'] ?? '-').toString(),
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                ],
              );
      }),
    );
  }
}

///3
class LaganChart extends StatefulWidget {
  final String name;
  final String date;
  final String day;
  final String month;
  final String year;
  final String hour;
  final String min;
  final String time;
  final String place;
  final String latitude;
  final String longitude;
  const LaganChart({
    Key? key,
    required this.name,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.min,
    required this.time,
    required this.place,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<LaganChart> createState() => _LaganChartState();
}

class _LaganChartState extends State<LaganChart> {
  @override
  void initState() {
    // TODO: implement initState
    FreeKundlyController.to.getChartApi(
      params: {
        "day": widget.day,
        "month": widget.month,
        "year": widget.year,
        "hour": widget.hour,
        "min": widget.min,
        "lat": widget.latitude,
        "lon": widget.longitude,
        "tzone": DateTime.now().timeZoneOffset.toString(),
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return FreeKundlyController.to.getChartRes.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.teal,
                ),
              )
            : FreeKundlyController.to.getChartRes.value == ''
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No data Available',
                        style: TextStyle(color: AppColors.blackBackground, fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                : Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.string(FreeKundlyController.to.getChartRes.value),
                  );
      }),
    );
  }
}

///4
class BasicPanchang extends StatefulWidget {
  final String name;
  final String date;
  final String day;
  final String month;
  final String year;
  final String hour;
  final String min;
  final String time;
  final String place;
  final String latitude;
  final String longitude;
  const BasicPanchang({
    Key? key,
    required this.name,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.min,
    required this.time,
    required this.place,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<BasicPanchang> createState() => _BasicPanchangState();
}

class _BasicPanchangState extends State<BasicPanchang> {
  @override
  void initState() {
    // TODO: implement initState
    FreeKundlyController.to.basicPanchangApi(
      params: {
        "day": widget.day,
        "month": widget.month,
        "year": widget.year,
        "hour": widget.hour,
        "min": widget.min,
        "lat": widget.latitude,
        "lon": widget.longitude,
        "tzone": DateTime.now().timeZoneOffset.toString(),
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return FreeKundlyController.to.basicPanchangRes.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.teal,
                ),
              )
            : Table(
                border: TableBorder.all(color: AppColors.prepInk02, borderRadius: BorderRadius.circular(8)),
                children: [
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Date",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        widget.date,
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Time",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        widget.time,
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Day",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.basicPanchangRes['day'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Tithi",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.basicPanchangRes['tithi'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Yog",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.basicPanchangRes['yog'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Nakshatra",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.basicPanchangRes['nakshatra'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Karan",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.basicPanchangRes['karan'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Sunrise",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.basicPanchangRes['sunrise'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Sunset",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.basicPanchangRes['sunset'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                ],
              );
      }),
    );
  }
}

///5

class PlanetsScreen extends StatefulWidget {
  final String name;
  final String date;
  final String day;
  final String month;
  final String year;
  final String hour;
  final String min;
  final String time;
  final String place;
  final String latitude;
  final String longitude;
  const PlanetsScreen({
    Key? key,
    required this.name,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.min,
    required this.time,
    required this.place,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<PlanetsScreen> createState() => _PlanetsScreenState();
}

class _PlanetsScreenState extends State<PlanetsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    FreeKundlyController.to.kpPlanetsApi(
      params: {
        "day": widget.day,
        "month": widget.month,
        "year": widget.year,
        "hour": widget.hour,
        "min": widget.min,
        "lat": widget.latitude,
        "lon": widget.longitude,
        "tzone": DateTime.now().timeZoneOffset.toString(),
      },
    );
    FreeKundlyController.to.kpPlanetsCurpsApi(
      params: {
        "day": widget.day,
        "month": widget.month,
        "year": widget.year,
        "hour": widget.hour,
        "min": widget.min,
        "lat": widget.latitude,
        "lon": widget.longitude,
        "tzone": DateTime.now().timeZoneOffset.toString(),
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return FreeKundlyController.to.kpPlanetsRes.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.teal,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const DesignText(
                      'Planets :',
                      fontSize: 16,
                      fontWeight: 500,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Table(
                      border: TableBorder.all(color: AppColors.prepInk02, borderRadius: BorderRadius.circular(8)),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FlexColumnWidth(1.7),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(1),
                        4: FlexColumnWidth(1),
                        5: FlexColumnWidth(1),
                      },
                      children: [
                            const TableRow(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  "Planet",
                                  style: TextStyle(
                                    color: AppColors.blackBackground,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'House',
                                  style: TextStyle(
                                    color: AppColors.blackBackground,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Sign',
                                  style: TextStyle(
                                    color: AppColors.blackBackground,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Sign Lord',
                                  style: TextStyle(
                                    color: AppColors.blackBackground,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Star Lord',
                                  style: TextStyle(
                                    color: AppColors.blackBackground,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Sub Lord',
                                  style: TextStyle(
                                    color: AppColors.blackBackground,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ])
                          ] +
                          List.generate(
                            FreeKundlyController.to.kpPlanetsRes.length,
                            (index) => TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  FreeKundlyController.to.kpPlanetsRes[index]['planet_name'],
                                  style: const TextStyle(color: AppColors.blackBackground, fontSize: 14, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  '${FreeKundlyController.to.kpPlanetsRes[index]['house']}',
                                  style: const TextStyle(color: AppColors.blackBackground, fontSize: 14, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  FreeKundlyController.to.kpPlanetsRes[index]['sign'],
                                  style: const TextStyle(color: AppColors.blackBackground, fontSize: 14, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  FreeKundlyController.to.kpPlanetsRes[index]['sign_lord'].toString().toUpperCase().substring(0, 2),
                                  style: const TextStyle(color: AppColors.blackBackground, fontSize: 14, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  FreeKundlyController.to.kpPlanetsRes[index]['nakshatra_lord'].toString().toUpperCase().substring(0, 2),
                                  style: const TextStyle(color: AppColors.blackBackground, fontSize: 14, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  FreeKundlyController.to.kpPlanetsRes[index]['sub_lord'].toString().toUpperCase().substring(0, 2),
                                  style: const TextStyle(color: AppColors.blackBackground, fontSize: 14, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]),
                          ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const DesignText(
                      'Cusps :',
                      fontSize: 16,
                      fontWeight: 500,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Table(
                      border: TableBorder.all(color: AppColors.prepInk02, borderRadius: BorderRadius.circular(8)),
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FlexColumnWidth(1.7),
                      },
                      children: [
                            const TableRow(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  "Sign",
                                  style: TextStyle(
                                    color: AppColors.blackBackground,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Degree',
                                  style: TextStyle(
                                    color: AppColors.blackBackground,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Sign Lord',
                                  style: TextStyle(
                                    color: AppColors.blackBackground,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Star Lord',
                                  style: TextStyle(
                                    color: AppColors.blackBackground,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Sub Lord',
                                  style: TextStyle(
                                    color: AppColors.blackBackground,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ])
                          ] +
                          List.generate(
                            FreeKundlyController.to.kpPlanetsCurpsRes.length,
                            (index) => TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  FreeKundlyController.to.kpPlanetsCurpsRes[index]['sign'],
                                  style: const TextStyle(color: AppColors.blackBackground, fontSize: 14, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  double.parse('${FreeKundlyController.to.kpPlanetsCurpsRes[index]['cusp_full_degree']}').toStringAsFixed(2),
                                  style: const TextStyle(color: AppColors.blackBackground, fontSize: 14, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  FreeKundlyController.to.kpPlanetsCurpsRes[index]['sign_lord'].toString().toUpperCase().substring(0, 2),
                                  style: const TextStyle(color: AppColors.blackBackground, fontSize: 14, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  FreeKundlyController.to.kpPlanetsCurpsRes[index]['nakshatra_lord'].toString().toUpperCase().substring(0, 2),
                                  style: const TextStyle(color: AppColors.blackBackground, fontSize: 14, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  FreeKundlyController.to.kpPlanetsCurpsRes[index]['sub_lord'].toString().toUpperCase().substring(0, 2),
                                  style: const TextStyle(color: AppColors.blackBackground, fontSize: 14, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]),
                          ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
/*
///6
class GhatChakra extends StatefulWidget {
  final String name;
  final String date;
  final String day;
  final String month;
  final String year;
  final String hour;
  final String min;
  final String time;
  final String place;
  final String latitude;
  final String longitude;
  const GhatChakra({
    Key? key,
    required this.name,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.min,
    required this.time,
    required this.place,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<GhatChakra> createState() => _GhatChakraState();
}

class _GhatChakraState extends State<GhatChakra> {
  @override
  void initState() {
    // TODO: implement initState
    FreeKundlyController.to.ghatChakraApi(
      params: {
        "day": widget.day,
        "month": widget.month,
        "year": widget.year,
        "hour": widget.hour,
        "min": widget.min,
        "lat": widget.latitude,
        "lon": widget.longitude,
        "tzone": DateTime.now().timeZoneOffset.toString(),
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return FreeKundlyController.to.ghatChakraRes.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.teal,
                ),
              )
            : Table(
                border: TableBorder.all(color: AppColors.prepInk02, borderRadius: BorderRadius.circular(8)),
                children: [
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Month",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.ghatChakraRes['month'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Tithi",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.ghatChakraRes['tithi'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Day",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.ghatChakraRes['day'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Nakshatra",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.ghatChakraRes['nakshatra'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Yog",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.ghatChakraRes['yog'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Karan",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.ghatChakraRes['karan'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Pahar",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.ghatChakraRes['pahar'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Moon",
                        style: TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        FreeKundlyController.to.ghatChakraRes['moon'] ?? '-',
                        style: const TextStyle(
                          color: AppColors.blackBackground,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                ],
              );
      }),
    );
  }
}

///7
class MajorDasha extends StatefulWidget {
  final String name;
  final String date;
  final String day;
  final String month;
  final String year;
  final String hour;
  final String min;
  final String time;
  final String place;
  final String latitude;
  final String longitude;
  const MajorDasha({
    Key? key,
    required this.name,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.min,
    required this.time,
    required this.place,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<MajorDasha> createState() => _MajorDashaState();
}

class _MajorDashaState extends State<MajorDasha> {
  @override
  void initState() {
    // TODO: implement initState
    FreeKundlyController.to.majorDashaApi(
      params: {
        "day": widget.day,
        "month": widget.month,
        "year": widget.year,
        "hour": widget.hour,
        "min": widget.min,
        "lat": widget.latitude,
        "lon": widget.longitude,
        "tzone": DateTime.now().timeZoneOffset.toString(),
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return FreeKundlyController.to.majorDashaRes.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.teal,
                ),
              )
            : Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FlexColumnWidth(1.25),
                  1: FlexColumnWidth(0.9),
                },
                border: TableBorder.all(color: AppColors.prepInk02, borderRadius: BorderRadius.circular(8)),
                children: [
                      const TableRow(children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "Sign",
                            style: TextStyle(
                              color: AppColors.blackBackground,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'Duration',
                            style: TextStyle(
                              color: AppColors.blackBackground,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'Start Date',
                            style: TextStyle(
                              color: AppColors.blackBackground,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'End Date',
                            style: TextStyle(
                              color: AppColors.blackBackground,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                    ] +
                    List.generate(
                      FreeKundlyController.to.majorDashaRes.length,
                      (index) => TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            FreeKundlyController.to.majorDashaRes[index]?['sign_name'] ?? '-',
                            style: const TextStyle(
                              color: AppColors.blackBackground,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            FreeKundlyController.to.majorDashaRes[index]?['duration'] ?? '-',
                            style: const TextStyle(
                              color: AppColors.blackBackground,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            FreeKundlyController.to.majorDashaRes[index]?['start_date'] ?? '-',
                            style: const TextStyle(
                              color: AppColors.blackBackground,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            FreeKundlyController.to.majorDashaRes[index]?['end_date'] ?? '-',
                            style: const TextStyle(
                              color: AppColors.blackBackground,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                    ),
              );
      }),
    );
  }
}

///8

class SadheSatiScreen extends StatefulWidget {
  final String name;
  final String date;
  final String day;
  final String month;
  final String year;
  final String hour;
  final String min;
  final String time;
  final String place;
  final String latitude;
  final String longitude;
  const SadheSatiScreen({
    Key? key,
    required this.name,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.min,
    required this.time,
    required this.place,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<SadheSatiScreen> createState() => _SadheSatiScreenState();
}

class _SadheSatiScreenState extends State<SadheSatiScreen> {
  @override
  void initState() {
    // TODO: implement initState
    FreeKundlyController.to.sadheSatiApi(
      params: {
        "day": widget.day,
        "month": widget.month,
        "year": widget.year,
        "hour": widget.hour,
        "min": widget.min,
        "lat": widget.latitude,
        "lon": widget.longitude,
        "tzone": DateTime.now().timeZoneOffset.toString(),
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (FreeKundlyController.to.sadheSatiRes.isEmpty) {
          return const Center(
            child: CupertinoActivityIndicator(
              color: AppColors.teal,
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                const DesignText(
                  'Sadhe Sati Report :',
                  fontSize: 16,
                  fontWeight: 500,
                ),
                const SizedBox(
                  height: 12,
                ),
                Table(
                  border: TableBorder.all(color: AppColors.prepInk02, borderRadius: BorderRadius.circular(8)),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Consideration Date",
                          style: TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          FreeKundlyController.to.sadheSatiRes['consideration_date'] ?? '-',
                          style: const TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Saturn Retrograde",
                          style: TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          (FreeKundlyController.to.sadheSatiRes['is_saturn_retrograde'] ?? false) ? 'Yes' : 'No',
                          style: const TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Moon Sign",
                          style: TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          FreeKundlyController.to.sadheSatiRes['moon_sign'] ?? '-',
                          style: const TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Saturn Sign",
                          style: TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          FreeKundlyController.to.sadheSatiRes['saturn_sign'] ?? '-',
                          style: const TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Undergoing Sadhesati",
                          style: TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          FreeKundlyController.to.sadheSatiRes['is_undergoing_sadhesati'] ?? '-',
                          style: const TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Sadhesati Status",
                          style: TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          (FreeKundlyController.to.sadheSatiRes['sadhesati_status'] ?? false) ? 'Yes' : 'No',
                          style: const TextStyle(
                            color: AppColors.blackBackground,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const DesignText(
                  'What Is Sadhesati ?',
                  fontSize: 16,
                  fontWeight: 500,
                ),
                const SizedBox(
                  height: 12,
                ),
                DesignText(
                  FreeKundlyController.to.sadheSatiRes['what_is_sadhesati'] ?? 'N/A',
                  fontSize: 14,
                  fontWeight: 400,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}*/
