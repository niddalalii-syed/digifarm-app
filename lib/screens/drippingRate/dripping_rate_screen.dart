import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:flutter/material.dart';

class DrippingRateScreen extends StatefulWidget {
  const DrippingRateScreen({super.key});

  @override
  State<DrippingRateScreen> createState() => _DrippingRateScreenState();
}

class _DrippingRateScreenState extends State<DrippingRateScreen> {
  bool power = false;
   bool field1 = false;
    bool field2 = false;
     bool field3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
              'Dripping Rate',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
         
                      SizedBox(
                      height: 40,),
              Container(
                height: 180,
                width: ScreenSizeUtil.getWidth(context) * 0.9,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(ImgUtils.dalda),
                        fit: BoxFit.fill)),
              ),
           
                      SizedBox(
                      height: 20,),
              Text(
                'Power Controls',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
               SizedBox(
                      height: 20,),
              Container(
                width: ScreenSizeUtil.getWidth(context) * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ClrUtils.greenbg.withOpacity(0.7)),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      SizedBox(
                      height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Power',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Colors.white),
                        ),
                        Switch(
                            activeTrackColor: Colors.black38,
                            activeColor: ClrUtils.green,
                            
                            value: power,
                            onChanged: (v) {
                              setState(() {
                                power = v;
                              });
                            })
                      ],
                    ),
                      SizedBox(
                      height: 20,),
                    Center(
                      child: Container(
                        width: ScreenSizeUtil.getWidth(context) * 0.7,
                        height: 65,
                        decoration: BoxDecoration(color: ClrUtils.green1,borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12,right: 12),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Field 1',style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold  ),),
                              Switch(
                                  activeTrackColor: Colors.black38,
                                  activeColor: ClrUtils.green,
                                  
                                  value: field1,
                                  onChanged: (v) {
                                    setState(() {
                                      field1 = v;
                                    });
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,),
                      Center(
                      child: Container(
                        width: ScreenSizeUtil.getWidth(context) * 0.7,
                        height: 65,
                        decoration: BoxDecoration(color: ClrUtils.green1,borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12,right: 12),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Field 2',style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold  ),),
                              Switch(
                                  activeTrackColor: Colors.black38,
                                  activeColor: ClrUtils.green,
                                  value: field2,
                                  onChanged: (v) {
                                    setState(() {
                                      field2 = v;
                                    });
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,),
                      Center(
                      child: Container(
                        width: ScreenSizeUtil.getWidth(context) * 0.7,
                        height: 65,
                        decoration: BoxDecoration(color: ClrUtils.green1,borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12,right: 12),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Field 3',style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold  ),),
                              Switch(
                                  activeTrackColor: Colors.black38,
                                  activeColor: ClrUtils.green,
                                  value: field3,
                                  onChanged: (v) {
                                    setState(() {
                                      field3 = v;
                                    });
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
