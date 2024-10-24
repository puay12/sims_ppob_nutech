import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;
import 'package:sims_ppob_nutech/presentation/pages/auth/registration.dart';
import 'package:sims_ppob_nutech/presentation/pages/main_page.dart';
import 'package:sims_ppob_nutech/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_nutech/presentation/widgets/custom_text_field.dart';
import 'package:sims_ppob_nutech/presentation/widgets/default_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            key: _scaffoldKey,
            appBar: null,
            body: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: _buildBody(context),
              ),
            ),
          ),
        )
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(context),
        SizedBox(height: 24),
        _buildHeader(),
        SizedBox(height: 32),
        _buildFormGroup(context),
        SizedBox(height: 32),
        DefaultButton(label: "Masuk", buttonAction: () => _submitForm(context)),
        SizedBox(height: 24),
        _buildRegistDirection(context)
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
          width: 28,
          height: 28,
        ),
        SizedBox(width: 6),
        Flexible(
            child: Text(
              "SIMS PPOB",
              style: appTypo.headerTitle,
              softWrap: true,
            )
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Text(
      "Masuk atau Buat Akun untuk Memulai",
      style: appTypo.headerTitleBigger,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFormGroup(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            fieldController: _emailController,
            textLabel: "Email",
            hintText: "Masukkan email Anda",
            inputType: TextInputType.emailAddress,
            type: "email",
            isObsecured: false,
            prefixIcon: Icon(Icons.alternate_email),
          ),
          SizedBox(height: 12),
          CustomTextField(
            fieldController: _passwordController,
            textLabel: "Password",
            hintText: "Masukkan password Anda",
            inputType: TextInputType.visiblePassword,
            type: "password",
            prefixIcon: Icon(Icons.lock_outline),
            suffixIcon: Icon(Icons.visibility),
            isObsecured: true,
          )
        ],
      ),
    );
  }

  Widget _buildRegistDirection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Belum punya akun? Registrasi",
          style: appTypo.bodyGray,
        ),
        TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage())),
            child: Text(
              "disini",
              style: appTypo.bodyRed,
            )
        )
      ],
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    final AuthProvider provider = context.read<AuthProvider>();
    final ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);

    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        },
        barrierDismissible: false
      );

      final result = await provider.login(_emailController.text, _passwordController.text);

      if (result) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage()
            ),
            ModalRoute.withName("/home")
        );
      } else {
        Navigator.of(context).pop();
        scaffoldMessengerState.showSnackBar(SnackBar(content: Text(provider.message, style: appTypo.bodyWhite,)));
      }
    }
  }
}