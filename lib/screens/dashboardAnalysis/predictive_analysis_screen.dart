import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/models/npk_graph/npk_graph.dart';
import 'package:digifarm_new/models/predictive_analysis/predictive_analysis.dart';
import 'package:digifarm_new/services/api_servises/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PredictiveAnalysisScreen extends StatefulWidget {
  const PredictiveAnalysisScreen({super.key});

  @override
  State<PredictiveAnalysisScreen> createState() =>
      _PredictiveAnalysisScreenState();
}

class _PredictiveAnalysisScreenState extends State<PredictiveAnalysisScreen> {

  PredictiveAnalysisData? predictiveAnalysisData; // Nullable type
  NPKGraphData? npkGraphData; // Nullable type
  bool isLoading = true; // Loading state

  final API_Services apiServices = API_Services(); // Instance of API service

  @override
  void initState() {
    super.initState();
    fetchPredictiveAnalysisData(); // Fetch the data when screen loads
    fetchNPKGraphData(); // Fetch the data when the screen loads
  }

  // Function to fetch the data from API
  Future<void> fetchPredictiveAnalysisData() async {
    try {
      predictiveAnalysisData = await apiServices.fetchPredictiveAnalysisData(); // Fetch the predictive analysis data
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load predictive analysis data');
    }
  }

  // Function to fetch the NPK Graph data
  Future<void> fetchNPKGraphData() async {
    try {
      npkGraphData = await apiServices.fetchNPKGraphData(); // Fetch the NPK data
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load NPK graph data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Predictive Analysis',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body:isLoading
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
              children: [
                if (predictiveAnalysisData != null) ...[
                  Text(
                    'Based on our predictive analysis, your sunflower crop is expected to yield 3.5 tons per acre this season! 🌞',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: ScreenSizeUtil.getWidth(context) * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Summary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Yield Expected:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(predictiveAnalysisData?.yeildExpected ?? "N/A"), // Null check
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Soil Health:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(predictiveAnalysisData?.soilHealth ?? "N/A"), // Null check
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date Range:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Last 7 Days'),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 10),
                Container(
                  width: ScreenSizeUtil.getWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Key Predictions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Crop Yield Prediction:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(predictiveAnalysisData?.yeildPredicted ?? "N/A"), // Null check
                          ],
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fertilizer Recommendation:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(predictiveAnalysisData?.fertilizerRecommendation ?? "N/A"), // Null check
                          ],
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Irrigation Schedule:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'Water needed in 2 days (Estimated: 100 liters/acre).'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (npkGraphData != null) ...[
                  Container(
                    width: ScreenSizeUtil.getWidth(context) * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NPK Levels Over Time',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          SfCartesianChart(
                            primaryXAxis: NumericAxis(),
                            primaryYAxis: NumericAxis(
                              minimum: 0,
                              maximum: 200,
                              interval: 50,
                            ),
                            series: <LineSeries<ChartData, int>>[
                              LineSeries<ChartData, int>(
                                dataSource:
                                getChartData(npkGraphData!.nitrogen),
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                name: 'Nitrogen',
                                markerSettings:
                                MarkerSettings(isVisible: true),
                              ),
                              LineSeries<ChartData, int>(
                                dataSource:
                                getChartData(npkGraphData!.phosphorus),
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                name: 'Phosphorus',
                                markerSettings:
                                MarkerSettings(isVisible: true),
                              ),
                              LineSeries<ChartData, int>(
                                dataSource:
                                getChartData(npkGraphData!.potassium),
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                name: 'Potassium',
                                markerSettings:
                                MarkerSettings(isVisible: true),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<ChartData> getChartData(List<double> values) {
    return List.generate(values.length, (index) {
      return ChartData(index, values[index]);
    });
  }
}




class ChartData {
  final int x;
  final double y;

  ChartData(this.x, this.y);
}