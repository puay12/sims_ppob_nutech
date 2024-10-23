import 'package:flutter/material.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;

class InquiryCard extends StatefulWidget {
  final String balance;
  final bool isWithVisibility;

  InquiryCard({
    Key? key,
    required this.balance,
    required this.isWithVisibility
  }) : super(key: key);

  @override
  State<InquiryCard> createState() => _InquiryCardState();
}

class _InquiryCardState extends State<InquiryCard> {
  bool isVisible = false;
  Widget visibilityIcon = Icon(Icons.visibility);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: appColor.cardRed,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: appColor.textLightGray,
              spreadRadius: 1,
              blurRadius: 3
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Saldo Anda",
              style: appTypo.bodyWhite
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "Rp",
                  style: appTypo.headerTitle.copyWith(color: appColor.primaryWhite)
              ),
              SizedBox(width: 8),
              Text(
                widget.isWithVisibility
                  ? isVisible
                      ? widget.balance
                      : "************"
                  : widget.balance,
                style: appTypo.headerTitle.copyWith(color: appColor.primaryWhite),
              )
            ],
          ),
          widget.isWithVisibility
            ? SizedBox(height: 5)
            : const SizedBox.shrink(),
          widget.isWithVisibility
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "Lihat Saldo",
                      style: appTypo.bodyWhite
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _changeVisibility(),
                    icon: visibilityIcon,
                    color: appColor.primaryWhite,
                  )
                ],
              )
            : const SizedBox.shrink(),
        ],
      ),
    );
  }

  _changeVisibility() {
    setState(() {
      if (isVisible) {
        visibilityIcon = Icon(Icons.visibility);
      } else {
        visibilityIcon = Icon(Icons.visibility_off);
      }

      isVisible = !isVisible;
    });
  }
}
