import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../controller/cart_controller.dart';
import '../../../controller/ecom_cart_controller.dart';
import '../../../utils/constants.dart';
import 'package:get/get.dart';

class IconBtnWithCounter extends StatelessWidget {
   IconBtnWithCounter({
    Key? key,
     this.svgSrc,

     this.press,
  }) : super(key: key);

  final String? svgSrc;
  final GestureTapCallback? press;

  final CartController controller = Get.put(CartController());
  final EcomCartController eController = Get.put(EcomCartController());
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
     InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: press,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              height: 46,
              width: 46,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(svgSrc!,color: const Color(0xFF1A8F00),),
            ),
            if (controller.products.length+eController.products.length != 0)
              Positioned(
                top: -3,
                right: 0,
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    // color: Color(0xFFFF4848),
                    // color: Color(0xFF1A8F00),
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.5, color: Colors.white),
                  ),
                  child: Center(
                    child:
                    Text(
                        "${controller.products.length+eController.products.length}",
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1,
                          fontWeight: FontWeight.w600,
                          color:  Color(0xFF1A8F00),
                        ),
                      ),

                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
