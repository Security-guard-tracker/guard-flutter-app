// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/jobs_screen/widgets/job_tiles.dart';

class InactiveJobsTab extends StatefulWidget {
  List<InactiveDatum> inActiveData = [];
  String imageBaseUrl;
  String? propertyImageBaseUrl;
  InactiveJobsTab({
    Key? key,
    required this.inActiveData,
    required this.imageBaseUrl, 
    this.propertyImageBaseUrl,
  }) : super(key: key);

  @override
  State<InactiveJobsTab> createState() => _InactiveJobsTabState();
}

class _InactiveJobsTabState extends State<InactiveJobsTab> {
  @override
  Widget build(BuildContext context) {
    return widget.inActiveData.isEmpty
        ? SizedBox(
            child: Center(
              child: Text(
                'No InActive Jobs Found',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Container(
              //       width: 120,
              //       child: Image.asset(
              //         'assets/no_active_properties.png',
              //         fit: BoxFit.contain,
              //       ),
              //     ),
              //     SizedBox(
              //       height: 24,
              //     ),
              //     Text(
              //       'No Inactive Properties',
              //       style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,color:Colors.grey.withOpacity(0.6)),
              //     ),
              //   ],
              // ),
            ),
          )
        : ListView.builder(
            // shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: widget.inActiveData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  JobsTile(
                    isActive: false,
                    inActiveData: widget.inActiveData[index],
                    imageBaseUrl: widget.imageBaseUrl,
                    propertyImageBaseUrl:widget.propertyImageBaseUrl,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                ],
              );
            });
  }
}
