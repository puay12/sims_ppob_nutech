import 'package:flutter/material.dart';
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;

class HomePage extends StatefulWidget {

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String profile;
  late int inquiry;
  late String service;
  late String banner;

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
        SizedBox(height: 32),
        _buildSalutation(),
        SizedBox(height: 32),
        // _buildInquiryBox(context),
        SizedBox(height: 24),
        // _buildServices(context),
        SizedBox(height: 24),
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
          Text(
            "Muhammad Al Fatih",
            style: appTypo.bodyTitle,
          )
        ],
      ),
    );
  }

  _buildInquiryBox(BuildContext context) {}

  _buildServices(BuildContext context) {}

  _buildBanners(BuildContext context) {}
}
