import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sgt/presentation/time_sheet_screen/model/missed_shift_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import '../../../utils/const.dart';
import '../../property_details_screen/widgets/map_card_widget.dart';
import '../../widgets/custom_text_widget.dart';

class MissedShiftDetailsScreen extends StatefulWidget {
  MissedDatum? details;
  String? imageBaseUrl;
  MissedShiftDetailsScreen({super.key, this.details, this.imageBaseUrl});

  @override
  State<MissedShiftDetailsScreen> createState() =>
      _MissedShiftDetailsScreenState();
}

class _MissedShiftDetailsScreenState extends State<MissedShiftDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appbarTitle: 'Missed Shifts'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCircularImage.getCircularImage(
                        widget.imageBaseUrl.toString(),
                        widget.details!.propertyAvatars!.first.propertyAvatar
                            .toString(),
                        false,
                        42,
                        0,
                        0),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.details!.propertyName.toString(),
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.details!.location.toString(),
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Last Shift: ',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                                Text(
                                  '${widget.details!.shift == null ? '' : widget.details!.shift!.clockIn.toString()} ~ ${widget.details!.shift == null ? '' : widget.details!.shift!.clockOut.toString()}',
                                  style: TextStyle(fontSize: 12, color: black),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: primaryColor,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFieldHeaderWidget(title: 'Missed Shift'),
                    const SizedBox(height: 10),
                    Container(
                      height: 60,
                      width: 122,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: seconderyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '${widget.details!.shift == null ? '' : DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.details!.shift!.shiftDate!.toString())).toString()}',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.details!.shift == null
                                  ? ''
                                  : widget.details!.shift!.clockIn.toString(),
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),

              const SizedBox(height: 25),
              TextFieldHeaderWidget(title: 'Description'),
              const SizedBox(height: 10),
              Text(
                widget.details!.propertyDescription.toString(),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 25),
              TextFieldHeaderWidget(title: 'Location'),
              const SizedBox(height: 10),
              Text(
                widget.details!.location.toString(),
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 25),
              MapCardWidget(
                currentlocation: LatLng(
                    double.parse(widget.details!.latitude.toString())
                        .toDouble(),
                    double.parse(widget.details!.longitude.toString())
                        .toDouble()),
              ), //showing map card
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
