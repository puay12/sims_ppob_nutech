import 'package:flutter/material.dart';
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            key: _scaffoldKey,
            appBar: null,
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: _buildBody(context),
            ),
          ),
        )
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Text("HOME PAGE", style: appTypo.headerTitle),
    );
  }
}
