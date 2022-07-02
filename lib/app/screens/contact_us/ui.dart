import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import 'logic.dart';

class ContactUsUiRoot extends StatelessWidget {
  static const route = '/contact_us';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ContactUsLogic(),
      child: ContactUsUi(),
    );
  }
}

class ContactUsUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('إتصل بنا')),
        body: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, //.horizontal
                  child: Column(
                    children: <Widget>[
                      FormBuilder(
                        initialValue: {
                          'date': DateTime.now(),
                          'accept_terms': false,
                        },
                        child: Column(
                          children: <Widget>[
                            FormBuilderTextField(
                              attribute: "name",
                              decoration: InputDecoration(labelText: "الاسم"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.max(150),
                              ],
                            ),
                            FormBuilderTextField(
                              attribute: "email",
                              decoration: InputDecoration(labelText: "الايميل"),
                              validators: [
                                FormBuilderValidators.email(),
                                FormBuilderValidators.max(150),
                              ],
                            ),
                            FormBuilderPhoneField(
                              attribute: 'phone',
                              decoration: InputDecoration(labelText: "الهاتف"),
                              validators: [
                                FormBuilderValidators.numeric(),
                                FormBuilderValidators.maxLength(14),
                                FormBuilderValidators.minLength(8),
                              ],
                            ),
                            FormBuilderTextField(
                              attribute: "subject",
                              decoration: InputDecoration(labelText: "الموضوع"),
                              validators: [
                                FormBuilderValidators.max(250),
                              ],
                            ),
                            FormBuilderTextField(
                              attribute: "message",
                              maxLines: 3,
                              decoration: InputDecoration(labelText: "الرساله"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.max(300),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35.0),
                      Center(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 4),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.all(19),
                                color: Colors.lightBlueAccent,
                                child: Text('ارســــــــــال ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            ),
                            SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
