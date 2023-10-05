import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/views/home_controller.dart';
import 'package:rashi_network/views/kundali/premium_kundali/ask_question.dart';

import 'conformation_screen.dart';

class AstroDocumentsUpload extends StatefulWidget {
  const AstroDocumentsUpload({super.key});

  @override
  State<AstroDocumentsUpload> createState() => _AstroDocumentsUploadState();
}

class _AstroDocumentsUploadState extends State<AstroDocumentsUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Upload Documents',
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
          height: 48,
          width: double.infinity,
          child: FloatingActionButton.extended(
            backgroundColor: AppColors.darkTeal,
            onPressed: () {
              Get.to(() => const ConformationScreen());
            },
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            label: const DesignText(
              "Continue",
              color: Colors.white,
              fontSize: 14,
              fontWeight: 600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Get.to(() => const ConformationScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: const DesignText(
                    'Skip',
                    fontSize: 12,
                    fontWeight: 400,
                    color: AppColors.lightGrey1,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('UPLOAD DOC');
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Container(
                height: 228,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: AppColors.lightGrey1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.upload,
                      color: AppColors.lightGrey1,
                    ),
                    const DesignText(
                      'Upload all your documents in one pdf',
                      color: AppColors.lightGrey1,
                      fontSize: 14,
                      fontWeight: 500,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const DesignText(
              'Uploaded Files',
              fontSize: 16,
              fontWeight: 500,
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.description_outlined),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DesignText(
                        '50%',
                        fontSize: 12,
                        fontWeight: 500,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 5,
                        child: LinearProgressIndicator(color: AppColors.green),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
