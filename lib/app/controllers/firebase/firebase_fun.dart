import 'dart:io';

import 'package:car_consultant/core/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/models/appointment.dart';
import '../../../core/models/chat_model.dart';
import '../../../core/models/message_model.dart';
import '../../../core/models/review_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/utils/color_manager.dart';
import 'firebase_constants.dart';

class FirebaseFun {
  static FirebaseAuth auth = FirebaseAuth.instance;

  // static final database= FirebaseDatabase.instance.ref();

  // time for waiting request to done or show error message
  static Duration timeOut = Duration(seconds: 50);

  ///--Signup
  static Future<Map<String, dynamic>> signUp(
      {required String email, required String password}) {
    final result = auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(FirebaseHelperFun.onValueSignup)
        .catchError(FirebaseHelperFun.onError)
        .timeout(timeOut, onTimeout: FirebaseHelperFun.onTimeOut);
    return result;
  }



  static fetchUser( {required String uid,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .where('uid',isEqualTo: uid)
        .get()
        .then((onValueFetchUser))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }

  static fetchUserByUserName( {required String userName})  async {
    final result=await FirebaseFirestore.instance.collection(FirebaseConstants.collectionUser)
        .where('userName',isEqualTo: userName)
        .get()
        .then((onValueFetchUserByUserName))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchUserId( {required String id,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .where('id',isEqualTo: id)
        .get()
        .then((onValueFetchUserId))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    //  print("${id} ${result}");
    return result;
  }
  static fetchUserUid( {required String uid,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .where('uid',isEqualTo: uid)
        .get()
        .then((onValueFetchUserId))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }

  static fetchUsers()  async {
    final result=await FirebaseFirestore.instance.collection(FirebaseConstants.collectionUser)
        .get()
        .then((onValueFetchUsers))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }


  static rateProvider( {required String idProvider,required ReviewModel review}) async {
    UserModel? provider;
   await FirebaseFirestore.instance.collection(FirebaseConstants.collectionUser).doc(
        idProvider
    ).get().then((value){
     provider=UserModel.fromJson(value);
    });
    provider?.additionalInfo?.reviews??=[];
    if(provider?.additionalInfo?.reviews?.any((element)=>element.idUser!=review.idUser)??true)
        provider?.additionalInfo?.reviews?.add(review);
    if(provider==null)
      return errorUser("Failure");
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionUser).doc(
        idProvider
    ).
    update(provider!.toJson()).then(onValueRateProvider).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  ///RequestProvider
  static addRequestProvider( {required UserModel provider}) async {
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionRequestProvider)
        .doc(provider.id)
        .set(provider.toJson()).then(onValueAddRequestProvider).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static deleteRequestProvider( {required String idRequestProvider}) async {
    final result =await FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionRequestProvider)
        .doc(idRequestProvider)
        .delete().then(onValueDeleteRequestProvider)
        .catchError(onError);
    return result;
  }
  static updateRequestProvider( {required UserModel provider}) async {
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionRequestProvider).doc(
        provider.id
    ).update(provider.toJson()).then(onValueUpdateRequestProvider).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  // static fetchRequestProvidersByIdUser({required String idUser})  async {
  //   final result=await FirebaseFirestore.instance.collection(FirebaseConstants.collectionRequestProvider)
  //       .where('idUser',isEqualTo: idUser)
  //       .get()
  //       .then((onValueFetchRequestProviders))
  //       .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
  //   return result;
  // }
  //
  //

  ///Appointment
  static addRequestAppointment( {required Appointment appointment}) async {
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionAppointment)
        .doc(appointment.id)
        .set(appointment.toJson()).then(onValueAddAppointment).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static deleteAppointment( {required String idAppointment}) async {
    final result =await FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionAppointment)
        .doc(idAppointment)
        .delete().then(onValueDeleteAppointment)
        .catchError(onError);
    return result;
  }
  static updateAppointment( {required Appointment appointment}) async {
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionAppointment).doc(
        appointment.id
    ).update(appointment.toJson()).then(onValueUpdateAppointment).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }




  ///Chat
  static addChat( {required Chat chat}) async {
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionChat).add(
        chat.toJson()
    ).then(onValueAddChat).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static deleteChat( {required String idChat}) async {
    final result =await FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionChat)
        .doc(idChat)
        .delete().then(onValueDeleteChat)
        .catchError(onError);
    return result;
  }
  static updateChat( {required Chat chat}) async {
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionChat).doc(
        chat.id
    ).update(chat.toJson()).then(onValueUpdateChat).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchChatsByIdUser({required List listIdUser})  async {
    final result=await FirebaseFirestore.instance.collection(FirebaseConstants.collectionChat)
        .where('listIdUser',arrayContains: listIdUser)
        .get()
        .then((onValueFetchChats))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchChatsByListIdUser({required List listIdUser})  async {
    final database = await FirebaseFirestore.instance.collection(FirebaseConstants.collectionChat);
    Query<Map<String, dynamic>> ref = database;

    listIdUser.forEach( (val) => {
      ref = database.where('listIdUser' ,arrayContains: val)
    });
    final result=
    ref
        .get()
        .then((onValueFetchChats))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }

  static addMessage( {required Message message,required String idChat}) async {
    final result =await FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionChat)
        .doc(idChat)
        .collection(FirebaseConstants.collectionMessage).add(
        message.toJson()
    ).then(onValueAddMessage)
        .catchError(onError);
    return result;
  }
  static deleteMessage( {required Message message,required String idChat}) async {
    final result =await FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionChat)
        .doc(idChat)
        .collection(FirebaseConstants.collectionMessage).doc(
        message.id
    ).delete().then(onValueDeleteMessage)
        .catchError(onError);
    return result;
  }
  static fetchLastMessage({required String idChat})  async {
    final result=await FirebaseFirestore.instance.collection(FirebaseConstants.collectionChat)
        .doc(idChat).collection(FirebaseConstants.collectionMessage).orderBy('sendingTime',descending: true).get()
        .then((onValueFetchLastMessage))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }

  ///Notification
  static addNotification( {required NotificationModel notification}) async {
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionNotification).add(
        notification.toJson()
    ).then(onValueAddNotification).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }

  static updateNotification({required NotificationModel notification}) async {
    final result = await FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionNotification)
        .doc(notification.id)
        .update(notification.toJson())
        .then(onValueUpdateNotification)
        .catchError(onError)
        .timeout(timeOut, onTimeout: onTimeOut);
    return result;
  }



  static Future<Map<String,dynamic>>  onError(error) async {
    return {
      'status':false,
      'message':error,
      // 'body':null
    };
  }
  static Future<Map<String,dynamic>>  onTimeOut() async {
    return {
      'status':false,
      'message':'time out',
      //'body':""
    };
  }
  static Future<Map<String,dynamic>>  errorUser(String messageError) async {
    print(false);
    print(messageError);
    return {
      'status':false,
      'message':messageError,
      //'body':""
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUser(value) async{
    // print(true);
    print('uid ${await (value.docs.length>0)?value.docs[0]['uid']:null}');
    print("user : ${(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null}");
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUserByUserName(value) async{
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUserId(value) async{
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUsers(value) async{
    print("Users count : ${value.docs.length}");

    return {
      'status':true,
      'message':'Users successfully fetch',
      'body':value.docs
    };
  }


  static Future<Map<String,dynamic>>onValueRateProvider(value) async{
    return {
      'status':true,
      'message':'successfully review',
      'body':{}
    };
  }

  static Future<Map<String,dynamic>>onValueAddRequestProvider(value) async{
    return {
      'status':true,
      'message':'RequestProvider successfully add',
      'body':{},//{'id':value.id}
    };
  }
  static Future<Map<String,dynamic>>onValueUpdateRequestProvider(value) async{
    return {
      'status':true,
      'message':'RequestProvider successfully update',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchRequestProviders(value) async{
    return {
      'status':true,
      'message':'RequestProvider successfully fetch',
      'body':value.docs
    };
  }
  static Future<Map<String,dynamic>>onValueDeleteRequestProvider(value) async{
    return {
      'status':true,
      'message':'RequestProvider successfully delete',
      'body':{}
    };
  }



  static Future<Map<String,dynamic>>onValueAddAppointment(value) async{
    return {
      'status':true,
      'message':'Appointment successfully add',
      'body':{},//{'id':value.id}
    };
  }
  static Future<Map<String,dynamic>>onValueUpdateAppointment(value) async{
    return {
      'status':true,
      'message':'Appointment successfully update',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchAppointments(value) async{
    return {
      'status':true,
      'message':'Appointment successfully fetch',
      'body':value.docs
    };
  }
  static Future<Map<String,dynamic>>onValueDeleteAppointment(value) async{
    return {
      'status':true,
      'message':'Appointment successfully delete',
      'body':{}
    };
  }



  static Future<Map<String,dynamic>>onValueAddChat(value) async{
    return {
      'status':true,
      'message':'Chat successfully add',
      'body':{'id':value.id}
    };
  }
  static Future<Map<String,dynamic>>onValueUpdateChat(value) async{
    return {
      'status':true,
      'message':'Chat successfully update',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchChats(value) async{
    return {
      'status':true,
      'message':'Chats successfully fetch',
      'body':value.docs
    };
  }
  static Future<Map<String,dynamic>>onValueAddMessage(value) async{
    return {
      'status':true,
      'message':'Message successfully add',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>>onValueDeleteChat(value) async{
    return {
      'status':true,
      'message':'Chat successfully delete',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>>onValueDeleteMessage(value) async{
    return {
      'status':true,
      'message':'Message successfully delete',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchLastMessage(value) async{
    return {
      'status':true,
      'message':'Last message successfully fetch',
      'body':value.docs
    };
  }

  static Future<Map<String,dynamic>>onValueAddNotification(value) async{
    return {
      'status':true,
      'message':'Notification successfully add',
      'body':{}
    };
  }
  static Future<Map<String, dynamic>> onValueUpdateNotification(value) async {
    return {
      'status': true,
      'message': 'Notification successfully update',
      'body': {}
    };
  }




  static String findTextToast(String text){
    String errorMessage='';
    print("error:$text");
    switch(text.toLowerCase()){
      // login
      case "user-not-found":
        errorMessage = "No user found with this email.";
        // errorMessage = "لا يوجد مستخدم لهذا البريد.";
        break;
      case "wrong-password":
        errorMessage = "Incorrect password.";
        // errorMessage = "كلمة السر غير صحيحة.";
        break;
      case "invalid-email":
        // errorMessage = "البريد الالكتروني البدخل غير صالح";
        break;
      case "user-disabled":
        // errorMessage = "المستخدم غير مفعل.";
        break;
      case "too-many-requests":
        errorMessage =
        ".حاولت تسجيل الدخول مرات عديدة، حاول لاحقاً";
        errorMessage="Too many requests";
        break;
      // register
      case "email-already-in-use":
        errorMessage = ".هذا البريد موجود مسبقاً";
        errorMessage="email already in use";
        break;
      case "invalid-email":
        errorMessage = "البريد الالكتروني غير صالح.";
        errorMessage = "Invalid email";
        break;
      case "weak-password":
        errorMessage = "Password is too weak. It must be at least 6 characters long, including at least one uppercase letter, one lowercase letter, and one digit.";
        // errorMessage = "كلمة المرور ضعيفة، يجب أن تحوي 6 محارف، وتتضمن حرف كبير وحرف صغير، وأيضا علامة ترقيم";
        break;
      case "invalid email":
        errorMessage = "البريد الالكتروني غير صالح.";
        errorMessage = "Invalid email";
        break;
      case "invalid-credential":
        errorMessage = "المستخدم غير صحيح.";
        errorMessage = "Invalid credential";
        break;

      case "account successfully logged":
        errorMessage =
        "تم تسجيل الدخول بنجاح";
        errorMessage = "Account successfully logged";
        break;
      case "users successfully fetch":
        errorMessage =
        "تم جلب معلومات المستخدمين بنجاح";
        errorMessage = "Users successfully fetch";
        break;
      case "RequestProvider successfully add":
        errorMessage =
        "تمت إضافة درس بنجاح";
        break;
      case "RequestProvider successfully update":
        errorMessage =
        "تم تحديث الدرس بنجاح";
        break;
      case "RequestProvider successfully fetch":
        errorMessage =
        "تم جلب الدرس بنجاح";
        break;
      case "account successfully created":
        errorMessage =
        "تم انشاء الحساب بنجاح";
        break;
      case "RequestProvider successfully delete":
        errorMessage =
        "تم حذف الجلسة بنجاح";
        break;
      case "":
        errorMessage =
        "";
        break;
      case "":
        errorMessage =
        "";
        break;
      case "":
        errorMessage =
        "";
        break;
      default:
        errorMessage = "An unexpected error occurred. Please try again later.";
        errorMessage = "حصل خطأ، الرجاء المحاولة لاحقاً";
        errorMessage = text;
    }
    print("error trans: $errorMessage");

    // if(text.contains("Password should be at least 6 characters")){
    //   return tr(LocaleKeys.toast_short_password);
    // }else if(text.contains("The email address is already in use by another account")){
    //   return tr(LocaleKeys.toast_email_already_use);
    // }
    // else if(text.contains("Account Unsuccessfully created")){
    //   return tr(LocaleKeys.toast_Unsuccessfully_created);
    // }
    // else if(text.contains("Account successfully created")){
    //    return tr(LocaleKeys.toast_successfully_created);
    // }
    // else if(text.contains("The password is invalid or the user does not have a password")){
    //    return tr(LocaleKeys.toast_password_invalid);
    // }
    // else if(text.contains("There is no user record corresponding to this identifier")){
    //    return tr(LocaleKeys.toast_email_invalid);
    // }
    // else if(text.contains("The email address is badly formatted")){
    //   return tr(LocaleKeys.toast_email_invalid);
    // }
    // else if(text.contains("Account successfully logged")){
    //     return tr(LocaleKeys.toast_successfully_logged);
    // }
    // else if(text.contains("A network error")){
    //    return tr(LocaleKeys.toast_network_error);
    // }
    // else if(text.contains("An internal error has occurred")){
    //   return tr(LocaleKeys.toast_network_error);
    // }else if(text.contains("field does not exist within the DocumentSnapshotPlatform")){
    //   return tr(LocaleKeys.toast_Bad_data_fetch);
    // }else if(text.contains("Given String is empty or null")){
    //   return tr(LocaleKeys.toast_given_empty);
    // }
    // else if(text.contains("time out")){
    //   return tr(LocaleKeys.toast_time_out);
    // }
    // else if(text.contains("Account successfully logged")){
    //   return tr(LocaleKeys.toast);
    // }
    // else if(text.contains("Account not Active")){
    //   return tr(LocaleKeys.toast_account_not_active);
    // }

    return errorMessage;
  }

  static Future uploadImage({required XFile image,  String folder='images'}) async {

    try{
      String path = image.name;
      File file =File(image.path);
      Reference storage = FirebaseStorage.instance.ref().child("${folder}/${path}");
      UploadTask storageUploadTask = storage.putFile(file);
      TaskSnapshot taskSnapshot = await storageUploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    }catch(e){
      String errorMessage;
      errorMessage = "An unexpected error occurred. Please try again later.";
      Get.back();
      Get.snackbar(
          "خطأ",
          errorMessage,
          backgroundColor: ColorManager.errorColor
      );
    }
  }

}

class FirebaseHelperFun {
  static Future<Map<String, dynamic>> onValueSignup(value) async {
    print(true);
    print("uid : ${value.user?.uid}");
    return {
      'status': true,
      'message': 'Account successfully created',
      'body': value.user
    };
  }

  static Future<Map<String, dynamic>> onTimeOut() async {
    print(false);
    return {
      'status': false,
      'message': 'time out',
      //'body':""
    };
  }

  static Future<Map<String, dynamic>> onError(error) async {
    print(false);
    print(error);
    var errorMessage;
    if (error is FirebaseAuthException) {
      errorMessage = error.message ?? "Firebase Authentication Error";
    } else if (error is FirebaseException) {
      errorMessage = error.message ?? "Firebase Error";
    } else {
      errorMessage = error;
    }

    return {
      'status': false,
      'message': errorMessage,
      //'body':""
    };
  }
}
