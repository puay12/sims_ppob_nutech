import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;
import 'package:sims_ppob_nutech/presentation/pages/main_page.dart';
import 'package:sims_ppob_nutech/presentation/provider/balance_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/topup_provider.dart';
import 'package:sims_ppob_nutech/presentation/widgets/custom_text_field.dart';
import 'package:sims_ppob_nutech/presentation/widgets/default_button.dart';
import 'package:sims_ppob_nutech/presentation/widgets/inquiry_card.dart';

class TopUpPage extends StatefulWidget {
  TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _topUpAmountController;
  late int _selectedIndex;
  late bool isFilled;
  late List<Map<String, dynamic>> _amountList;
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _topUpAmountController = TextEditingController();
    _topUpAmountController.addListener(() {
      final isButtonActive = _topUpAmountController.text.isNotEmpty;

      setState(() => _isButtonActive = isButtonActive);
    });
    _selectedIndex = -1;
    _amountList = [
      {
        "amount": "10.000",
        "isSelected": false
      },
      {
        "amount": "20.000",
        "isSelected": false
      },
      {
        "amount": "50.000",
        "isSelected": false
      },
      {
        "amount": "100.000",
        "isSelected": false
      },
      {
        "amount": "250.000",
        "isSelected": false
      },
      {
        "amount": "500.000",
        "isSelected": false
      },
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _topUpAmountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _buildInquiryCard(context),
              SizedBox(height: 42),
              _buildForm()
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 14),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
              bottom: BorderSide(color: appColor.textLightGray)
          )
      ),
      child: Text(
        "Top Up",
        style: appTypo.bodySubtitle.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInquiryCard(BuildContext context) {
    return Consumer<BalanceProvider>(
        builder: (context, state, _) {
          return InquiryCard(
              balance: state.balanceData != null
                  ? state.balanceData.toString()
                  : 0.toString(),
              isWithVisibility: false
          );
        }
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Silahkan masukan",
              style: appTypo.body,
            ),
            Text(
              "Nominal Top Up",
              style: appTypo.bodyTitle,
            ),
            SizedBox(height: 24),
            _buildAmountForm(),
            SizedBox(height: 52),
            DefaultButton(
              label: "Top Up",
              buttonAction: _submitForm,
              isDynamic: _isButtonActive,
            )
          ],
        ),
      )
    );
  }

  Widget _buildAmountForm() {
    return Column(
      children: [
        CustomTextField(
          fieldController: _topUpAmountController,
          textLabel: "Nominal",
          hintText: "Masukkan nominal top up",
          isObsecured: false,
          inputType: TextInputType.number,
          type: "topup",
          prefixIcon: Icon(Icons.attach_money),
        ),
        SizedBox(height: 16),
        SizedBox(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 2
            ),
            itemCount: _amountList.length,
            itemBuilder: (context, index) {
              return _buildAmountBox(_amountList[index], index);
            },
          ),
        )
      ],
    );
  }

  Widget _buildAmountBox(Map<String, dynamic> amountItem, int index) {
    return ElevatedButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: appColor.primaryWhite,
          padding: EdgeInsets.all(12),
          side: BorderSide(
            color: amountItem["isSelected"]
                ? appColor.primaryRed
                : appColor.textLightGray
          )
        ),
        child: Text(
          "Rp ${amountItem["amount"]}",
          style: appTypo.body.copyWith(
              color: amountItem["isSelected"]
                  ? appColor.textPrimary
                  : appColor.textDarkGray
          ),
        )
    );
  }

  _onAmountSelected(int index) {
    setState(() {
      if (_selectedIndex < 0) {
        _selectedIndex = index;
      }

      String amount = _amountList[index]["amount"];

      _topUpAmountController.text = amount.replaceAll(".", "");
      _amountList[index]["isSelected"] = !_amountList[index]["isSelected"];
      _amountList[_selectedIndex]["isSelected"] = false;
      _selectedIndex = index;
    });
  }

  Future<void> _submitForm() async {
    setState(() => _isButtonActive = false);
    final TopupProvider provider = context.read<TopupProvider>();
    final ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);

    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        },
        barrierDismissible: false
      );

      final result = await provider.performTopup(int.parse(_topUpAmountController.text));

      Navigator.of(context).pop();

      if (result.data != null) {
        showDialog(
            context: context,
            builder: (context) {
              return _buildDialog();
            },
            barrierDismissible: false
        );
      } else {
        scaffoldMessengerState.showSnackBar(SnackBar(content: Text(provider.message, style: appTypo.bodyWhite,)));
      }
    }
  }

  Widget _buildDialog() {
    return Center(
        child: Container(
          width: 250,
          height: 290,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: appColor.primaryWhite,
            boxShadow: const [
                BoxShadow(
                    color: appColor.textLightGray,
                    blurRadius: 3,
                    spreadRadius: 1
                )
            ],
            borderRadius: BorderRadius.circular(16)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/success.png",
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
              SizedBox(height: 16),
              Text(
                "Top Up Sebesar",
                style: appTypo.body,
              ),
              SizedBox(height: 12),
              Text(
                "Rp ${_topUpAmountController.text}",
                style: appTypo.bodyTitle,
              ),
              SizedBox(height: 12),
              Text(
                "Berhasil!",
                style: appTypo.body,
              ),
              SizedBox(height: 16),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()
                        ),
                        ModalRoute.withName("/home")
                    );
                  },
                  child: Text(
                      "Kembali ke Beranda",
                      style: appTypo.bodyRed.copyWith(fontWeight: FontWeight.bold)
                  )
              )
            ],
          ),
        )
    );
  }
}
