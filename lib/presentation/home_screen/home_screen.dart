import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/all_team_member/all_team_member_screen.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/home_screen/widgets/circular_profile_widget.dart';
import 'package:sgt/presentation/home_screen/widgets/location_details_card.dart';
import 'package:sgt/presentation/home_screen/widgets/location_details_model.dart';
import 'package:sgt/presentation/jobs_screen/jobs_screen.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/widgets/property_details_screen.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../widgets/main_appbar_widget.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/const.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? totalTeams;
  Future<DutyListModel> getJobsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + apiRoutes['dutyList']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);

    if (response.statusCode == 201) {
      final DutyListModel responseModel = dutyModelFromJson(response.body);
      activeDatum = responseModel.activeData ?? [];
      // print('Active: $activeDatum');
      inActiveDatum = responseModel.inactiveData ?? [];
      // print('InActive: $inActiveDatum');
      imgBaseUrl = responseModel.imageBaseUrl ?? '';
      return responseModel;
    } else {
      return DutyListModel(
          activeData: [],
          inactiveData: [],
          status: response.statusCode,
          imageBaseUrl: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String dateStr = "${today.day}/${today.month}/${today.year}";
    print(dateStr);
    return Scaffold(
      appBar: MainAppBarWidget(
        appBarTitle: 'Security Guard Tracking',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getJobsList();
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(), 
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Team (${totalTeams.toString()})',
                      style: CustomTheme.textField_Headertext_Style),
                  //btn to see all team members
                  InkWell(
                    onTap: () async {
                      //screenNavigator(context, AllTeamMemberScreen());
                      await FirebaseHelper.createGuardLocation('22.572645',
                              '88.363892', 'current_shift', 'checkpId')
                          .then((value) {
                        screenNavigator(context, AllTeamMemberScreen());
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text('See all', style: CustomTheme.seeAllBtnStyle),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),*/
              SizedBox(
                height: 145,
                child: CircularProfile(), //showing all team member horizontally
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active Tours (${activeDatum.length})',
                    style: CustomTheme.textField_Headertext_Style,
                  ),
                  //btn to see all the active jobs
                  InkWell(
                    onTap: () {
                      screenNavigator(context, JobsScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text('See all', style: CustomTheme.seeAllBtnStyle),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        dateStr,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey.withOpacity(0.9),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              //LocationDetailsCard(),
              FutureBuilder(
                  future: getJobsList(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Container(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator()));
                    } else {
                      return Column(
                        children: [
                          // snapshot.data!.activeData!.isEmpty
                          //     ? SizedBox(
                          //         child: Center(
                          //           child: Column(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.center,
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.center,
                          //             children: [
                          //               Container(
                          //                 width: 120,
                          //                 child: Image.asset(
                          //                   'assets/no_active_jobs.png',
                          //                   fit: BoxFit.contain,
                          //                 ),
                          //               ),
                          //               SizedBox(
                          //                 height: 12,
                          //               ),
                          //               Text(
                          //                 'No active jobs',
                          //                 style: TextStyle(
                          //                     fontWeight: FontWeight.w600,
                          //                     fontSize: 17,
                          //                     color:
                          //                         Colors.grey.withOpacity(0.6)),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       )
                          //     :
                          ListView.builder(
                              itemCount: snapshot.data!.activeData!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    screenNavigator(
                                        context,
                                        PropertyDetailsScreen(
                                          propertyId: snapshot
                                              .data!.activeData![index].id,
                                          imageBaseUrl:
                                              snapshot.data!.imageBaseUrl,
                                          propertyImageBaseUrl: snapshot
                                              .data!.propertyImageBaseUrl,
                                          activeData:
                                              snapshot.data?.activeData![index],
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 204,
                                          decoration:
                                              CustomTheme.locationCardStyle(
                                                  snapshot.data!
                                                      .propertyImageBaseUrl
                                                      .toString(),
                                                  snapshot
                                                      .data!
                                                      .activeData![index]
                                                      .propertyAvatars!
                                                      .first
                                                      .propertyAvatar
                                                      .toString()),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              // snapshot.data!.jobs!.data![index].propertyName.toString(),
                                              snapshot.data!.activeData![index]
                                                  .propertyName
                                                  .toString(),
                                              // locationData[index].title,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            Text(
                                              snapshot.data!.activeData![index]
                                                  .latestShiftTime
                                                  .toString(),
                                              // locationData[index].duty,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: primaryColor),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: primaryColor,
                                              size: 15,
                                            ),
                                            Text(
                                              snapshot
                                                  // .data!.jobs!.data![index].propertyName
                                                  .data!
                                                  .activeData![index]
                                                  .propertyName
                                                  .toString(),
                                              // locationData[index].subtitle,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            // locationData[index].address,
                                            snapshot.data!.activeData![index]
                                                .location
                                                // snapshot.data!.jobs!.data![index].location
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13, color: black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Upcoming Tours (${inActiveDatum.length})',
                                style: CustomTheme.textField_Headertext_Style,
                              ),
                              //btn to see all the active jobs
                              InkWell(
                                onTap: () {
                                  screenNavigator(context, JobsScreen());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text('See all',
                                      style: CustomTheme.seeAllBtnStyle),
                                ),
                              )
                            ],
                          ),
                          // snapshot.data!.inactiveData!.isEmpty
                          //     ? SizedBox(
                          //         child: Center(
                          //           child: Column(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.center,
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.center,
                          //             children: [
                          //               Container(
                          //                 width: 120,
                          //                 child: Image.asset(
                          //                   'assets/no_active_jobs.png',
                          //                   fit: BoxFit.contain,
                          //                 ),
                          //               ),
                          //               SizedBox(
                          //                 height: 12,
                          //               ),
                          //               Text(
                          //                 'No Inactive jobs',
                          //                 style: TextStyle(
                          //                     fontWeight: FontWeight.w600,
                          //                     fontSize: 17,
                          //                     color:
                          //                         Colors.grey.withOpacity(0.6)),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       )
                          //     :
                          ListView.builder(
                              itemCount: snapshot.data!.inactiveData!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    screenNavigator(
                                        context,
                                        PropertyDetailsScreen(
                                          propertyId: snapshot
                                              .data!.inactiveData![index].id,
                                          imageBaseUrl:
                                              snapshot.data!.imageBaseUrl,
                                          propertyImageBaseUrl: snapshot
                                              .data!.propertyImageBaseUrl,
                                          activeData: snapshot
                                              .data?.inactiveData![index],
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 204,
                                          decoration:
                                              CustomTheme.locationCardStyle(
                                                  snapshot.data!
                                                      .propertyImageBaseUrl
                                                      .toString(),
                                                  snapshot
                                                      .data!
                                                      .inactiveData![index]
                                                      .propertyAvatars!
                                                      .first
                                                      .propertyAvatar
                                                      .toString()),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              // snapshot.data!.jobs!.data![index].propertyName.toString(),
                                              snapshot
                                                  .data!
                                                  .inactiveData![index]
                                                  .propertyName
                                                  .toString(),
                                              // locationData[index].title,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            Text(
                                              snapshot
                                                  .data!
                                                  .inactiveData![index]
                                                  .latestShiftTime
                                                  .toString(),
                                              // locationData[index].duty,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: primaryColor),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: primaryColor,
                                              size: 15,
                                            ),
                                            Text(
                                              snapshot
                                                  // .data!.jobs!.data![index].propertyName
                                                  .data!
                                                  .inactiveData![index]
                                                  .propertyName
                                                  .toString(),
                                              // locationData[index].subtitle,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            // locationData[index].address,
                                            snapshot.data!.inactiveData![index]
                                                .location
                                                // snapshot.data!.jobs!.data![index].location
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 13, color: black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                        ],
                      );
                    }
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
