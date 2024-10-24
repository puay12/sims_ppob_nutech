import 'package:flutter/material.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;

class DefaultButton extends StatelessWidget {
  String label;
  Function() buttonAction;
  bool? isDynamic;

  DefaultButton({
    Key? key,
    required this.label,
    required this.buttonAction,
    this.isDynamic
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton (
        style: ElevatedButton.styleFrom(
          backgroundColor: appColor.primaryRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          disabledBackgroundColor: appColor.textLightGray,
        ),
        onPressed: isDynamic != null
            ? isDynamic!
                ? buttonAction
                : null
            : buttonAction,
        child: Text(
          label,
          style: appTypo.bodyWhite
        )
      )
    );
  }
}
