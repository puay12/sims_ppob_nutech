import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;
import 'package:sims_ppob_nutech/domain/entities/balance_response_entity.dart';
import 'package:sims_ppob_nutech/domain/entities/banner_response_entity.dart';
import 'package:sims_ppob_nutech/domain/entities/service_response_entity.dart';
import 'package:sims_ppob_nutech/domain/entities/user_response_entity.dart';
import 'package:sims_ppob_nutech/presentation/provider/balance_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/banner_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/get_service_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/user_provider.dart';
import 'package:sims_ppob_nutech/presentation/widgets/inquiry_card.dart';
import 'package:sims_ppob_nutech/presentation/widgets/service_tile.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScaffoldMessengerState _scaffoldMessengerState = ScaffoldMessenger.of(context);
  late UserResponseEntity _user;
  late BalanceResponseEntity _inquiry;
  late ServiceResponseEntity _service;
  late BannerResponseEntity _banner;

  Future<void> getData() async {
    final BalanceProvider balanceProvider = context.read<BalanceProvider>();
    final UserProvider userProvider = context.read<UserProvider>();
    final GetServiceProvider serviceProvider = context.read<GetServiceProvider>();
    final BannerProvider bannerProvider = context.read<BannerProvider>();

    _user = await userProvider.getProfile();
    _inquiry = await balanceProvider.getInquiryBalance();
    _service = await serviceProvider.getServices();
    _banner = await bannerProvider.getBanners();

    if (_inquiry.data == null) {
      _scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(balanceProvider.message, style: appTypo.bodyWhite,)));
    }
    if (_user.data == null) {
      _scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(userProvider.message, style: appTypo.bodyWhite,)));
    }
    if (_service.data == null) {
      _scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(serviceProvider.message, style: appTypo.bodyWhite,)));
    }
    if (_banner.data == null) {
      _scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(bannerProvider.message, style: appTypo.bodyWhite,)));
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildHeader(context),
        SizedBox(height: 10),
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
        _buildBanners(context)
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
    return Consumer<BalanceProvider>(
        builder: (context, state, _) {
          return InquiryCard(
              balance: state.balanceData != null
                ? state.balanceData.toString()
                : 0.toString(),
              isWithVisibility: true
          );
        }
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
    return SizedBox(
      height: 120,
      child: Consumer<BannerProvider>(
        builder: (context, state, _) {
          return state.isLoading
              ? Center(child: CircularProgressIndicator())
              : state.bannerData != null
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.bannerData!.length,
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => _buildBox(state.bannerData![index].bannerImage)
                    )
                  : SizedBox(width: double.infinity, child: Text("Belum ada _banner.", style: appTypo.body));
        },
      ),
    );
  }

  Widget _buildBox(String imageUrl) {
    return Container(
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        width: 250,
      ),
    );
  }
}
