import 'package:flutter/material.dart';

import '../../utils/constants_new.dart';
import '../about/about.dart';
import '../callCenter/callCenter.dart';
import '../message/message.dart';
import '../notification/notificationList.dart';
import '../orders/trackOrder.dart';
import '../payment/paymentDetails.dart';

class Account extends StatefulWidget {
  Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            // overflow: Overflow.visible,
            alignment: Alignment.center,
            children: [
              Container(
                height: 250.0,
                child: Image(
                  image: AssetImage(bg),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -60.0,
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 4.0,
                    ),
                    image: DecorationImage(
                      image: AssetImage(profile),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -88.0,
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF303030),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 88.0),
              itemCount: labels.length,
              itemBuilder: (context, index) {
                return ListTile(
                    // dense: true,
                    leading: Icon(
                      icons[index],
                      color: Color(0xFF1A8F00),
                    ),
                    title: Text(labels[index]),
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          switch (labels[index]) {
                            case 'Notifications':
                              return NotificationList();
                              break;
                            case 'Payments':
                              return PaymentDetails();
                              break;
                            case 'Message':
                              return Message();
                              break;
                            case 'My Orders':
                              return TrackOrder();
                              break;
                            case 'Edit Profile':
                              return TrackOrder();
                              break;
                            case 'Call Center':
                              return CallCenter();
                              break;
                              case 'App Referrals':
                              return CallCenter();
                              break;
                              
                            case 'About Application':
                              return About();
                              break;
                            case 'Sign Out':
                              return About();
                              break;
                            default:
                              return null!;
                          }
                        }))
                    // onTap: () => this.setState(
                    //   () {
                    //     switch (labels[index]) {
                    //       case 'Notifications':
                    //         return snackBarMsg(context, 'Notifications');
                    //         break;
                    //       case 'Payments':
                    //         return snackBarMsg(context, 'Payments');
                    //         break;
                    //       case 'Message':
                    //         return snackBarMsg(context, 'Message');
                    //         break;
                    //       case 'My Orders':
                    //         return snackBarMsg(context, 'My Orders');
                    //         break;
                    //       case 'Setting Account':
                    //         return snackBarMsg(context, 'Setting Account');
                    //         break;
                    //       case 'Call Center':
                    //         return snackBarMsg(context, 'Call Center');
                    //         break;
                    //       case 'About Application':
                    //         return snackBarMsg(context, 'About Application');
                    //         break;
                    //       default:
                    //         return snackBarMsg(context, 'Notifications');
                    //         break;
                    //     }
                    //   },
                    // ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  snackBarMsg(BuildContext context, String msg) {
    var sb = SnackBar(
      elevation: kRadius,
      content: Text(msg),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        // textColor: kWhiteColor,
        label: 'OK',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState!.showSnackBar(sb);
  }
}
