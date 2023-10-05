import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rashi_network/utils/design_colors.dart';

class DesignFormField extends StatelessWidget {
  DesignFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.keyboardType,
      this.maxLines,
      this.minLines,
      this.enabled,
      this.maxLength,
      this.readOnly = false,
      this.prefix,
      this.validator,
      this.onTap,
      this.inputFormatters,
      this.onChanged});
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool readOnly;
  final bool? enabled;
  final Widget? prefix;
  FormFieldValidator? validator;
  GestureTapCallback? onTap;
  List<TextInputFormatter>? inputFormatters;
  ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      enabled: enabled,
      controller: controller,
      validator: validator,
      onTapOutside: (event) {
        final currentFocus = FocusScope.of(context);
        if (currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      onChanged:onChanged ,
      inputFormatters: inputFormatters,
      onTap: onTap,
      cursorColor: AppColors.blackBackground,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        isDense: true, prefixIcon: prefix,
        fillColor: Colors.transparent,
        // hintStyle: TextStyle(color: DesignColor.darkGrey),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: const EdgeInsets.all(16),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.darkGrey, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey3, width: 1.0),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey3, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.tapRed, width: 2.0),
        ),
      ),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
    );
  }
}
