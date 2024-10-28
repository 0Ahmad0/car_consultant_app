
import 'package:bcrypt/bcrypt.dart';
import 'package:car_consultant/core/models/location_model.dart';
import 'package:car_consultant/core/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/app_constant.dart';
import 'file_model.dart';

class EducationResourceModel {
  String? id;
  String? uid;
  String? title;
  String? about;
  String? photoUrl;
  String? urlLink;
  double? review;
  int? numLike;

  EducationResourceModel({
    this.id,
    this.uid,
    this.title,
    this.about,
    this.photoUrl,
    this.urlLink,
    this.review,
    this.numLike,
  });

  factory EducationResourceModel.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;

    return EducationResourceModel(
        id: data['id'],
        uid: data["uid"],
      title: data["title"],
      about: data["about"],
      photoUrl: data["photoUrl"],
      urlLink: data["urlLink"],
      review: data["review"],
      numLike: data["numLike"],
    );
  }

  factory EducationResourceModel.init() {
    return EducationResourceModel();
  }

  Map<String, dynamic> toJson() {

    return{
      'id': id,
    'uid': uid,
    'title': title,
    'about': about,
    'photoUrl': photoUrl,
    'urlLink': urlLink,
    'review': review,
    'numLike': numLike,
  };
  }
}

///EducationResources
class EducationResources {
  List<EducationResourceModel> items;



  EducationResources({required this.items});

  factory EducationResources.fromJson(json) {
    List<EducationResourceModel> temp = [];
    for (int i = 1; i < json.length; i++) {
      EducationResourceModel tempElement = EducationResourceModel.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return EducationResources(items: temp);
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