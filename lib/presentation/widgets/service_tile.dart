import 'package:flutter/material.dart';
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;

class ServiceTile extends StatefulWidget {
  final String imagePath;
  final String textLabel;

  ServiceTile({
    Key? key,
    required this.imagePath,
    required this.textLabel
  }) : super(key: key);

  @override
  State<ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  List<String> labels = [];

  @override
  void initState() {
    if (widget.textLabel.contains(" ")) {
      setState(() {
        labels = widget.textLabel.split(" ");
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            widget.imagePath,
            fit: BoxFit.cover,
            width: 32,
            height: 32,
          ),
          Text(
            widget.textLabel.contains(" ")
                ? widget.textLabel.split(" ")[0]
                : widget.textLabel,
            style: appTypo.bodySmall,
          )
          // labels.isNotEmpty
          //     ? Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Text(
          //             labels[0],
          //             style: appTypo.bodySmall,
          //           ),
          //           Text(
          //             labels[1],
          //             style: appTypo.bodySmall,
          //           ),
          //         ],
          //       )
          //     : Text(
          //         widget.textLabel,
          //         style: appTypo.bodySmall,
          //       )
        ],
      ),
    );
  }
}
