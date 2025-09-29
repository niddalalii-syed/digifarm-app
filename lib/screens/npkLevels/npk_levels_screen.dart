import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/models/nkp_levels/nkp_levels_model.dart';
import 'package:digifarm_new/services/api_servises/api_services.dart';
import 'package:digifarm_new/widgets/npk_levels_widget.dart';
import 'package:digifarm_new/widgets/percentage_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NpkLevelsScreen extends StatefulWidget {
  const NpkLevelsScreen({super.key});

  @override
  State<NpkLevelsScreen> createState() => _NpkLevelsScreenState();
}

class _NpkLevelsScreenState extends State<NpkLevelsScreen> {
  NKPLevels? npkLevels; // Make it nullable
  bool isLoading = true;
  String? errorMessage; // Store error messages

  final API_Services _apiService = API_Services();

  @override
  void initState() {
    super.initState();
    fetchNpkLevels();
  }

  Future<void> fetchNpkLevels() async {
    try {
      NKPLevels fetchedData = await _apiService.fetchNpkLevels();
      setState(() {
        npkLevels = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching NPK levels: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'NPK Levels Monitor',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(child: SpinKitWaveSpinner(
        color: ClrUtils.green,
        size: 50.0,
      )
              )
          : errorMessage != null
          ? Center(
        child: Text(
          errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      )
          : npkLevels == null
          ? const Center(child: Text('No data available'))
          : SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NpkLevelsWidget(
                chemicalName: 'Nitrogen (N)',
                level: npkLevels!.data.nitrogen.toDouble(),
                description: npkLevels!.data.nitrogenDescription,
                percentageChange:
                npkLevels!.data.nitogenLevel,
              ),
              const SizedBox(height: 20),
              NpkLevelsWidget(
                chemicalName: 'Phosphorus (P)',
                level: npkLevels!.data.phosphorus.toDouble(),
                description:
                npkLevels!.data.phosphorusDescription,
                percentageChange:
                npkLevels!.data.phosphorusLevel,
              ),
              const SizedBox(height: 20),
              NpkLevelsWidget(
                chemicalName: 'Potassium (K)',
                level: npkLevels!.data.potassium.toDouble(),
                description:
                npkLevels!.data.potassiumDescription,
                percentageChange:
                npkLevels!.data.potassiumLevel,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}



/// Widget
class NpkLevelsWidget extends StatelessWidget {
  final String chemicalName;
  final double level;
  final String description;
  final double percentageChange;

  const NpkLevelsWidget({
    Key? key,
    required this.chemicalName,
    required this.level,
    required this.description,
    required this.percentageChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSizeUtil.getWidth(context) * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Color(0xFF1B3E2D), // Dark green
            Color(0xFF666666), // Gray
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          Row(
            children: [
              PercentageIndicator(
                height1: 130,
                width1: 130,
                height: 110,
                width2: 60,
                width: 160,
                height2: 60,
                color: ClrUtils.darkblue.withBlue(70),
                barBg: ClrUtils.darkblue,
                percentage: percentageChange,
              ),
              Column(
                children: [
                  Text(
                    '${level} mg/L',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$percentageChange% less than last\nreading',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(color: ClrUtils.green1, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
            height: 52,
            child: Center(
              child: Text(
                chemicalName,
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
