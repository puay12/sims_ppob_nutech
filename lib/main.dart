import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart';
import 'package:sims_ppob_nutech/injection_container.dart';
import 'package:sims_ppob_nutech/presentation/pages/auth/login.dart';
import 'package:sims_ppob_nutech/presentation/provider/auth_provider.dart';

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
        ChangeNotifierProvider(create: (context) => sl<AuthProvider>())
      ],
      child: MaterialApp(
        title: "SIMS PPOB",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryRed),
          useMaterial3: true
        ),
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
