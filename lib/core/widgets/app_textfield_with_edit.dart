import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_manager.dart';
import '../utils/string_manager.dart';
import '../utils/style_manager.dart';

var _borderTextFiled = ({Color color = ColorManager.primaryColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.r),
        borderSide: BorderSide(color: color));

class AppTextFiledWithEdit extends StatelessWidget {
  const AppTextFiledWithEdit({
    super.key,
    this.icon,
    this.hintText,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.onTap, this.onEditTap,
  });

  final IconData? icon;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool readOnly;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      validator: validator ??
              (String? val) {
            if (val!.trim().isEmpty) return StringManager.requiredField;
            return null;
          },
      onChanged: onChanged,
      onTap: onTap,

      textInputAction: textInputAction,
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: ColorManager.primaryColor,
      decoration: InputDecoration(
          focusedBorder: _borderTextFiled(),
          border: _borderTextFiled(color: Colors.transparent),
          enabledBorder: _borderTextFiled(color: Colors.transparent),
          errorBorder: _borderTextFiled(color: ColorManager.errorColor),
          iconColor: ColorManager.grayColor,
          filled: true,
          fillColor: ColorManager.grayColor,
          errorMaxLines: 2,
          suffixIcon: IconButton(
            onPressed: onEditTap,
            icon: Icon(Icons.edit),
          ),
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: StyleManager.font16Regular(
            color: ColorManager.hintTextColor,
          )
      ),
    );
  }
}
