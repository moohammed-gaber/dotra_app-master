import 'package:dotra/app/screens/employees_requests/employe_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import 'employe_model.dart';

class EmployeesRequestLogic extends ChangeNotifier {}

class EmployeesRequest extends StatelessWidget {
  static const route = '/contact_us';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => EmployeesRequestLogic(),
      child: EmployeesRequests(),
    );
  }
}





//class EmployeesRequests extends StatelessWidget {
//  static const route = '/EmployeesRequest';
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: FutureBuilder(
//            future: EmployeesRequestServices.fetchRequestsTypes(context),
//            builder: (context, AsyncSnapshot<EmployeesRequiredModel> snapshot) {
//
////              if(snapshot.data.data.from==1){
////                print(snapshot.data.data.from);
////              }
//
//
//              switch (snapshot.connectionState) {
//                case ConnectionState.none:
//                  return Center(
//                      child: Text(
//                        "No Data Found",
//                      ));
//
//                case ConnectionState.waiting:
//                  return Center(
//                    child: CircularProgressIndicator(),
//                  );
//                  break;
//                case ConnectionState.active:
//                case ConnectionState.done:
//                  if (snapshot.hasError) {
//                    Center(child: Text("Erore in get data"));
//                  } else if (!snapshot.hasData) {
//                    Center(child: Text("No date Found"));
//                  } else if (snapshot.hasData) {
//                    EmployeesRequiredModel myDate = snapshot.data;
//                    final myDates = myDate.data.data;
//                    return ListView.builder(
//                        itemCount: myDates.length,
//                        itemBuilder: (context, index) {
//
//
//xxx(){
//  if(myDates[index].name=="اجازة اعتياديه"){
//
//    return Column(children:myDates[index].fields.map((e) {
//
//      if(e.fieldType.toString()=="textarea"){
//        return Text(" textarea");
//      }else{
//        return Text("");
//      }
//    }).toList());
//    return Text("ssssss");
//  }
//
//}
//
//
//                          return xxx();
//                        });
//                  }
//
//                  break;
//              }
//              return Container();
//            }));
//  }
//
//  myListView(mydate) {
//    return ListView.builder(
//      itemBuilder: (context, index) {
//        return Text("data");
//      },
//    );
//  }
//}






class EmployeesRequests extends StatelessWidget {
  List<String> doubleList =
      List<String>.generate(30, (int index) => '${index + 1}');

  final _formKey = GlobalKey<FormBuilderState>();

  static const route = "EmployeesRequest";

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("ارسال طلب اجازة"),),
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              FormBuilderTextField(
                attribute: "reson",
                decoration: InputDecoration(
                    icon: Icon(Icons.border_color), labelText: "سبب الاجازه"),
                validators: [
                  FormBuilderValidators.required(),
                ],
              ),
              FormBuilderImagePicker(
                maxImages: 1,
                validators: [
                  FormBuilderValidators.required(),
                ],
                attribute: "image",
                imageHeight: 50,
                imageWidth: 150,
              ),
              FormBuilderDropdown(
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  icon: Icon(Icons.date_range),
                  hint: Text("عدد ايام الاجازة"),
                  attribute: "dayes",
                  items: doubleList
                      .map((val) =>
                          DropdownMenuItem(value: val, child: Text(val)))
                      .toList()),
              FormBuilderDateTimePicker(
                validators: [
                  FormBuilderValidators.required(),
                ],
                attribute: "dateTime",
                // onChanged: _onChanged,
                inputType: InputType.date,
                decoration: InputDecoration(
                  labelText: 'بداية الاجازة',
                  icon: Icon(Icons.date_range),
                ),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 50)),
                enabled: true,
              ),
              Builder(
                builder: (BuildContext context) => RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();


                        EmployeesRequestServices.ChecktosendRequest(context,  _formKey.currentState.value,);


                      }
                    },
                    child: Text(
                      "ارسال الطلب",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

