
import 'package:educanapp/views/notification/components/defaultAppBar.dart';
import 'package:flutter/material.dart';

import '../../utils/constants_new.dart';
import '../../utils/widgets/emptySection.dart';
import '../notification/components/defaultBackButton.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: 'My Orders',
        child: DefaultBackButton(),
      ),
      body: EmptySection(
        emptyImg: emptyOrders,
        emptyMsg: 'No orders yet',
      ),
    );
  }
}
