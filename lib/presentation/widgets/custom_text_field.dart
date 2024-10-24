import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isObsecured,
      style: appTypo.body,
      controller: widget.fieldController,
      keyboardType: widget.inputType,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        prefixIconColor: appColor.textLightGray,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                  onPressed: () {
                    if (widget.type == "password") {
                      _onPasswordTogglePressed();
                    }
                  },
                  icon: widget.suffixIcon!
              )
            : widget.suffixIcon,
        suffixIconColor: appColor.textLightGray,
        labelText: widget.textLabel,
        labelStyle: appTypo.bodyGray,
        hintText: widget.hintText,
        hintStyle: appTypo.bodyGray,
        border: const OutlineInputBorder(borderSide: BorderSide(color: appColor.textLightGray)),
      ),
      cursorColor: appColor.textLightGray,
      autofocus: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${widget.textLabel} tidak boleh kosong";
        } else {
          switch (widget.type) {
            case "email":
              return _validateEmail();
            case "password":
              return _validatePassword();
            case "topup":
              return _validateTopupAmount();
            default:
              return null;
          }
        }
      },
    );
  }

  String? _validateEmail() {
    if (!widget.fieldController.text.contains("@")) {
      return "Email Anda salah";
    } else {
      return null;
    }
  }

  String? _validatePassword() {
    if (widget.fieldController.text.length < 8) {
      return "Password harus minimal 8 karakter";
    } else {
      return null;
    }
  }

  String? _validateTopupAmount() {
    if (int.parse(widget.fieldController.text) < 10000) {
      return "Nominal minimal adalah 10.000";
    } else if (int.parse(widget.fieldController.text) > 100000) {
      return "Nominal maksimal adalah 100.000";
    } else {
      return null;
    }
  }

  _onPasswordTogglePressed() {
    setState(() {
      if (widget.isObsecured) {
        widget.suffixIcon = Icon(Icons.visibility_off);
      } else {
        widget.suffixIcon = Icon(Icons.visibility);
      }

      widget.isObsecured = !widget.isObsecured;
    });
  }
}
