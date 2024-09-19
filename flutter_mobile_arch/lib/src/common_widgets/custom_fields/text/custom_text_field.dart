import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_configs/app_colors.dart';
import 'custom_text_field_provider.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final Function(String?) onSaved;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputAction textInputAction;
  final String? initialValue;
  final bool isDarkThemed;
  final Widget? suffix;
  final bool? enabled;
  final Color? passIconColor;
  final GlobalKey<CustomTextFieldState>? fieldKey;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.onSaved,
    this.onChanged,
    this.isDarkThemed = false,
    this.suffix,
    this.validator,
    this.isPassword = false,
    this.textInputAction = TextInputAction.next,
    this.initialValue,
    this.enabled,
    this.passIconColor,
    this.fieldKey,
    this.maxLines = 1, // Default value of maxLines is set to 1
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void clearText() {
    _controller.clear();
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomTextFieldProvider(
        initialValue: widget.initialValue,
        onValueChanged: widget.onChanged,
      ),
      child: Consumer<CustomTextFieldProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _controller,
                textInputAction: widget.textInputAction,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: widget.validator,
                enabled: widget.enabled ?? true,
                obscureText: widget.isPassword && !_isPasswordVisible,
                onChanged: (value) {
                  provider.onChanged(value);
                  widget.onChanged?.call(value);
                },
                onSaved: widget.onSaved,
                maxLines: widget.maxLines, // Use the maxLines parameter here
                decoration: InputDecoration(
                  errorMaxLines: 2,
                  filled: true,
                  fillColor: widget.isDarkThemed
                      ?  AppColors.darkgreyBackgroundColor
                      : Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: widget.isDarkThemed
                        ? BorderRadius.circular(8.0)
                        : BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: widget.isDarkThemed
                          ? Colors.transparent
                          : AppColors.outlineBorderColor,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: AppColors.outlineBorderColor,
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                  suffixIcon: widget.suffix ??
                      (widget.isPassword
                          ? GestureDetector(
                              onTap: togglePasswordVisibility,
                              child: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: widget.passIconColor ??
                                    AppColors.secondaryTextColor,
                              ),
                            )
                          : null),
                  hintText: widget.labelText,
                  hintStyle:
                      const TextStyle(color: AppColors.secondaryTextColor),
                ),
                style: TextStyle(
                    color: widget.isDarkThemed
                        ? Colors.white
                        : AppColors.secondaryTextColor),
              ),
            ],
          );
        },
      ),
    );
  }
}
