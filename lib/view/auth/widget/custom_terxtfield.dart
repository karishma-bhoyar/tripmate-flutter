import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool isPassWord;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.isPassWord = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.focusNode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obsecureText;

  @override
  void initState() {
    super.initState();
    // Initialize the obscure text state using the widget parameter
    _obsecureText = widget.isPassWord;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: _obsecureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      style: AppTextStyles.body.copyWith(fontSize: 15),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.body.copyWith(
          color: AppColors.greyColor.withValues(alpha: 0.7),
          fontSize: 15,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: AppColors.greyColor,
          size: AppSizes.icon22,
        ),
        suffixIcon: widget.isPassWord
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obsecureText = !_obsecureText;
                  });
                },
                icon: Icon(
                  _obsecureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.greyColor,
                  size: AppSizes.icon22,
                ),
              )
            : widget.suffixIcon,
        filled: true,
        fillColor: AppColors.whiteColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.textFieldHorizontalPadding,
          vertical: AppSizes.textFieldVerticalPadding,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius16),
          borderSide: BorderSide(
            color: AppColors.greyColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius16),
          borderSide: BorderSide(
            color: AppColors.greyColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius16),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius16),
          borderSide: const BorderSide(color: AppColors.redColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius16),
          borderSide: const BorderSide(color: AppColors.redColor, width: 2),
        ),
      ),
    );
  }
}
