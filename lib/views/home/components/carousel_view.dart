import 'package:educanapp/models/my_slider.dart';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  const MySlider({Key? key}) : super(key: key);

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          height: 160,
          decoration: const BoxDecoration(
            color: Colors.orange,
          ),
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            controller: PageController(viewportFraction: 0.9),
            itemCount: sliderModelData.length,
            itemBuilder: (context, index) {
              // var banner = sliderModelData[index];
              // var _scale = _selectedIndex == index ? 1.0 : 0.0;
              return  Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image:
                            AssetImage(sliderModelData[index].thumbnailUrl),
                        fit: BoxFit.cover,
                      )),
                  child: const Text(""
                   
                  ),
                
              );
            },
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ...List.generate(
        //         sliderModelData.length,
        //         (index) =>
        //             Indicator(isActive: _selectedIndex == index ? true : false))
        //   ],
        // ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  final bool? isActive;
  const Indicator({
    Key? key,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
