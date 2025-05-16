import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CyberCard extends StatefulWidget {
  const CyberCard({super.key});

  @override
  _CyberCardState createState() => _CyberCardState();
}

class _CyberCardState extends State<CyberCard> {
  String selectedOption = "Select option";
  List<String> options = ["UI Design", "HTML", "CSS", "JS"];
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            width: 1.sw,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedOption,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.black87,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            width: 1.sw,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
            ),
            child: Column(
              children: options.map((option) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOption = option;
                      isExpanded = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    width: double.infinity,
                    child: Text(
                      option,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
