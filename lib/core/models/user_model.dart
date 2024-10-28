
import 'package:bcrypt/bcrypt.dart';
import 'package:car_consultant/core/models/location_model.dart';
import 'package:car_consultant/core/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/app_constant.dart';
import 'file_model.dart';

class AdditionalInfoModel {
  String? id;
  String? uid;
  String? name;
  String? workShopName;
  String? about;
  List<FileModel>? files;
  List<ReviewModel>? reviews;
  LocationModel? location;
  String? fee;
  String? expertise;
  String? status;
  DateTime? dateTime;
  bool? repairServices;
  bool? inspectionDiagnostics;

  AdditionalInfoModel({
    this.id,
    this.uid,
    this.name,
    this.workShopName,
    this.files,
    this.about,
    this.reviews,
    this.location,
    this.fee,
    this.expertise,
    this.status,
    this.dateTime,
    this.repairServices,
    this.inspectionDiagnostics,

  });

  factory AdditionalInfoModel.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
    List<FileModel> tempList = [];
    List<ReviewModel> tempListReviews = [];
    for(var file in data["files"]){
      tempList.add(FileModel.fromJson(file));
    }
    for(var review in data["reviews"]){
      tempListReviews.add(ReviewModel.fromJson(review));
    }

    return AdditionalInfoModel(
        id: data['id'],
        uid: data["uid"],
        name: data["name"],
      workShopName: data["workShopName"],
      files: tempList,
      about: data["about"],
      reviews: tempListReviews,
      location: data["location"]==null?null:LocationModel.fromJson( data["location"]),
      fee: data["fee"],
      expertise: data["expertise"],
      status: data["status"],
      repairServices: data["repairServices"],
      inspectionDiagnostics: data["inspectionDiagnostics"],
      dateTime: data["dateTime"]?.toDate(),
    );
  }

  factory AdditionalInfoModel.init() {
    return AdditionalInfoModel();
  }

  Map<String, dynamic> toJson() {

    List<Map<String, dynamic>> tempList = [];
    List<Map<String, dynamic>> tempListReviews = [];
    for(FileModel file in files??[]){
      tempList.add(file.toJson());
    }
    for(ReviewModel review in reviews??[]){
      tempListReviews.add(review.toJson());
    }

    return{
      'id': id,
    'uid': uid,
    'name': name,
    'workShopName': workShopName,
    'files': tempList,
    'about': about,
    'reviews': tempListReviews,
    'location': location?.toJson(),
    'fee': fee,
    'expertise': expertise,
    'status': status,
    'inspectionDiagnostics': inspectionDiagnostics,
    'repairServices': repairServices,
    'dateTime': dateTime==null?null:Timestamp.fromDate(dateTime!),

  };
  }
}


class UserModel {
  String? id;
  String? uid;
  String? name;
  String? userName;
  String? photoUrl;
  String? phoneNumber;
  String? email;
  String? password;
  String? typeUser;
  String? gender;
  bool isAdd = false;
  AdditionalInfoModel? additionalInfo;

  bool get isAdmin=>typeUser?.toLowerCase().contains(AppConstants.collectionAdmin.toLowerCase())??false;

  UserModel({
    this.id,
    this.uid,
    this.name,
    this.userName,
    this.email,
    this.photoUrl,
    this.phoneNumber,
    this.password,
    this.typeUser,
    this.gender,
    this.additionalInfo,
  });

  factory UserModel.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
    String name =
        json["name"] ?? '${json["firstName"] ?? ''} ${json["lastName"] ?? ''}';
    return UserModel(
      id: json['id'],
      uid: json["uid"],
      name: json["name"],
      phoneNumber: json["phoneNumber"],
      // userName: json["userName"],
      email: json["email"],
      photoUrl: json["photoUrl"],
      typeUser: json["typeUser"],
      // gender: data["gender"],
       password:data['password'],
        additionalInfo:data['additionalInfo']==null?null:AdditionalInfoModel.fromJson(data['additionalInfo'])
    );
  }

  factory UserModel.init() {
    return UserModel(
      id: "",
      uid: '',
      name: '',
      email: '',
      typeUser: '',
    //  password: ''
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'name': name,
        'email': email,
        // 'userName': userName,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
        'typeUser': typeUser,
        // 'gender': gender,
    'password': password==null?null:BCrypt.hashpw(password!, BCrypt.gensalt()),
    // 'password': password,
    'additionalInfo': additionalInfo?.toJson(),
      };
  /// Function to check if the password matches the hashed password
  bool checkPassword(String plainPassword) {
    return BCrypt.checkpw(plainPassword, password??'');
  }
}



//users
class Users {
  List<UserModel> users;

  //DateTime date;

  Users({required this.users});

  factory Users.fromJson(json) {
    List<UserModel> tempUsers = [];

    for (int i = 0; i < json.length; i++) {
      UserModel tempUser = UserModel.fromJson(json[i]);
      tempUser.id = json[i].id;
      tempUsers.add(tempUser);
    }
    return Users(users: tempUsers);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tempUsers = [];
    for (UserModel user in users) {
      tempUsers.add(user.toJson());
    }
    return {
      'users': tempUsers,
    };
  }
}
