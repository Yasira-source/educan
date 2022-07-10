import 'package:flutter/material.dart';

import '../../../utils/constants.dart';


class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.82,
      width: MediaQuery.of(context).size.width * 0.79,
      decoration: BoxDecoration(
        // color: kSecondaryColor.withOpacity(0.1),
        border: Border.all(color: const Color(0xFF1A8F00)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: (value) => print(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 9),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search in Educan Shop ...",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
