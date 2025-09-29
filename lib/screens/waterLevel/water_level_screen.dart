import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/models/water_level/water_level_model.dart';
import 'package:digifarm_new/services/api_servises/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaterLevelScreen extends StatefulWidget {
  const WaterLevelScreen({super.key});

  @override
  State<WaterLevelScreen> createState() => _WaterLevelScreenState();
}

class _WaterLevelScreenState extends State<WaterLevelScreen> {

  late Future<WaterLevel> futureWaterLevel; // Declare future variable for fetching data

  @override
  void initState() {
    super.initState();
    futureWaterLevel = API_Services().fetchWaterLevelData(); // Initialize the futureWaterLevel field
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                'Water Levels',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                textAlign: TextAlign.center,
                'this page is supposed to show water\nlevels present in the soil',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
              Image.asset(ImgUtils.drop),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),

              FutureBuilder<WaterLevel>(
                future: futureWaterLevel,
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
                    WaterLevel waterLevel = snapshot.data!;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${waterLevel.data.avgValue}',
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Liter/min',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        TableWidget(data: waterLevel.data.data), // Pass data to TableWidget
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
    );
  }
}

class TableWidget extends StatelessWidget {
  final List<WaterDataItem> data;

  const TableWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Water Level')),
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
