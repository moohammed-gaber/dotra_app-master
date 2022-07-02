import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        // prefix: SvgPicture.asset(
        //   "assets/icons/search.svg",
        //   height: 2,
        //   width: 2,
        // ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white,
          size: 30,
        ),
        hintText: 'البحث',
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
