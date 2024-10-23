import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/injection_container.dart';
import 'package:sims_ppob_nutech/presentation/pages/auth/login.dart';
import 'package:sims_ppob_nutech/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/balance_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/banner_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/get_service_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sl<AuthProvider>()),
        ChangeNotifierProvider(create: (context) => sl<UserProvider>()),
        ChangeNotifierProvider(create: (context) => sl<BalanceProvider>()),
        ChangeNotifierProvider(create: (context) => sl<GetServiceProvider>()),
        ChangeNotifierProvider(create: (context) => sl<BannerProvider>())
      ],
      child: MaterialApp(
        title: "SIMS PPOB",
        theme: ThemeData(
          colorSchemeSeed: appColor.primaryRed,
          useMaterial3: true
        ),
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
