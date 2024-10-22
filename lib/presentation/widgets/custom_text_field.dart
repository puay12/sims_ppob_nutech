import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;

class CustomTextField extends StatelessWidget {
  TextEditingController fieldController;
  String textLabel;
  String hintText;
  bool isObsecured;
  TextInputType inputType;
  String type;
  Widget? prefixIcon;
  Widget? suffixIcon;

  CustomTextField({
    Key? key,
    required this.fieldController,
    required this.textLabel,
    required this.hintText,
    required this.isObsecured,
    required this.inputType,
    required this.type,
    this.prefixIcon,
    this.suffixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecured,
      style: appTypo.body,
      controller: fieldController,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: appColor.textLightGray,
        suffixIcon: suffixIcon,
        suffixIconColor: appColor.textLightGray,
        labelText: textLabel,
        labelStyle: appTypo.bodyGray,
        hintText: hintText,
        hintStyle: appTypo.bodyGray,
        border: OutlineInputBorder(),
      ),
      cursorColor: appColor.textDarkGray,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${textLabel} tidak boleh kosong";
        } else {
          switch (type) {
            case "email":
              return _validateEmail();
            case "password":
              return _validatePassword();
            default:
              return "Harap diisi";
          }
        }
        return null;
      },
    );
  }

  String? _validateEmail() {
    if (!fieldController.text.contains("@")) {
      return "Email Anda salah";
    } else {
      return null;
    }
  }

  String? _validatePassword() {
    if (fieldController.text.length < 8) {
      return "Password harus minimal 8 karakter";
    } else {
      return null;
    }
  }
}
