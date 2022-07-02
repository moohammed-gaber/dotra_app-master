import 'package:dio/dio.dart';
import 'package:dotra/app/screens/cart/logic.dart';
import 'package:dotra/app/screens/cart/ui/widgets/drobDowen_seller.dart';
import 'package:dotra/app/screens/login/models/user.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '';
import '../../drob_dowen_services.dart';
import '../../drodoen_model.dart';
class NoteDialog extends StatefulWidget {
  final BuildContext contextt;
  const NoteDialog(this.contextt);

  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  @override
  Widget build(BuildContext context) {
    CartLogic logic = Provider.of(widget.contextt);
    print('heellooo');
    return AlertDialog(
      title: Text('الملاحظات على الطلب'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropDownSellerWidget(),
            Text('دون ملاحظاتك فى هذا الحقل او اتركه فارغاً'),
            Stack(
              children: [
                TextField(
                  controller: logic.noteTextFieldController,
                  decoration: InputDecoration(),
                  onChanged: logic.onChangedNote,
                ),
                Visibility(
                  visible: logic.isClearButtonVisible,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          icon: Icon(Icons.clear), onPressed: logic.clearNote)),
                )
              ],
            )
          ],
        ),
      ),
      actions: [
        Builder(
            builder: (context) => FlatButton(
                  onPressed: () => logic.submitNoteDialog(widget.contextt),
                  child: Text('تأكيد'),
                )),
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text('إلغاء'))
      ],
    );
  }
}

var counteryId;
var countryValue;
class DropDownSellerWidget extends StatefulWidget {
  @override
  _DropDownSellerWidgetState createState() => _DropDownSellerWidgetState();
}

class _DropDownSellerWidgetState extends State<DropDownSellerWidget> {
  @override
  Widget build(BuildContext context) {
    return                        DropdownSearch<Datum>(
      showSearchBox: true,
      emptyBuilder: (context, searchEntry) => Center(child: Text("لايوجد تاجر بهذا الاسم")),
      hint: "برجاء ادخال اسم التاجر",
      mode: Mode.BOTTOM_SHEET,
      validator: (Datum u) =>
      u == null ? "user field is required " : null,
      onFind: (String filter) =>DropDownSearchSellerServices.feachData(),
      onChanged: (Datum data) {
        print(data);
        print(data.id);
      },
    );
  }
}
