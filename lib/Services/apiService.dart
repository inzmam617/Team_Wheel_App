import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;

import '../model/InstallmentConfiguration.dart';
import '../model/makecAR.dart';
import '../model/viewCarModel.dart';
import '../utils/constant.dart';

class ApiServices {

  static Future<String> signInAPi(String email) async {
    String URL = "${apiUrl}SignIn";
    var data={
      "Email": email,
    };
    print(data);
    final response = await http.post(Uri.parse(URL), body: data,);
    final String res=response.body;
    if(response.body!='null') {
      Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
      try {
        if (response.statusCode == 200){
          if(jsonData['Status']=="success"){
            return jsonData['Data']['FullName'];
          }
          else if(jsonData['Status']=="error"&&jsonData['Message']=="Email not found"){
            return "error1";
          }
        }
      } catch (e) {
      }
    }
    return "error";
  }

  static Future<String> signUpAPi(String email,String name) async {
    String URL = "${apiUrl}SignUp";
    var data={
      "Email": email,
      "FullName": name
    };
    final response = await http.post(Uri.parse(URL), body: data,);
    final String res=response.body;
    if(response.body!='null') {
      Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
      try {
        if (response.statusCode == 200){
          if(jsonData['Status']=="success"){
            return "success";
          }
          else if(jsonData['Status']=="error"&&jsonData['Message']=="Email already exist"){
            return "error1";
          }
        }
      } catch (e) {
      }
    }
    return "error";
  }

  static Future<String> installmentResult(String salary,String autoLease,String personalLoan,String mortgageLoan,String creditcardLimit) async {
    String URL = "${apiUrl}InstallmentResult";
    var data={
      "salary":salary,
      "auto_lease":autoLease,
      "personal_loan":personalLoan,
      "mortgage_loan":mortgageLoan,
      "credit_card_limit":creditcardLimit,
    };
    final response = await http.post(Uri.parse(URL), body: data,);
    final String res=response.body;
    if(response.body!='null') {
      Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
      try {
        if (response.statusCode == 200){
          print(jsonData);
          print(jsonData['installment']);
          return jsonData['installment'];
        }
      } catch (e) {
      }
    }
    return "error";
  }

  static Future<String> verifyOpt(String email,String code) async {
    String URL = "${apiUrl}VerifyOTP";
    var data={
      "Email":email,
      "Code":code,
    };
    print(data);
    final response = await http.post(Uri.parse(URL), body: data,);
    final String res=response.body;
    if(response.body!='null') {
      Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
      try {
        if (response.statusCode == 200&&jsonData['Status']=="success"){
          return jsonData['Status'];
        }
      } catch (e) {
      }
    }
    return "error";
  }

  static Future<InstallmentConfig> InstallmentConfiguration() async {
    String URL = "${apiUrl}InstallmentConfiguration";
    final uri = Uri.parse("$URL?pageNo=0&pageRow=10");
    final response = await http.get(uri);
    final String res=response.body;
    if(response.body!='null') {
      print(response.body);
      Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
      try {
        if (response.statusCode == 200&&jsonData['Status']=="success"){
        return InstallmentConfig.fromJson(jsonData);
        }
      } catch (e) {

      }
    }
    List<Data> data=[];
    return InstallmentConfig(status: " ", data: data, message: " ", totalPage: 0, totalRecords: 0, next: false, previous: false, currentPage: 0);
  }

  static Future<viewCarModel> LoadVehicle(String installment) async {
    String URL = "${apiUrl}LoadVehicle";
    final uri = Uri.parse("$URL?pageNo=0&pageRow=50&monthlyInstallment=$installment&makeId=0&highlow=1");
    final response = await http.get(uri);
    final String res=response.body;
    if(response.body!='null') {
      Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
      try {
        if (response.statusCode == 200&&jsonData['Status']=="success"){
          return viewCarModel.fromJson(jsonData);
        }
      } catch (e) {

      }
    }
    List<Dataa> data=[];
    return viewCarModel(status: " ", data: data, message: " ", totalPage: 0, totalRecords: 0, next: false, pervious: false, currentPage: 0);
  }

  static Future<List<makeCar>> makeList(String installment) async {
    String URL = "${apiUrl}MakeList";
    final uri = Uri.parse(URL);
    final response = await http.get(uri);
    final String res=response.body;
    if(response.body!='null') {
      Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
      try {
        if (response.statusCode == 200){
          List<makeCar> makeCarList = (jsonData as List)
              .map((car) => makeCar.fromJson(car))
              .toList();
          return makeCarList;
        }
      } catch (e) {

      }
    }
    return [];
  }


}