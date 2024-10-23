import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;
import 'package:sims_ppob_nutech/domain/entities/balance_response_entity.dart';
import 'package:sims_ppob_nutech/domain/entities/banner_response_entity.dart';
import 'package:sims_ppob_nutech/domain/entities/service_response_entity.dart';
import 'package:sims_ppob_nutech/domain/entities/user_response_entity.dart';
import 'package:sims_ppob_nutech/presentation/provider/balance_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/banner_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/get_service_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/user_provider.dart';
import 'package:sims_ppob_nutech/presentation/widgets/service_tile.dart';

class HomePage extends StatefulWidget {

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);
  late UserResponseEntity user;
  late BalanceResponseEntity inquiry;
  late ServiceResponseEntity service;
  late BannerResponseEntity banner;
  late bool isVisible;
  late Widget visibilityIcon;

  Future<void> getData() async {
    final BalanceProvider balanceProvider = context.read<BalanceProvider>();
    final UserProvider userProvider = context.read<UserProvider>();
    final GetServiceProvider serviceProvider = context.read<GetServiceProvider>();
    final BannerProvider bannerProvider = context.read<BannerProvider>();

    user = await userProvider.getProfile();
    inquiry = await balanceProvider.getInquiryBalance();
    service = await serviceProvider.getServices();
    banner = await bannerProvider.getBanners();

    if (inquiry.data == null) {
      scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(balanceProvider.message, style: appTypo.bodyWhite,)));
    }
    if (user.data == null) {
      scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(userProvider.message, style: appTypo.bodyWhite,)));
    }
    if (service.data == null) {
      scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(serviceProvider.message, style: appTypo.bodyWhite,)));
    }
    if (banner.data == null) {
      scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(bannerProvider.message, style: appTypo.bodyWhite,)));
    }
  }

  @override
  void initState() {
    setState(() {
      visibilityIcon = Icon(Icons.visibility);
      isVisible = false;
    });
    getData();
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
        SizedBox(height: 16),
        _buildServices(context),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Temukan Promo Menarik",
            style: appTypo.body.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
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
                  ? Text(
                      ".....",
                      style: appTypo.bodyTitle,
                    )
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
              Consumer<BalanceProvider>(
                builder: (context, state, _) {
                  return Text(
                    isVisible
                        ? state.balanceData.toString()
                        : "************",
                    style: appTypo.headerTitle.copyWith(color: appColor.primaryWhite),
                  );
                },
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
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
          ),
        ],
      ),
    );
  }

  Widget _buildServices(BuildContext context) {
    return Consumer<GetServiceProvider>(
      builder: (context, state, _) {
        return state.isLoading
            ? Center(child: CircularProgressIndicator())
            : state.serviceData == null
                ? Center(child: Text("Belum ada layanan tersedia.", style: appTypo.bodySubtitle,))
                : GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 0.0,
                    ),
                    itemCount: state.serviceData?.length, // total number of items
                    itemBuilder: (context, index) {
                      return ServiceTile(
                        imagePath: state.serviceData![index].serviceIcon,
                        textLabel: state.serviceData![index].serviceName,
                      );
                    },
                  );
      },
    );
  }

  Widget _buildBanners(BuildContext context) {
    return Consumer<BannerProvider>(
      builder: (context, state, _) {
        return state.isLoading
            ? Center(child: CircularProgressIndicator())
            : state.bannerData != null
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => _buildBox(state.bannerData![index].bannerImage)
                  )
                : SizedBox(width: double.infinity, child: Text("Belum ada banner.", style: appTypo.body));
      },
    );
  }

  Widget _buildBox(String imageUrl) {
    return Container(
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
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
