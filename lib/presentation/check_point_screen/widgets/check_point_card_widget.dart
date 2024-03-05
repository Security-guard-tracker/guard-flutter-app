import 'package:flutter/material.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/const.dart';
import 'package:http/http.dart' as http;

//card data class
// class CardDetails {
//   final IconData icon;
//   final String data;
//   CardDetails({
//     required this.icon,
//     required this.data,
//   });
// }

// //list of card data
// List<CardDetails> data = [
//   CardDetails(icon: Icons.schedule_outlined, data: '6 Hours Duty'),
//   CardDetails(icon: Icons.edit_note_outlined, data: '13 Checkpoints'),
//   CardDetails(icon: Icons.person_outlined, data: 'Surveillance')
// ];

class CheckPointCardsWidget extends StatefulWidget {
  Property? property;
  String? propertyImageBaseUrl;
  CheckPointCardsWidget({super.key, this.property, this.propertyImageBaseUrl});

  @override
  State<CheckPointCardsWidget> createState() => _CheckPointCardsWidgetState();
}

class _CheckPointCardsWidgetState extends State<CheckPointCardsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 171, 171, 171),
            offset: Offset(0, 5),
            blurRadius: 20,
            spreadRadius: 0.1,
          ),
        ],
        border: Border.all(color: seconderyColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 10,
          ),
          widget.property!.propertyAvatars != null
              ? CircleAvatar(
                  backgroundColor: grey,
                  backgroundImage: NetworkImage(
                      widget.propertyImageBaseUrl.toString() +
                          '' +
                          widget.property!.propertyAvatars!.first.propertyAvatar
                              .toString()))
              : CircleAvatar(
                  backgroundColor: grey,
                  backgroundImage: AssetImage('assets/sgt_logo.jpg')),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              // height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    // 'Rivi Properties',
                    widget.property!.propertyName.toString(),
                    style: CustomTheme.blackTextStyle(15),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    // '1517 South Centelella',
                    widget.property!.location.toString(),
                    style: CustomTheme.greyTextStyle(10),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Remaining Shift Time:',
                        style: CustomTheme.blueTextStyle(8, FontWeight.w500),
                      ),
                      Text(
                        ' 2 Hrs 30 Min 23 Secs', // api response pending
                        style: CustomTheme.blackTextStyle(8),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 45,
          ),
          // Container(
          //   height: 52,
          //   child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: data
          //           .map(
          //             (e) => Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 2),
          //               child: Row(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Icon(
          //                     e.icon,
          //                     color: Colors.grey,
          //                     size: 13,
          //                   ),
          //                   SizedBox(
          //                     width: 2,
          //                   ),
          //                   Text(
          //                     e.data,
          //                     style: CustomTheme.blackTextStyle(10),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           )
          //           .toList()),
          // )
        ],
      ),
    );
  }
}
