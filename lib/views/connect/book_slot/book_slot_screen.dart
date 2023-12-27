import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/views/wallet/payment_information.dart';

class BookSlotScreen extends StatefulWidget {
  final String type;
  const BookSlotScreen(
      {super.key, required this.astrologerProfile, required this.type});

  final Map astrologerProfile;
  @override
  State<BookSlotScreen> createState() => _BookSlotScreenState();
}

class _BookSlotScreenState extends State<BookSlotScreen> {
  String? selectSlot;
  String? selecttime = '20 Min';
  String? selectDate;

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
                Get.to(() => const PaymentInformation(
                      isCashBack: false,
                      amount: "0",
                    ));
                Get.dialog(Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        children: [
                          const Opacity(
                            opacity: 0,
                            child: IconButton(
                              onPressed: null,
                              icon: Icon(Icons.close),
                              color: AppColors.blackBackground,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          const Expanded(
                            child: DesignText(
                              'Thankyou',
                              fontSize: 18,
                              fontWeight: 600,
                              color: AppColors.gold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.close),
                            color: AppColors.blackBackground,
                            padding: EdgeInsets.zero,
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: DesignText(
                          'We will notify you for your consulation',
                          fontSize: 16,
                          fontWeight: 400,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ]),
                  ),
                ));
              },
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              label: const DesignText(
                "Book Slot",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.green),
                            borderRadius: BorderRadius.circular(
                                60), // assuming height/width is 83
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              'https://thetaramandal.com/public/astrologer/${widget.astrologerProfile['photo']}',
                              // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzHQv_th9wq3ivQ1CVk7UZRxhbPq64oQrg5Q&usqp=CAU',
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
                            '${widget.astrologerProfile['name']}',
                            fontSize: 14,
                            fontWeight: 600,
                          ),
                          DesignText(
                            'Language Known: Hindi, English',
                            fontSize: 12,
                            fontWeight: 500,
                            color: AppColors.lightGrey1,
                          ),
                          DesignText(
                            'Experience: ${'${widget.astrologerProfile['experience'] ?? '0'} Years'}',
                            fontSize: 12,
                            fontWeight: 500,
                            color: AppColors.lightGrey1,
                          ),
                          DesignText(
                            'Rs.${widget.astrologerProfile['call_price'] ?? 0}/Min',
                            fontSize: 14,
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
              SizedBox(
                height: 30,
                child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: DesignContainer(
                        borderAllColor: AppColors.gold,
                        bordered: true,
                        allPadding: 6,
                        alignment: Alignment.center,
                        child: DesignText(
                          'Tarot',
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
                "'In the world of gems and crystal healing lore, chrysoberyl cat's eye can be a stone of discipline and self-control, thought to increase concentration and learning ability, whilst enhancing the desire for excellence. Chrysoberyl cat's eye can also help increase self-confidence and bring peace of mind, as well as enhance creativity, imagination and intuition.'",
                fontSize: 11,
                fontWeight: 400,
              ),
              const SizedBox(height: 20),
              const DesignText(
                'Available Slots',
                fontSize: 16,
                fontWeight: 600,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16

                          setState(() {
                            selectDate = formattedDate.toString();
                          });
                          TimeOfDay? pickedtime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedtime != null) {
                            setState(() {
                              selectSlot =
                                  pickedtime.format(context).toString();
                            });
                          } else {}
                        } else {}
                      },
                      child: DesignContainer(
                        borderAllColor: AppColors.lightGrey1,
                        bordered: true,
                        allPadding: 3,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              selectDate == null
                                  ? DesignText('Select Date',
                                      color: AppColors.lightGrey1,
                                      fontSize: 14,
                                      fontWeight: 400)
                                  : DesignText(selectDate!,
                                      color: AppColors.blackBackground,
                                      fontSize: 14,
                                      fontWeight: 400),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        /*DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16

                          setState(() {
                            selectDate = formattedDate.toString();
                          });
                          TimeOfDay? pickedtime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedtime != null) {
                            setState(() {
                              selectSlot =
                                  pickedtime.format(context).toString();
                            });
                          } else {}
                        } else {}*/
                      },
                      child: DesignContainer(
                        borderAllColor: AppColors.lightGrey1,
                        bordered: true,
                        allPadding: 3,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              selectSlot == null
                                  ? DesignText('Select Slot',
                                      color: AppColors.lightGrey1,
                                      fontSize: 14,
                                      fontWeight: 400)
                                  : DesignText(selectSlot!,
                                      color: AppColors.blackBackground,
                                      fontSize: 14,
                                      fontWeight: 400),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  /* Expanded(
                      child: DesignContainer(
                    borderAllColor: AppColors.lightGrey1,
                    bordered: true,
                    allPadding: 3,
                    alignment: Alignment.center,
                    child: DropdownButton<String>(
                      // Initial Value
                      value: selectSlot, isExpanded: true,
                      borderRadius: BorderRadius.circular(12),
                      hint: DesignText('Select Slot',
                          color: AppColors.lightGrey1,
                          fontSize: 14,
                          fontWeight: 400),

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      underline: const SizedBox(),
                      // Array list of items
                      items: [
                        '9:00 - 9:30',
                        '9:30 - 10:00',
                      ].map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          selectSlot = newValue!;
                        });
                      },
                    ),
                  )),*/
                ],
              ),
              const SizedBox(height: 10),
              DesignContainer(
                borderAllColor: AppColors.lightGrey1,
                bordered: true,
                allPadding: 3,
                alignment: Alignment.center,
                child: DropdownButton<String>(
                  // Initial Value
                  value: selecttime, isExpanded: true,
                  borderRadius: BorderRadius.circular(12),
                  hint: DesignText('Select Slot',
                      color: AppColors.lightGrey1,
                      fontSize: 14,
                      fontWeight: 400),

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  underline: const SizedBox(),
                  // Array list of items
                  items: [
                    '20 Min',
                    '40 Min',
                  ].map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      selecttime = newValue!;
                    });
                  },
                ),
              ),
              // HtmlWidget(
              //   widget.astrologerModel.longbio!,
              //   textStyle: const TextStyle(
              //     fontSize: 11,
              //     fontWeight: FontWeight.w400,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),
              /*const SizedBox(height: 20),
              const DesignText(
                'Customer Reviews',
                fontSize: 16,
                fontWeight: 600,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        child: ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: DesignText('⭐'),
                          ),
                        ),
                      ),
                      const DesignText(
                        'Good Stone',
                        fontSize: 11,
                        fontWeight: 400,
                      ),
                    ],
                  ),
                  const DesignText(
                    'Nov 2020',
                    fontSize: 10,
                    fontWeight: 500,
                    color: AppColors.lightGrey2,
                  ),
                ],
              ),*/
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
