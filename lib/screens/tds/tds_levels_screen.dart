import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/models/npk_visualization_model/npk_visualization_model.dart';
import 'package:digifarm_new/services/api_servises/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TdsLevelsScreen extends StatefulWidget {
  const TdsLevelsScreen({super.key});

  @override
  State<TdsLevelsScreen> createState() =>
      _TdsLevelsScreenState();
}

class _TdsLevelsScreenState extends State<TdsLevelsScreen> {

  late Future<NPKVisualization> npkVisualizationFuture;

  @override
  void initState() {
    super.initState();
    npkVisualizationFuture = API_Services().fetchNPKGraphData1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('TDS Levels and Water Quality',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: ScreenSizeUtil.getWidth(context) * 0.9,
            child: Column(
              children: [
                Text(
                    'Based on our predictive analysis, your sunflower crop is expected to yield 3.5 tons per acre this season! 🌞',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: ScreenSizeUtil.getWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    color: ClrUtils.green4, // Background color for the container
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.5), // Shadow color with transparency
                        spreadRadius: 2, // Spread of the shadow
                        blurRadius: 8, // Blur effect
                        offset: Offset(0, 4), // Position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                        16.0), // Add padding to the container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'Current TDS Level \n450 ppm',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height:
                                16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           
                            Text('Your water quality is suitable, but monitor sensitive crops closely.'),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: ScreenSizeUtil.getWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    color: ClrUtils.green4, // Background color
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.5), // Shadow color with transparency
                        spreadRadius: 2, // Spread of the shadow
                        blurRadius: 8, // Blur effect
                        offset: Offset(0, 4), // Position of the shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                        16.0), // Add padding to the container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Impact on Crops',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height:
                                16), // Add spacing between title and first row
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                                'Moderate TDS levels are safe for most crops.'),
                          ],
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                                'High TDS can lead to soil salinity and reduced yield.'),
                          ],
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                                'Regularly monitor soil salinity for optimal growth.'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  width: ScreenSizeUtil.getWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    color: ClrUtils.green4,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'Visualizations',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                            'The visualizations are going to be of NPK levels over the time.'),
                        const SizedBox(height: 30),
                        FutureBuilder<NPKVisualization>(
                          future: npkVisualizationFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: SpinKitWaveSpinner(
                                color: Colors.white,
                                size: 50.0,
                              )
                                      );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final yValues = snapshot.data!.data.yValues;

                              // Prepare chart data with indices (x) and y values
                              final chartData = List.generate(
                                yValues.length,
                                    (index) => ChartData(index, yValues[index]),
                              );

                              return SfCartesianChart(
                                primaryXAxis: NumericAxis(isVisible: false),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(text: 'NPK Levels'),
                                ),
                                series: <LineSeries<ChartData, int>>[
                                  LineSeries<ChartData, int>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    color: Colors.green,
                                    markerSettings: const MarkerSettings(isVisible: true),
                                  ),
                                ],
                              );
                            } else {
                              return const Text('No data available');
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
    //             Container(
    //               width: ScreenSizeUtil.getWidth(context) * 0.9,
    //               decoration: BoxDecoration(
    //                 color: ClrUtils.green4, // Background color for the container
    //                 borderRadius: BorderRadius.circular(12), // Rounded corners
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.grey
    //                         .withOpacity(0.5), // Shadow color with transparency
    //                     spreadRadius: 2, // Spread of the shadow
    //                     blurRadius: 8, // Blur effect
    //                     offset: Offset(0, 4), // Position of the shadow (x, y)
    //                   ),
    //                 ],
    //               ),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(
    //                     16.0), // Add padding to the container
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     SizedBox(height: 10),
    //                     Text(
    //                       'Visualizations',
    //                       style: TextStyle(
    //                         fontSize: 18,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     Text(
    //                         'The visualizations are going to be of NPK levels over the time.'),
    //                  SizedBox(height: 30,),
    //                    SfCartesianChart(
    //   // title: ChartTitle(text: ''),
    //   primaryXAxis: NumericAxis(   interval: 1, // Show more labels on the x-axis
    //     edgeLabelPlacement: EdgeLabelPlacement.shift,),
    //   primaryYAxis: NumericAxis(),
    //   series: <LineSeries<ChartData, int>>[
    //     LineSeries<ChartData, int>(
    //       color: Colors.redAccent,
    //       dataSource: getData(),
    //       xValueMapper: (ChartData data, _) => data.x,
    //       yValueMapper: (ChartData data, _) => data.y1,
    //       markerSettings: MarkerSettings(isVisible: true), // Show markers
    //     ),
    //   ],
    // ),
    //
    //                   ],
    //                 ),
    //               ),
    //             ),
                  SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
class ChartData {
  final int x;  // X-axis value (index)
  final double y;  // Y-axis value (converted to double)

  ChartData(this.x, this.y);
}
