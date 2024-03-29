import 'package:flutter/material.dart';

class PropertydataModel {
  final String title;
  final String number;
  PropertydataModel({
    required this.title,
    required this.number,
  });
}

List<PropertydataModel> propertyData = [
  PropertydataModel(title: 'Guards', number: '15'),
  PropertydataModel(title: 'Points', number: '10'),
  PropertydataModel(title: 'Sqft', number: '7000')
];

class PropertyDataWidget extends StatelessWidget {
  const PropertyDataWidget(
      {super.key, required this.title, required this.number});
  final String title;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              number,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15
              ),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,
                fontSize: 13),
            )
          ],
        ),
        const SizedBox(
          width: 60,
        ),
      ],
    );
  }
}
