

import 'dart:io';

import 'package:car_consultant/app/controllers/profile_controller.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/models/location_model.dart';
import 'package:car_consultant/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../../core/widgets/constants_widgets.dart';

import '../../core/models/file_model.dart';
import '../../core/routing/routes.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';


class RequestProviderController extends GetxController{
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController ;
  late TextEditingController workshopNameController ;
  late TextEditingController aboutController ;
  late TextEditingController feeController ;
  late TextEditingController locationController ;
  late bool repairServices;
  late bool inspectionDiagnostics;


  String? uid;
  UserModel? user;
  UserModel? provider;
  int currentProgress=0;
  int fullProgress=0;

  @override
  void onInit() {
    provider=UserModel.init();
    ProfileController profileController=Get.put(ProfileController());
    uid= profileController.currentUser.value?.uid;
    user= profileController.currentUser.value;


    nameController=TextEditingController( );
    workshopNameController=TextEditingController( );
    aboutController=TextEditingController( );
    locationController=TextEditingController( );
    feeController=TextEditingController( );
    repairServices=false;
    inspectionDiagnostics=false;
    super.onInit();
    }


  addRequestProvider(BuildContext context,{bool withUserId=true}) async {
    // ConstantsWidgets.showProgress(progress);
    _calculateProgress(provider?.additionalInfo?.files?.length??0);
    Get.dialog(
      GetBuilder<RequestProviderController>(
          builder: (RequestProviderController controller) =>
              ConstantsWidgets.showProgress(controller.currentProgress/controller.fullProgress)
      ),
      barrierDismissible: false,
    );

    // String description=descriptionController.value.text;
    String id= '${user?.name}00000'.substring(0,5)+'${Timestamp.now().microsecondsSinceEpoch}';
    List<FileModel> files=[];
    for(FileModel fileModel in provider?.additionalInfo?.files??[]){
      if(fileModel.localUrl?.isNotEmpty??false){
        fileModel.url=await FirebaseFun.uploadImage(image:XFile(fileModel.localUrl??''),folder: FirebaseConstants.collectionRequestProvider+'/$id');
        if(fileModel.url!=null){
          files.add(fileModel);
        }
      }
      _plusProgress();
    }
    // String? imagePath;
    // if(image!=null){
    //   imagePath=await FirebaseFun.uploadImage(image:image,folder: FirebaseConstants.collectionPerson+'/$name');
    // }
    UserModel userModel=UserModel.fromJson(user?.toJson());
    userModel.additionalInfo=AdditionalInfoModel(
      uid: id,
      files: files??[],
      reviews: [],
        dateTime:DateTime.now(),
        name:nameController.value.text,
        workShopName:workshopNameController.value.text,
        about:aboutController.value.text,
        location:LocationModel(address: locationController.value.text),
        fee:feeController.value.text,
      repairServices: repairServices,
      inspectionDiagnostics: inspectionDiagnostics
    );
      // id: id,
      // description: descriptionController.value.text,
      // files: files??[],
      // locations: problem?.locations??[],
      // sendingTime: DateTime.now(),
      // idUser: withUserId?uid:null,

    // );
    var result=await FirebaseFun.addRequestProvider(provider:userModel);

    ConstantsWidgets.closeDialog();
    if(result['status']){
      provider=userModel;
      context.pushNamed(
          Routes.paymentSuccessfulRoute);
      // Get.back();
      // Get.back();
    }
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    return result;
  }
  addFile(XFile file,{PlatformFile? platformFile,String type=""}) async {
    provider?.additionalInfo?.files?.add(FileModel(
      name: file.name,
      localUrl: file.path,
      size:platformFile?.size?? await file.length(),
      type: type,
      subType:platformFile?.extension?? file.path.split('/').last.split('.').last
    ));
    update();
  }
  // addLocation({required double longitude,required double latitude,String? address}) async {
  //   problem?.locations?.add(LocationModel(
  //     latitude:latitude ,
  //     longitude: longitude,
  //     address: address,
  //     dateTime: DateTime.now()
  //   ));
  //
  //
  //   update();
  // }
  removeFile(FileModel? file) async {
    provider?.additionalInfo?.files?.remove(file);
    update();
  }
  // removeLocation(LocationModel location) async {
  //   problem?.locations?.remove(location);
  //   update();
  // }

  _calculateProgress(int length){
    currentProgress=0;
    fullProgress=1;
    fullProgress+=length;
    update();
  }
  _plusProgress(){
    currentProgress++;
    if(currentProgress>fullProgress)
      currentProgress=fullProgress;
    update();
  }
  // updatePerson(context,{ XFile? image}) async {
  //   ConstantsWidgets.showLoading();
  //
  //   String name=nameController.value.text;
  //
  //   String? imagePath;
  //   if(image!=null){
  //     imagePath=await FirebaseFun.uploadImage(image:image,folder: FirebaseConstants.collectionPerson+'/$name');
  //   }
  //
  //   person?.name=name;
  //   person?.description= descriptionController.value.text;
  //  person?.imagePath=imagePath??person?.imagePath;
  //   person?.phoneNumber=phoneNumberController.value.text;
  //   person?.email=emailController.value.text;
  //   var
  //   result=await FirebaseFun.updatePerson(person:person!);
  //   ConstantsWidgets.closeDialog();
  //   // if(result['status'])
  //   //   Get.back();
  //   ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
  //   return result;
  // }
  //


  // updateClassRoom(context,{required ClassRoomModel classRoom}) async {
  //   ConstantsWidgets.showLoading();
  //   var
  //   result=await FirebaseFun.updateClassRoom(classRoom:classRoom);
  //   Get.back();
  //   ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
  //   return result;
  // }




  @override
  void dispose() {
    nameController.dispose();
    workshopNameController.dispose();
    feeController.dispose();
    locationController.dispose();
    aboutController.dispose();
    super.dispose();
  }


}
