import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);

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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // _buildProfileImage(context),
        SizedBox(height: 24),
        // _buildForm(context),
        SizedBox(height: 24),
        // _buildButtons(context)
      ],
    );
  }
}
