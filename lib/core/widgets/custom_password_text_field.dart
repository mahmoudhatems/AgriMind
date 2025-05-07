import 'package:flutter/material.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/widgets/custom_text_form_field.dart';

class PasswordCustomTextFormField extends StatefulWidget {
  const PasswordCustomTextFormField({
    super.key,
    this.onSaved,
  });
  final void Function(String?)? onSaved;

  @override
  State<PasswordCustomTextFormField> createState() =>
      _PasswordCustomTextFormFieldState();
}

class _PasswordCustomTextFormFieldState
    extends State<PasswordCustomTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onSaved: widget.onSaved,
      obscureText: obscureText,
      hintText: 'Password',
      keyboardType: TextInputType.visiblePassword,
      suffexIcon: GestureDetector(
        onTap: () {
          obscureText = !obscureText;
          setState(() {});
        },
        child: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          color: ColorsManager.textIconColor,
        ),
      ),
    );
  }
}
