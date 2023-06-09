import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:two_be_wedd/utils/extensions.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.textInputType,
    this.validator,
    this.isPasswordField = false,
    this.maxLines,
  });

  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool isPasswordField;
  final int? maxLines;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.isPasswordField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: context.textTheme.titleSmall,
      controller: widget.controller,
      obscureText: obscureText,
      validator: widget.validator,
      maxLines: widget.maxLines,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: widget.hint,
        suffixIconColor: context.theme.primaryColor,
        suffixIcon: widget.isPasswordField
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: obscureText
                    ? FaIcon(
                        FontAwesomeIcons.eyeSlash,
                        color: context.colorScheme.primary,
                        size: 20,
                      )
                    : FaIcon(
                        FontAwesomeIcons.eye,
                        color: context.colorScheme.primary,
                        size: 20,
                      ))
            : const SizedBox(),
      ),
    );
  }
}

class ServiceBudgetField extends StatelessWidget {
  const ServiceBudgetField({
    Key? key,
    required this.controller,
    this.validator,
    required this.hint,
  }) : super(key: key);
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: context.textTheme.titleSmall,
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
