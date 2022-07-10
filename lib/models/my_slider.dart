import 'package:flutter/material.dart';

class SliderModel {
  final int id;
  final String title;
  final thumbnailUrl;

  SliderModel(this.id, this.title, this.thumbnailUrl);
}

// sample data
List<SliderModel> sliderModelData = [
  SliderModel(1,'Title','assets/images/bk1.jpg'),
  SliderModel(2,'Title','assets/images/bk2.jpg'),
  SliderModel(3,'Title','assets/images/bk3.jpg'),
  SliderModel(4,'Title','assets/images/bk4.jpg'),
  // SliderModel(5,'Title','https://www.pexels.com/photo/girls-studying-the-lego-education-spike-prime-7750686/'),
];
