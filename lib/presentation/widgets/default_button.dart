import 'package:flutter/material.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;

class DefaultButton extends StatelessWidget {
  String label;
  Function() buttonAction;

  DefaultButton({
    Key? key,
    required this.label,
    required this.buttonAction
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
        ),
        onPressed: buttonAction,
        child: Text(
          label,
          style: appTypo.bodyWhite
        )
      )
    );
  }
}
