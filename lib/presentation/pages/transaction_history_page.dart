import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_nutech/common/config/theme/colors.dart' as appColor;
import 'package:sims_ppob_nutech/common/config/theme/typography.dart' as appTypo;
import 'package:sims_ppob_nutech/presentation/provider/balance_provider.dart';
import 'package:sims_ppob_nutech/presentation/provider/transaction_provider.dart';
import 'package:sims_ppob_nutech/presentation/widgets/inquiry_card.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  late ScaffoldMessengerState scaffoldMessengerState;
  late ScrollController _scrollController;
  late bool _isLoading;
  final int _limit = 5;

  int _offset = 0;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    scaffoldMessengerState = ScaffoldMessenger.of(context);
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
        if (!_isLoading) {
          _isLoading = !_isLoading;
          _changeOffset();
        }
      }
    });
  }
  
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
        return ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: 10,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => Text("halo")
        );
      }
    );
  }

  Future<void> _changeOffset() async {
    final provider = context.read<TransactionProvider>();

    // final result = provider.getHistory(offset);
  }
}
