//import 'package:dropdown_search/dropdown_search.dart';
//import 'package:flutter/material.dart';
//
//import '../../drob_dowen_services.dart';
//import '../../drodoen_model.dart';
//
//class DropDownSellerWidget extends StatefulWidget {
//  @override
//  _DropDownSellerWidgetState createState() => _DropDownSellerWidgetState();
//}
//
//class _DropDownSellerWidgetState extends State<DropDownSellerWidget> {
//  var quValue1, quId1;
//
//  @override
//  void initState() {
////    DropDownSearchSellerServices.fetchData();
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder(
//        future: DropDownSearchSellerServices.fetchData(),
//        builder: (context, snapshot) {
//          UserModel myData = snapshot.data;
//          var my = myData.data.data;
//
//     switch (snapshot.connectionState) {
//       case ConnectionState.none:
//         return Text(snapshot.error);
//       case ConnectionState.waiting:
//       case ConnectionState.active:
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//         break;
//       case ConnectionState.done:
//
//    if(snapshot.hasData){
//      return Center(
//        child: Expanded(
//          child: new DropdownButton(
//            items: my.map((item) {
//              return new DropdownMenuItem(
//                child: new Text(item.name),
//                value: item.gender.toString(),
//              );
//            }).toList(),
//            onChanged: (newVal) {
//              setState(() {
//                quValue1 = newVal;
//              });
//            },
//            value: quValue1,
//          ),
//        ),
//      );
//
//    }else{
//
//      return CircularProgressIndicator();
//
//    }
//         break;
//     }
//          return Container();
//        });
//  }
//}
