import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/models/soil_parameter/soil_parameter.dart';
import 'package:digifarm_new/services/api_servises/api_services.dart';
import 'package:digifarm_new/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SoilParaScreen extends StatefulWidget {
  const SoilParaScreen({super.key});

  @override
  State<SoilParaScreen> createState() => _SoilParaScreenState();
}

class _SoilParaScreenState extends State<SoilParaScreen> {
  SoilParameter? soilData; // Made nullable
  bool isLoading = true;
  String? errorMessage;

  final API_Services _apiService = API_Services();

  @override
  void initState() {
    super.initState();
    fetchSoilData();
  }

  // Function to fetch soil data from API
  Future<void> fetchSoilData() async {
    try {
      SoilParameter fetchedData = await _apiService.fetchSoilData();
      setState(() {
        soilData = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Parameters'),
      ),
      body: isLoading
          ? const Center(
        child: SpinKitWaveSpinner(
          color: ClrUtils.green,
          size: 50.0,
        )
            ,
      )
          : errorMessage != null
          ? Center(
        child: Text(
          errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      )
          : soilData == null
          ? const Center(
        child: Text('No data available'),
      )
          : SingleChildScrollView(
        child: Center(
          child: Container(
            width: ScreenSizeUtil.getWidth(context) * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ScreenSizeUtil.getHeight(context) * 0.05,
                ),
                const Center(
                  child: Text(
                    'Soil Parameters',
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'This page is supposed to show soil\nparameters present in the soil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: 4,  // Total number of items
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.green[300],  // Background color
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${soilData!.data.temperature}°',  // Actual data
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Soil Temperature',  // Label
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      case 1:
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.green[300],  // Background color
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${soilData!.data.ph}',  // Actual data
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Soil PH',  // Label
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      case 2:
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.green[300],  // Background color
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${soilData!.data.humidity}%',  // Actual data
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Soil Humidity',  // Label
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      case 3:
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.green[300],  // Background color
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${soilData!.data.conductivity} s/m',  // Actual data
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Soil Conductivity',  // Label
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      default:
                        return SizedBox();
                    }
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


