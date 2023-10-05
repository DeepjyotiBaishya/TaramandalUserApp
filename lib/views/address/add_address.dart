import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rashi_network/ui/custom/custom_text_form.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/views/cart/payment_confirmation.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Add Address',
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
                Get.back();
                // Get.to(() => const PaymentConfirmation());
              },
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              label: Container(
                margin: const EdgeInsets.only(left: 4),
                child: const DesignText(
                  "Save",
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: 700,
                ),
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DesignText(
                'Contact Details',
                fontSize: 16,
                fontWeight: 600,
              ),
              const SizedBox(height: 12),
              DesignFormField(
                controller: TextEditingController(),
                hintText: 'Enter Name*',
              ),
              const SizedBox(height: 10),
              DesignFormField(
                controller: TextEditingController(),
                hintText: 'Enter Mobile Number*',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              DesignFormField(
                controller: TextEditingController(),
                hintText: 'Enter Email*',
              ),
              const SizedBox(height: 12),
              const DesignText(
                'Address ',
                fontSize: 16,
                fontWeight: 600,
              ),
              const SizedBox(height: 12),
              DesignFormField(
                controller: TextEditingController(),
                hintText: 'Enter Flat number*',
              ),
              const SizedBox(height: 10),
              DesignFormField(
                controller: TextEditingController(),
                hintText: 'Enter Street name*',
              ),
              const SizedBox(height: 10),
              DesignFormField(
                controller: TextEditingController(),
                hintText: 'Enter pin code*',
              ),
              const SizedBox(height: 10),
              DesignFormField(
                controller: TextEditingController(),
                hintText: 'Enter Locality/Town*',
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DesignFormField(
                      controller: TextEditingController(),
                      hintText: 'City',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DesignFormField(
                      controller: TextEditingController(),
                      hintText: 'State',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
