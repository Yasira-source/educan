
import 'package:educanapp/models/all_products_model.dart';
import 'package:educanapp/models/bookshop_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/flutterwave_payments_controller.dart';
import '../../../size_config.dart';

class CartCard2 extends StatefulWidget {
  CartCard2({
    Key? key,
    required this.cart,
    required this.controller,
    required this.index,
    required this.quantity,
    required this.uid
  }) : super(key: key);
  final ProductsData cart;
  final CartController controller;
  final int quantity;
  final int index;
  final String uid;
  @override
  State<CartCard2> createState() => _CartCard2State();
}
class _CartCard2State extends State<CartCard2> {

  var f = NumberFormat("###,###", "en_US");

  final controllerx = FlutterWavePaymentsController();


  Future<String>  _sendCart2() async{

    var result= await controllerx.uploadCartItem2(widget.uid,widget.cart.pid.toString(),widget.quantity.toString()
        , 1);
    // print(result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return    Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 88,
                    child: AspectRatio(
                      aspectRatio: 0.88,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.network("https://educanug.com/Educan/${widget.cart.pimage1!}"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.cart.pname!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                          style:  const TextStyle(color: Colors.black, fontSize: 16,),

                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "UGX ${f.format(widget.cart.pprice!)} ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, color: Color(0xFF1A8F00)),
                            ),
                            Text(
                                " x ${widget.quantity}",
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        const SizedBox(height: 2,),
                        Row(
                          children: [
                            Text(
                              "UGX ${f.format(int.parse(widget.cart.prprice!))} ",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black,fontSize: 12),
                            ),

                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      (((int.parse(widget.cart.prprice!) - widget.cart.pprice!) /
                                          int.parse(widget.cart.prprice!)) *
                                          100)
                                          .round() >
                                          0
                                          ? Container(
                                        height: 30,
                                        width: 45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(2.0),
                                            color: const Color(0xFF1A8F00)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "-${(((int.parse(widget.cart.prprice!) - widget.cart.pprice!) / int.parse(widget.cart.prprice!)) * 100).round()}%",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                      )
                                          : const SizedBox(
                                        height: 5,
                                        width: 5,
                                      )
                                    ])),

                          ],
                        ),


                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  TextButton.icon(onPressed: (){
                    widget.controller.removeProduct2x(widget.cart);
                  },
                      icon: const Icon(
                        Icons.delete_outline_outlined,
                        color: Color(0xFF1A8F00),
                        size: 15,
                      ),
                      label: const Text("REMOVE",style: TextStyle(color: Color(0xFF1A8F00),fontSize: 13,fontWeight: FontWeight.bold),)),


                  IconButton(
                      onPressed: () {
                        widget.controller.removeProductx(widget.cart);
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Color(0xFF1A8F00),
                        size: 20,
                      )),
                  Container(
                      width: 30.0,
                      height: 35.0,
                      padding: const EdgeInsets.only(top: 15.0),
                      // color: kAccentColor,
                      child: TextField(
                        enabled: false,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.quantity.toString(),
                            hintStyle:
                            const TextStyle(color: Colors.black)),
                      )),

                  IconButton(
                      onPressed: () {
                        widget.controller.addProductx(widget.cart);
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: Color(0xFF1A8F00),
                        size: 20,
                      )),
                ],

              ),
            ],
          );
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Displaying LoadingSpinner to indicate waiting state

      },

      // Future that needs to be resolved
      // inorder to display something on the Canvas
      future: _sendCart2(),
    );


  }
}
