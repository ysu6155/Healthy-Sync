import 'package:flutter/material.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonFormField<String>(
          value: selectedCity,
          hint: Text('Select a city'),
          onChanged: (String? newValue) {
            setState(() {
              selectedCity = newValue;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Please select a city';
            }
            return null;
          },
          items: cities.map<DropdownMenuItem<String>>((String city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(city),
            );
          }).toList(),
        )
      ],
    );
  }
}
