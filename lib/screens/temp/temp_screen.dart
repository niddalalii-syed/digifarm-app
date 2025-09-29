import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/models/temp_humid_forcast/temp_humid_forcast.dart';
import 'package:digifarm_new/services/api_servises/api_services.dart';
import 'package:digifarm_new/widgets/percentage_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {

  TempHumidForcast? tempHumidForcast; // Store the fetched data
  final API_Services _apiService = API_Services();  // Create instance of ApiService

  @override
  void initState() {
    super.initState();
    fetchTempData();  // Fetch data on screen initialization
  }

  // Function to fetch data from the API
  Future<void> fetchTempData() async {
    try {
      final forecastData = await _apiService.fetchTempHumidForcast();
      setState(() {
        tempHumidForcast = forecastData;  // Set the fetched data
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: ScreenSizeUtil.getWidth(context) * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: ClrUtils.green2,
                          borderRadius: BorderRadius.circular(15)),
                      height: 93,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 75,

                            width: ScreenSizeUtil.getWidth(context) * 0.6,
                            decoration: BoxDecoration(
                                color: ClrUtils.green1,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ClrUtils.greenbg),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(ImgUtils.thermo),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Temperature',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      tempHumidForcast == null
                                          ?
                                          SpinKitWaveSpinner(
                                            color: Colors.white,
                                            size: 35.0,
                                          )
                                          : Text(
                                        "${tempHumidForcast?.data.temperature ?? 'N/A'}°C",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   height: 75,
                          //   width: ScreenSizeUtil.getWidth(context) * 0.42,
                          //   decoration: BoxDecoration(
                          //       color: ClrUtils.green1,
                          //       borderRadius: BorderRadius.circular(15)),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Row(
                          //       children: [
                          //         Container(
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(10),
                          //               color: ClrUtils.greenbg),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Image.asset(ImgUtils.humid),
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           width: 10,
                          //         ),
                          //         Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               'Humidity',
                          //               style: TextStyle(
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 14),
                          //             ),
                          //             Text(
                          //               '55',
                          //               style: TextStyle(
                          //                   fontSize: 25,
                          //                   fontWeight: FontWeight.bold,
                          //                   color: Colors.black),
                          //             )
                          //           ],
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Next 7 days',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: tempHumidForcast?.data.forecastData.isNotEmpty ?? false
                              ? tempHumidForcast?.data.forecastData.map((forecast) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: ScreenSizeUtil.getWidth(context) * 0.31, // Adjust width if necessary
                                height: ScreenSizeUtil.getHeight(context) * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ClrUtils.blue,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      forecast.date,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Image.asset(ImgUtils.cloudsun),
                                    Text(
                                      '${forecast.temperature?.toString() ?? 'N/A'}°C',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList() ?? []
                              : [
                      Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: ScreenSizeUtil.getWidth(context) * 0.31, // Adjust width if necessary
                        height: ScreenSizeUtil.getHeight(context) * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ClrUtils.blue,
                        ),
                        child: Center(
                          child: SpinKitWaveSpinner(
                            color: Colors.white,
                            size: 45.0,
                          )

                        ),
                      ),
                    ),
                  ],
                )

              ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Today',
                      style: TextStyle(fontSize: 18),
                    ),
                     SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ClrUtils.grey,
                            ),
                            height: 300,
                            width: ScreenSizeUtil.getWidth(context) * 0.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PercentageIndicator(
                                  color: ClrUtils.darkblue.withBlue(70),
                                  barBg: ClrUtils.darkblue,
                                  percentage: tempHumidForcast?.data.temperature ?? 0,                                ),
                                   SizedBox(
                      height: 20,
                    ),
                                              Text('Level',style: TextStyle(fontSize:24),),

                              ],
                            ))),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
