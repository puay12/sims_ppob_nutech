import 'package:flutter/material.dart';
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;

class ServiceTile extends StatelessWidget {
  final String imagePath;
  final String textLabel;

  ServiceTile({
    Key? key,
    required this.imagePath,
    required this.textLabel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          imagePath,
          fit: BoxFit.contain,
          width: 30,
          height: 30,
        ),
        Text(
          textLabel,
          style: appTypo.body,
        )
      ],
    );
  }
}
