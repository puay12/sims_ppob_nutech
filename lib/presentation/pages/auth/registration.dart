import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;
import 'package:sims_ppob_nutech/presentation/pages/auth/login.dart';
import 'package:sims_ppob_nutech/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_nutech/presentation/widgets/custom_text_field.dart';
import 'package:sims_ppob_nutech/presentation/widgets/default_button.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
        DefaultButton(label: "Registrasi", buttonAction: () => _submitForm(context)),
        SizedBox(height: 24),
        _buildLoginDirection(context)
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
      "Lengkapi Data untuk Membuat Akun",
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
            fieldController: _firstNameController,
            textLabel: "Nama Depan",
            hintText: "Masukkan nama depan Anda",
            inputType: TextInputType.text,
            type: "common",
            isObsecured: false,
            prefixIcon: Icon(Icons.person),
          ),
          SizedBox(height: 12),
          CustomTextField(
            fieldController: _lastNameController,
            textLabel: "Nama Belakang",
            hintText: "Masukkan nama belakang Anda",
            inputType: TextInputType.text,
            type: "common",
            isObsecured: false,
            prefixIcon: Icon(Icons.person),
          ),
          SizedBox(height: 12),
          CustomTextField(
            fieldController: _passwordController,
            textLabel: "Password",
            hintText: "Buat password",
            inputType: TextInputType.visiblePassword,
            type: "password",
            prefixIcon: Icon(Icons.lock_outline),
            suffixIcon: Icon(Icons.visibility),
            isObsecured: true,
          ),
          SizedBox(height: 12),
          CustomTextField(
            fieldController: _confirmPasswordController,
            textLabel: "Konfirmasi Password",
            hintText: "Konfirmasi password",
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

  Widget _buildLoginDirection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sudah punya akun? Login",
          style: appTypo.bodyGray,
        ),
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
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
      if (_checkPasswordConfirmation()) {
        showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          },
          barrierDismissible: false
        );

        final result = await provider.registration(
            _emailController.text,
            _firstNameController.text,
            _lastNameController.text,
            _passwordController.text
        );

        if (result) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPage()
              ),
              ModalRoute.withName("/login")
          );
        } else {
          Navigator.of(context).pop();
          scaffoldMessengerState.showSnackBar(SnackBar(content: Text(provider.message, style: appTypo.bodyWhite,)));
        }
      } else {
        scaffoldMessengerState.showSnackBar(
            SnackBar(content: Text("Konfirmasi Password tidak tepat", style: appTypo.bodyWhite,))
        );
      }
    }
  }

  bool _checkPasswordConfirmation() {
    if (_passwordController.text == _confirmPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }
}
