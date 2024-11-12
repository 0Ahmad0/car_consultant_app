
import 'package:bcrypt/bcrypt.dart';
import 'package:car_consultant/core/models/location_model.dart';
import 'package:car_consultant/core/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/get_color_status_appointments.dart';
import '../utils/app_constant.dart';
import 'file_model.dart';

class Appointment {
  String? id;
  String? idProvider;
  String? idUser;
  String? state;
  DateTime? selectDate;
  int? fee;
  DateTime? fromHour;
  DateTime? toHour;
  ReviewModel? review;

  Appointment({
    this.id,
    this.idProvider,
    this.idUser,
    this.state,
    this.selectDate,
    this.fee,
    this.fromHour,
    this.toHour,
    this.review,
  });

  factory Appointment.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;

    return Appointment(
        id: data['id'],
      idProvider: data["idProvider"],
      idUser: data["idUser"],
      state: data["state"],
        selectDate: data["selectDate"]?.toDate(),
      fee: data["fee"],
      review: data["review"]==null?null:ReviewModel.fromJson(data["review"]),
      fromHour: data["fromHour"]?.toDate(),
      toHour: data["toHour"]?.toDate(),
    );
  }

  factory Appointment.init() {
    return Appointment();
  }

  int? get getState{
    DateTime now=DateFormat.yMd().parse(DateFormat.yMd().format(DateTime.now()));

    if(selectDate==null||state==null)
      return 1;
    DateTime? current=DateFormat.yMd().parse(DateFormat.yMd().format(selectDate!));
    if(now.isBefore(current!)
        ||[ColorAppointments.Canceled.name,ColorAppointments.Concluded.name].contains(state))
      return -1;
    if(now.isAfter(current!)
        ||[ColorAppointments.StartingSoon.name,ColorAppointments.Rescheduled.name].contains(state))
      return 1;
    if(now.isAtSameMomentAs(current!))
      return 0;
    else
      return 1;
  }


  Map<String, dynamic> toJson() {

    return{
      'id': id,
    'idProvider': idProvider,
    'idUser': idUser,
    'fee': fee,
    'state': state,
    'review': review?.toJson(),
    'fromHour':  fromHour==null?null:Timestamp.fromDate(fromHour!),
    'toHour':   toHour==null?null:Timestamp.fromDate(toHour!),
      'selectDate': selectDate==null?null:Timestamp.fromDate(selectDate!),
  };
  }
}

///Appointments
class Appointments {
  List<Appointment> items;



  Appointments({required this.items});

  factory Appointments.fromJson(json) {
    List<Appointment> temp = [];
    for (int i = 0; i < json.length; i++) {
      Appointment tempElement = Appointment.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Appointments(items: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in items) {
      temp.add(element.toJson());
    }
    return {
      'items': temp,
    };
  }
}