import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/const.dart';
import '../connect_screen/widgets/chat_model.dart';
import '../work_report_screen/work_report_screen.dart';

class AllTeamMemberScreen extends StatefulWidget {
  const AllTeamMemberScreen({super.key});

  @override
  State<AllTeamMemberScreen> createState() => _AllTeamMemberScreenState();
}

class _AllTeamMemberScreenState extends State<AllTeamMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: greenColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Greylock Security',
                style: TextStyle(color: black),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Team',
                  style: TextStyle(
                      color: black, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 4 / 5,
              child: ListView.builder(
                  itemCount: dummyData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundColor: grey,
                              backgroundImage: NetworkImage(
                                dummyData[index].profileUrl,
                              ),
                            ),
                            title: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dummyData[index].name,
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  dummyData[index].location,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            subtitle: Text(
                              dummyData[index].position,
                              style: TextStyle(fontSize: 13, color: black),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        )),
      ),
    );
  }
}
