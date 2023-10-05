import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rashi_network/services/api/api_access.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/viewmodel/home_static/home_first_row_model.dart';
import 'package:rashi_network/viewmodel/provider/appstate.dart';
import 'package:rashi_network/views/blogs/view_all_blogs.dart';
import 'package:rashi_network/views/bottom_controller.dart';
import 'package:rashi_network/views/coming_soon_screen.dart';
import 'package:rashi_network/views/kundali/free_kundali/free_kundali.dart';

import '../kundali/free_kundali/enter_details.dart';

class HomeFirstView extends StatelessWidget {
  const HomeFirstView({
    super.key,
    required this.appStateauto,
  });

  final AppState appStateauto;

  @override
  Widget build(BuildContext context) {
    void onTap(int index) {
      switch (index) {
        case 0:
          ApiAccess().liveAstrologer(data: {});
          BottomController.to.selectedIndOfBottom.value = 2;
          break;
        case 1:
          ApiAccess().liveAstrologer(data: {});
          BottomController.to.selectedIndOfBottom.value = 1;
          break;
        case 2:
          Get.to(() => const FreeKundaliEnterDetails() /*const  ComingSoonScreen()*/ /*FreeKundali()*/);
          /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FreeKundali()),
          );*/
          break;
        case 3:
          Get.to(() => const LatestBlogsAllView());
          break;
        default:
          break;
      }
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      shrinkWrap: true,
      itemCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final data = HomeFirstModel.items[index];
        return GestureDetector(
          onTap: () => onTap(index),
          child: Column(
            children: [
              /*   DesignContainer(
                height: 60, width: 60,
                bordered: true,
                blurRadius: 6, borderRadius: BorderRadius.circular(12),
                blurRadiuscolor: DesignColor.darkTeal.withOpacity(0.4),
                // borderAllColor: DesignColor.lightGrey,
                color: DesignColor.darkTeal,
                isColor: true,
                child: data.svg != null
                    ? SvgPicture.asset(
                        data.svg!,
                        color: DesignColor.colorFEEF9F,
                      )
                    : Icon(
                        data.iconData,
                        color: DesignColor.colorFEEF9F,
                      ),
              ),*/
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.asset(data.image, height: 60, width: 60, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 5),
              DesignText(
                data.title,
                fontSize: 12,
                fontWeight: 500,
                textAlign: TextAlign.center,
                color: Colors.black,
              )
            ],
          ),
        );
      },
    );
  }
}
