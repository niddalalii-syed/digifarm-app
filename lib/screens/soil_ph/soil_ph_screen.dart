import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/models/soil_parameter/soil_parameter.dart';
import 'package:digifarm_new/services/api_servises/api_services.dart';
import 'package:digifarm_new/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class SoilPhScreen extends StatefulWidget {
  const SoilPhScreen({super.key});

  @override
  State<SoilPhScreen> createState() => _SoilPhScreenState();
}

class _SoilPhScreenState extends State<SoilPhScreen> {
  SoilParameter? soilData;
  bool isLoading = true;
  String? errorMessage;

  final API_Services _apiService = API_Services();

  @override
  void initState() {
    super.initState();
    fetchSoilData();
  }

  Future<void> fetchSoilData() async {
    try {
      SoilParameter fetchedData = await _apiService.fetchSoilData();
      setState(() {
        soilData = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      log('Error fetching data: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Center(
        child: SpinKitWaveSpinner(
          color: ClrUtils.green,
          size: 50.0,
        ),
      )
          : errorMessage != null
          ? Center(
        child: Text(
          errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      )
          : soilData == null
          ? const Center(
        child: Text('No data available'),
      )
          : SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.05,
              ),
              const Text(
                'Soil PH Levels',
                style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                textAlign: TextAlign.center,
                'This page is supposed to show PH values\npresent in the soil',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
              Image.asset(ImgUtils.phscale),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
              Text(
                '${soilData!.data.ph}',
                style: const TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
              PHScaleWidget(phValue: soilData!.data.ph.toDouble()),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.1,
              ),
              CustomButton(
                title: 'History',
                color: ClrUtils.green,

              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Soil PH Scale Widget
class PHScaleWidget extends StatelessWidget {
  final double phValue;

  const PHScaleWidget({super.key, required this.phValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Container(
          width: 320,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(14, (index) => Text('$index')),
          ),
        ),
        SizedBox(
          height: 50,
          child: CustomPaint(
            size: const Size(330, 50),
            painter: PHScalePainter(phValue: phValue),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 280,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('Strongly\nacidic', textAlign: TextAlign.center),
              SizedBox(width: 20),
              Text('Acidic'),
              SizedBox(width: 10),
              Text('Neutral'),
              SizedBox(width: 40),
              Text('Alkaline'),
            ],
          ),
        ),
      ],
    );
  }
}

class PHScalePainter extends CustomPainter {
  final double phValue;

  PHScalePainter({required this.phValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final gradient = LinearGradient(
      colors: [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue
      ],
      stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height / 2);
    paint.shader = gradient.createShader(rect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(25)),
      paint,
    );

    final clampedPhValue = phValue.clamp(0.0, 14.0); // Ensure value stays within range
    final indicatorX = (clampedPhValue / 14) * size.width;
    paint.shader = null;
    paint.color = Colors.green;
    canvas.drawCircle(Offset(indicatorX, size.height / 4), 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


