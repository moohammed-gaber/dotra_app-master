import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotra/app/screens/home/models/product.dart';
import 'package:dotra/app/screens/product_details/ui.dart';
import 'package:dotra/utilities_mso/setting_mso.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HomeLogic extends ChangeNotifier {
  Future<List> fetchCategoriesFuture;

  HomeLogic() {
    fetchCategoriesFuture = fetchCategories();
  }



  static  Dio dio =Dio();
 static  Future feach_cat()async{


//   HttpClient client = new HttpClient();
//   client.getUrl(Uri.parse("http://www.example.com/"))
//       .then((HttpClientRequest request) {
//     // Optionally set up headers...
//     // Optionally write to the request object...
//     // Then call close.
//     return request.close();
//   })
//       .then((HttpClientResponse response) {
//     // Process the response.
//print(response.reasonPhrase);
//print(response.statusCode);
//
//   });





  Response response=await dio.get("http://hrm.pure-soft.com/api/products/t/ar/1/0");

try{
  print(response.statusCode);

  if(response.statusCode==200){
    print(response.statusCode);
  }else{
    print(response.statusCode);

  }
}on DioError catch (e){
  print(e.message);
   return e.message;
}
  }




  Future<List> fetchCategories() async {
    http.Response response = await http.get(categoriesUrl);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var responseBody = jsonDecode(response.body);
      return responseBody['data'];
    } else {

      print(response.statusCode);
      throw Exception();
    }
  }

  void toProductDetails(BuildContext context, Product product) =>
      Navigator.pushNamed(context, ProductDetailsUiRoot.route,
          arguments: product);
}
