
import 'package:flutter/material.dart';
import 'package:healthy_sync/unts/AppColor.dart';

Widget buildDot({required int index,required currentPage}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    margin: EdgeInsets.only(right: 8),
    height: 10,
    width: 10,
    decoration: BoxDecoration(
      color: currentPage == index ? AppColor.main : AppColor.darkGrey,
      borderRadius: BorderRadius.circular(5),
    ),
  );
}
