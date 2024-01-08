
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
UserModel? usermodel;
class UserModel{
  String? userName;
  int? userAge;
  DocumentReference? ref;
  String? uid;
  DateTime? createDate;
  UserModel({
    required this.userName,
    required this.userAge,
    this.ref,
    this.uid,
    required this.createDate
  });
  UserModel.fromJson(Map<String,dynamic>Json){
    userName =Json['userName']??'';
    userAge =Json['age']??0;
    uid =Json['uid']??'';
    ref =Json['ref'];
    createDate=Json["createDate"]==null?DateTime.now():Json["createDate"].toDate();
  }
  Map<String,dynamic>toJson(){
    final Map<String,dynamic>data=<String,dynamic>{};
    data['userName']=userName;
    data['age']=userAge;
    data['createDate']=createDate;
    data['uid']=uid;
    data['ref']=ref;
    return data;

  }
  UserModel copyWith(
      {
        String? userName,
        int? userAge,
        String? userPhoneNumber,
        String? uid,
        DocumentReference? ref,
        DateTime? createDate,
      }
      )
  {
    return UserModel(userName:userName?? this.userName,
        userAge:userAge?? this.userAge ,
        createDate:createDate?? this.createDate,
        ref: ref?? this.ref,
        uid: uid?? this.uid );
  }
}