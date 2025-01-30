import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/generated/l10n.dart';

class CityForm extends StatefulWidget {
  @override
  _CityFormState createState() => _CityFormState();
}

class _CityFormState extends State<CityForm> {
  String? selectedCity;

  final List<String> cities = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Sharm El Sheikh',
    'Hurghada',
    'Luxor',
    'Aswan',
    'Port Said',
    'Suez',
    'Tanta',
    'Mansoura',
    'Damanhur',
    'Ismailia',
    'Minya',
    'Beni Suef',
    'Fayoum',
    'Qena',
    'Sohag'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      iconSize: 25.sp,
    // itemHeight: 48.sp,
      isExpanded: true,
      value: selectedCity,
      hint: Text(S.of(context).selectACity,style: TextStyle(
          fontSize: 14.sp
      )),
      onChanged: (String? newValue) {
        setState(() {
          selectedCity = newValue;
        });
      },
      validator: (value) {
        if (value == null) {
          return S.of(context).selectACity;
        }
        return null;
      },
      items: cities.map<DropdownMenuItem<String>>((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city,style: TextStyle(
              fontSize: 14.sp
          )),
        );
      }).toList(),
    );
  }
}
