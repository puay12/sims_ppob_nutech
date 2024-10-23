import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;
import 'package:sims_ppob_nutech/presentation/provider/balance_provider.dart';
import 'package:sims_ppob_nutech/presentation/widgets/inquiry_card.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            key: _scaffoldKey,
            appBar: _buildAppBar(context),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: _buildBody(context),
            ),
          ),
        )
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: appColor.textPrimary,
        icon: Icon(Icons.arrow_back),
        iconSize: 20,
        splashRadius: 10,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        "Top Up",
        style: appTypo.bodySubtitle,
      ),
      centerTitle: true,
      backgroundColor: null,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildInquiryCard(context),
        SizedBox(height: 16),
        Text(
          "Topup",
          style: appTypo.bodySubtitle,
        ),
        SizedBox(height: 12),
        // _buildTransactionList(context),
      ],
    );
  }

  Widget _buildInquiryCard(BuildContext context) {
    return Consumer<BalanceProvider>(
        builder: (context, state, _) {
          return InquiryCard(
              balance: state.balanceData != null
                  ? state.balanceData.toString()
                  : 0.toString(),
              isWithVisibility: false
          );
        }
    );
  }
}
