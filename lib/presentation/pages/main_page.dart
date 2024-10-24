import 'package:flutter/material.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;
import 'package:sims_ppob_nutech/presentation/pages/home_page.dart';
import 'package:sims_ppob_nutech/presentation/pages/profile_page.dart';
import 'package:sims_ppob_nutech/presentation/pages/topup_page.dart';
import 'package:sims_ppob_nutech/presentation/pages/transaction_history_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static final List<Widget> _screens = [
    const HomePage(),
    TopUpPage(),
    const TransactionHistoryPage(),
    const ProfilePage()
  ];

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = 0;
    });
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
                child: _screens.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: _buildBottomNav(context)
          ),
        )
    );
  }

  _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      selectedIconTheme: const IconThemeData(color: appColor.textPrimary, size: 24),
      selectedItemColor: appColor.textPrimary,
      selectedLabelStyle: appTypo.bodySubtitle.copyWith(fontSize: 10),
      unselectedIconTheme: const IconThemeData(
          color: appColor.textLightGray,
          size: 20
      ),
      unselectedItemColor: appColor.textLightGray,
      showUnselectedLabels: true,
      unselectedLabelStyle: appTypo.bodySubtitle.copyWith(fontSize: 10),
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_card),
          label: 'Top Up',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money_outlined),
          label: 'Transaksi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Akun',
        ),
      ],
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
