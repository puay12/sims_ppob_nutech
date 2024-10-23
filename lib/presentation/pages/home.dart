import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;
import 'package:sims_ppob_nutech/domain/entities/balance_response_entity.dart';
import 'package:sims_ppob_nutech/domain/entities/user_response_entity.dart';
import 'package:sims_ppob_nutech/presentation/provider/balance_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/user_provider.dart';

class HomePage extends StatefulWidget {

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int balance = 0;
  late ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);
  late UserResponseEntity user;
  late BalanceResponseEntity inquiry;
  late String service;
  late String banner;

  Future<void> getUserName() async {
    final UserProvider provider = context.read<UserProvider>();
    user = await provider.getProfile();

    if (user.data == null) {
      scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(provider.message, style: appTypo.bodyWhite,)));
    }
  }

  Future<void> getInquiryBalance() async {
    final BalanceProvider provider = context.watch<BalanceProvider>();
    inquiry = await provider.getInquiryBalance();

    if (inquiry.data == null) {
      scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(provider.message, style: appTypo.bodyWhite,)));
    } else {
      balance = inquiry.data!.balance;
    }
  }

  @override
  void initState() {
    getUserName();
    getInquiryBalance();
    super.initState();
  }

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildHeader(context),
        SizedBox(height: 20),
        _buildSalutation(),
        SizedBox(height: 16),
        _buildInquiryBox(context),
        SizedBox(height: 12),
        // _buildServices(context),
        SizedBox(height: 12),
        // _buildBanners(context)
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLogo(context),
        _buildProfile()
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/Logo.png',
          fit: BoxFit.contain,
          width: 24,
          height: 24,
        ),
        SizedBox(width: 6),
        Text(
              "SIMS PPOB",
              style: appTypo.body.copyWith(fontWeight: FontWeight.w600),
              softWrap: true,
        )
      ],
    );
  }

  Widget _buildProfile() {
    return IconButton(
      icon: Image.asset(
        'assets/images/profile_photo_1.png',
        fit: BoxFit.cover,
        width: 32,
        height: 32,
      ),
      iconSize: 24,
      onPressed: () {},
    );
  }

  Widget _buildSalutation() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Selamat Datang,",
            style: appTypo.bodySubtitle,
          ),
          SizedBox(height: 6),
          Consumer<UserProvider>(
            builder: (context, state, _) {
              return state.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Text(
                      state.userData != null
                          ? "${state.userData?.firstName} ${state.userData?.lastName}"
                          : "Bapak/Ibu",
                      style: appTypo.bodyTitle,
                    );
            },
          )
        ],
      ),
    );
  }

  Widget _buildInquiryBox(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
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
                "************",
                style: appTypo.headerTitle.copyWith(color: appColor.primaryWhite),
              )
            ],
          )
        ],
      ),
    );
  }

  _buildServices(BuildContext context) {}

  _buildBanners(BuildContext context) {}
}
