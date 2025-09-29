import 'dart:convert';

import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/models/npk_model/npk_model.dart';
import 'package:digifarm_new/models/ph_level_model/ph_level_model.dart';
import 'package:digifarm_new/screens/dashboardAnalysis/predictive_analysis_screen.dart';
import 'package:digifarm_new/services/api_servises/api_services.dart';
import 'package:digifarm_new/widgets/bar_chart.dart';
import 'package:digifarm_new/widgets/custom_button.dart';
import 'package:digifarm_new/widgets/table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class DashboardAnalysisScreen extends StatefulWidget {
  const DashboardAnalysisScreen({super.key});

  @override
  State<DashboardAnalysisScreen> createState() =>
      _DashboardAnalysisScreenState();
}

class _DashboardAnalysisScreenState extends State<DashboardAnalysisScreen> {
  bool active = false;
  List<Map<String, String>> npkDataList = [];
  bool isLoading = true;

  PHLevel? phLevelData; // Use nullable type to ensure the variable can be null

  final API_Services apiServices = API_Services();

  @override
  void initState() {
    super.initState();
    fetchNPKData();
    fetchPHData();
  }

  Future<void> fetchPHData() async {
    try {
      phLevelData = await apiServices.fetchPHData(); // Fetch PH data using API_Services
      setState(() {
        isLoading = false; // Set loading to false after data is fetched
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load PH data: $e');
    }
  }



  Future<void> fetchNPKData() async {
    try {
      NPKData npkData = await API_Services().fetchNPKData();
      setState(() {
        npkDataList = [
          {'type': 'Nitrogen Level', 'level': '${npkData.data.nitogenLevel}%'},
          {'type': 'Phosphorus Level', 'level': '${npkData.data.phosphorusLevel}%'},
          {'type': 'Potassium Level', 'level': '${npkData.data.potassiumLevel}%'},
          {'type': 'pH Level', 'level': '${npkData.data.ph}'},
        ];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load NPK data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard and Analysis',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body:
      isLoading
          ? Center(
        child: SpinKitWaveSpinner(
          color: ClrUtils.green,
          size: 50.0,
        ),
      )
          : SingleChildScrollView(
        child: Center(
          child: Container(
            width: ScreenSizeUtil.getWidth(context) * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenSizeUtil.getHeight(context) * 0.02),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'this page is supposed to show water\nlevels present in the soil',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(height: ScreenSizeUtil.getHeight(context) * 0.02),
                isLoading
                    ? Center(
                  child: SpinKitWaveSpinner(
                    color: ClrUtils.green,
                    size: 50.0,
                  ),
                )
                    : Container(
                  height: 380,
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: npkDataList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final npkData = npkDataList[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: npkData == null
                              ? [
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ]
                              : [
                            Text(
                              npkData['level']!,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              npkData['type']!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: Text(
                    'Total PH Levels',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'The graph will basically show the\nph leveks of the soil throughout the\nyears.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                Center(
                  child: Container(
                    child: isLoading
                        ? Center(
                      child: SpinKitWaveSpinner(
                        color: ClrUtils.green,
                        size: 50.0,
                      ),
                    )
                        : phLevelData == null
                        ? Center(child: Text("Failed to load PH data"))
                        : SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <ColumnSeries<SalesData, String>>[
                        ColumnSeries<SalesData, String>(
                          dataSource: phLevelData!.data
                              .map((data) {
                            return SalesData(data.date, data.phValue as double);
                          })
                              .toList(),
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Sensor Status',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        title: Text(
                          'Current Status',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.circle,
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(),
                      ),
                      ListTile(
                        title: Text(
                          'Active',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        trailing: Switch(
                          activeTrackColor: Colors.black38,
                          activeColor: ClrUtils.green,
                          value: active,
                          onChanged: (v) {
                            setState(() {
                              active = v;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return PredictiveAnalysisScreen();
                      }),
                    );
                  },
                  child: CustomButton(
                    width: ScreenSizeUtil.getWidth(context) * 0.9,
                    title: 'Predictive Analysis',
                    color: ClrUtils.green1,
                    textcolor: Colors.black,
                    height: 65,
                    borderRadius: BorderRadius.circular(20),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
