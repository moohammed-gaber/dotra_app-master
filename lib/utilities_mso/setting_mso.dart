import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Dio dio =Dio();



String appUrlMso = 'http://hrm.pure-soft.com/api/';
String appUrlUploads = 'http://hrm.pure-soft.com/uploads/';
String appNameMso = 'Dotra App';
double fontSizeMso = 20.0;


// url's
String aboutUrl = appUrlMso + 'static_page/';
String categoriesUrl = appUrlMso + 'categories/t/ar/1/0';
String productsUrl = appUrlMso + 'products/t/ar/1/0';
String productUrl = appUrlMso + 'products/';
String registerUrl = appUrlMso + 'register';
String loginUrl = appUrlMso + 'login';
String userProfileUrl = appUrlMso + 'profile';
String contactUsUrl = appUrlMso + 'contact_us';
String usersRequestsUrl = appUrlMso + 'users_requests';
String notification =appUrlMso +'notifications/t/ar/0/0/0';
String userOrder =appUrlMso +'user_orders';
String userOrderSaved =appUrlMso +'user_orders/t/ar/';
String requestsTypes =appUrlMso +'requests_types/t/ar/1';
//String postRequestsTypes ="https://hrm.pure-soft.com/api/employees_requests";


postRequestsTypes({request_type, fields1, fields2, fields3, fields4}) {
  return appUrlMso +"employees_requests?request_type=$request_type&fields[1]=$fields1&fields[2]=$fields2&fields[3]=$fields3&fields[4]=$fields4";
}


// processing data
class ProcessingData {
  Widget error(String error) {
    return Container(
      child: Center(
        child: Text(error),
      ),
    );
  }

  Widget loading() {
    return Center(child: CircularProgressIndicator());
  }
}
