

import 'package:car_consultant/core/models/education_resource.dart';
import 'package:car_consultant/core/models/user_model.dart';
import 'package:car_consultant/core/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';
import 'package:get/get_core/src/get_main.dart';

class ServiceProvidersController extends GetxController{

  final searchController = TextEditingController();
  Users serviceProviders=Users(items: []);
  Users providersWithFilter=Users(items: []);
  var getServiceProviders;

  @override
  void onInit() {
   searchController.clear();
   getServiceProvidersFun();
    super.onInit();
    }

  getServiceProvidersFun() async {
    getServiceProviders =_fetchServiceProvidersStream();
    return getServiceProviders;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  _fetchServiceProvidersStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionUser)
        .where('typeUser',isEqualTo: AppConstants.collectionServiceProvider)
        .snapshots();
    return result;
  }
  filterProviders({required String term}) async {

    providersWithFilter.items=[];
    serviceProviders.items.forEach((element) {

      if((element.name?.toLowerCase().contains(term.toLowerCase())??false))
        providersWithFilter.items.add(element);
    });
     update();
  }
  sortByBestFee() async {
    providersWithFilter.items.sort((user1,user2)=>(int.tryParse(user2.additionalInfo?.fee??'')??0)-(int.tryParse(user1.additionalInfo?.fee??'')??0));
    update();
  }
  sortByBestRate() async {
    providersWithFilter.items.sort((user1,user2){
      double compare=(double.tryParse("${user2.additionalInfo?.getRate??''}")??0) -(double.tryParse("${user1.additionalInfo?.getRate??''}")??0);
      return compare>0?compare.ceil():compare.floor();
    });
    update();
  }

}
