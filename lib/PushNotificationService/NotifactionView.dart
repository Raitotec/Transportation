import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NotifactionViewModel.dart';

class NotifactionView extends StatefulWidget {
  @override
  _NotifactionViewState createState() => _NotifactionViewState();
}

class _NotifactionViewState extends State<NotifactionView> {
  late Future<void> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture =
        Provider.of<NotifactionViewModel>(context, listen: false).GetData(context);
  }

  @override
  Widget build(BuildContext context) {

    return Container();

  }
}