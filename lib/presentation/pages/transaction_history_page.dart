import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;
import 'package:sims_ppob_nutech/common/number_format.dart';
import 'package:sims_ppob_nutech/presentation/provider/balance_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/transaction_provider.dart';
import 'package:sims_ppob_nutech/presentation/widgets/inquiry_card.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  late final ScaffoldMessengerState _scaffoldMessengerState = ScaffoldMessenger.of(context);
  late int _offset;
  final int _limit = 5;

  @override
  void initState() {
    super.initState();
    setState(() {
      _offset = 0;
    });
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildInquiryCard(context),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Transaksi",
                  style: appTypo.body.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 12),
              _buildTransactionList(context),
            ],
          ),
        )
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
        "Transaksi",
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

  Widget _buildTransactionList(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, state, _) {
        return state.isLoading
          ? Center(child: CircularProgressIndicator())
          : state.historyData != null
              ? state.historyData!.records!.isNotEmpty
                  ? Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: state.historyData!.records!.length ?? 0,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => _buildTransactionBox(
                              state.historyData!.records![index].transactionType,
                              state.historyData!.records![index].totalAmount.toString(),
                              state.historyData!.records![index].description,
                              state.historyData!.records![index].createdOn
                            )
                        ),
                        state.historyData!.records!.isNotEmpty
                           ? _buildShowMore()
                           : SizedBox.shrink()
                      ],
                    )
                  : Column(
                      children: [
                        _buildNoTransaction(),
                        SizedBox(height: 8),
                        _buildBackToBeginning()
                      ],
                    )
              : _buildNoTransaction();
      }
    );
  }

  Widget _buildTransactionBox(String type, String amount, String desc, DateTime date) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      decoration: BoxDecoration(
        color: appColor.primaryWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: appColor.textLightGray
        )
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    type == "PAYMENT"
                        ? "-"
                        : "+",
                    style: type == "PAYMENT"
                        ? appTypo.bodyRed.copyWith(color: appColor.textWithdrawal)
                        : appTypo.bodyGreen,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "Rp",
                    style: type == "PAYMENT"
                        ? appTypo.bodyRed.copyWith(color: appColor.textWithdrawal)
                        : appTypo.bodyGreen,
                  ),
                  SizedBox(width: 3),
                  Text(
                    toBalanceFormat(amount),
                    style: type == "PAYMENT"
                        ? appTypo.bodyRed.copyWith(color: appColor.textWithdrawal)
                        : appTypo.bodyGreen,
                  ),
                ],
              ),
              Text(
                desc,
                style: appTypo.body.copyWith(fontSize: 10),
              )
            ],
          ),
          SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: Text(
              _convertDate(date),
              style: appTypo.bodyGray.copyWith(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoTransaction() {
    return SizedBox(
      child: Text("Belum ada transaksi.", style: appTypo.body),
    );
  }

  Widget _buildShowMore() {
    return TextButton(
        onPressed: _loadMoreData,
        child: Text(
          "Show More",
          style: appTypo.bodyRed.copyWith(fontWeight: FontWeight.bold),
        )
    );
  }

  Widget _buildBackToBeginning() {
    return TextButton(
        onPressed: () {
          setState(() {
            _offset = 0;
          });
          _getData();
        },
        child: Text(
          "Kembali ke Awal",
          style: appTypo.bodyRed.copyWith(fontWeight: FontWeight.bold),
        )
    );
  }

  Future<void> _loadMoreData() async {
    setState(() {
      _offset = _offset + _limit;
    });
    _getData();
  }

  Future<void> _getData() async {
    final provider = context.read<TransactionProvider>();
    final result = await provider.getHistory(_offset);

    if (result.data == null) {
      _scaffoldMessengerState.showSnackBar(
          SnackBar(content: Text(provider.message, style: appTypo.bodyWhite,)));
    }
  }

  String _convertDate(DateTime date) {
    String formatted = DateFormat('dd M yyyy - HH.mm').format(date);
    int i = 0;
    int end = 0;
    int count = 0;

    for (var rune in formatted.runes) {
      var character= String.fromCharCode(rune);

      if (character == " ") {
        count++;
        if (count < 2) {
          i++;
        } else if (count ==2) {
          end = i;
          break;
        }
      } else {
        i++;
      }
    }

    String month = formatted.substring(3,end);
    month = _getMonthName(month);

    return formatted.replaceRange(3, end, month);
  }

  String _getMonthName(String month) {
    switch (month) {
      case "1":
        return "Januari";
      case "2":
        return "Februari";
      case "3":
        return "Maret";
      case "4":
        return "April";
      case "5":
        return "Mei";
      case "6":
        return "Juni";
      case "7":
        return "Juli";
      case "8":
        return "Agustus";
      case "9":
        return "September";
      case "10":
        return "Oktober";
      case "11":
        return "November";
      case "12":
        return "Desember";
      default:
        return month;
    }
  }
}
