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
    return GestureDetector(
      onTap: () => {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            imagePath,
            fit: BoxFit.cover,
            width: 32,
            height: 32,
          ),
          Text(
            textLabel.contains(" ")
                ? textLabel.split(" ")[0]
                : textLabel,
            style: appTypo.bodySmall,
          )
        ],
      ),
    );
  }
}
