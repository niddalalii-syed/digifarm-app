// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/widgets/percentage_indicator.dart';
import 'package:flutter/material.dart';
//
// class NpkLevelsWidget extends StatelessWidget {
//   final String chemicalName;
//   const NpkLevelsWidget({
//     Key? key,
//     required this.chemicalName,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 300,
//       width: ScreenSizeUtil.getWidth(context) * 0.9,
//      decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF1B3E2D), // Dark green
//                   Color(0xFF666666), // Gray
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   spreadRadius: 2,
//                   blurRadius: 10,
//                   offset: Offset(0, 4), // Shadow position
//                 ),
//               ],
//             ),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 30,
//           ),
//           Row(children: [
//             PercentageIndicator(
//               height1: 130,
//               width1: 130,
//               height: 110,
//               width2: 60,
//               width: 160,
//               height2: 60,
//               color: ClrUtils.darkblue.withBlue(70),
//               barBg: ClrUtils.darkblue,
//               percentage: 55,
//             ),
//             Column(children: [
//               Text('7459.6789 mg/L',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
//                Text('30% less than last\nreading',textAlign: TextAlign.center ,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
//             ],)
//           ]),
//           SizedBox(height: 20,),
//           Container(
//             decoration: BoxDecoration(color: ClrUtils.green1,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
//             height: 52,
//             child: Center(child: Text(chemicalName,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
//           )
//         ],
//       ),
//     );
//   }
// }
