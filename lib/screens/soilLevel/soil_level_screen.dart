import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/models/soil_c02_level/soil_c02_level.dart';
import 'package:digifarm_new/services/api_servises/api_services.dart';
import 'package:digifarm_new/widgets/custom_button.dart';
import 'package:digifarm_new/widgets/table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SoilLevelScreen extends StatefulWidget {
  const SoilLevelScreen({super.key});

  @override
  State<SoilLevelScreen> createState() => _SoilLevelScreenState();
}

class _SoilLevelScreenState extends State<SoilLevelScreen> {

  final API_Services _apiService = API_Services();  // Initialize your ApiService


  late Future<C02Data> _co2Data;

  @override
  void initState() {
    super.initState();
    _co2Data = API_Services().fetchCO2Data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            // color: Colors.amber,
            width: ScreenSizeUtil.getWidth(context) *0.9,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(
                  child: Text(
                    'Soil CO2 Levels',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'this page is supposed to show carbon\nlevels present in the soil',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: ScreenSizeUtil.getHeight(context) * 0.02,
                ),

                FutureBuilder<C02Data>(
                  future: _apiService.fetchCO2Data(), // Call your existing function
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: SpinKitWaveSpinner(
                        color: ClrUtils.green,
                        size: 50.0,
                      )
                              );
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (snapshot.hasData) {
                      C02Data co2Data = snapshot.data!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${co2Data.data.avgValue}',

                                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'PPM',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          TableWidget(
                            data: co2Data.data.data,
                          ),
                        ],
                      );
                    }

                    return Center(child: Text('No data available'));
                  },
                ),


              ],
              
            ),
          ),
        ),
      ),
    );
  }
}

class TableWidget extends StatelessWidget {
  final List<DataItem> data;  // Accepting List<DataItem> as input

  const TableWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('CO2 Level')),
      ],
      rows: data.map((dataItem) {
        return DataRow(cells: [
          DataCell(Text(dataItem.status ?? 'Unknown')),
          DataCell(Text(dataItem.value.toString())),
        ]);
      }).toList(),
    );
  }
}
