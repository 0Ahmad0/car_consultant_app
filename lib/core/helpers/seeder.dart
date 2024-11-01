import 'package:car_consultant/core/models/education_resource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../app/controllers/firebase/firebase_constants.dart';
import '../../app/controllers/firebase/firebase_fun.dart';
import '../models/file_model.dart';
import '../models/location_model.dart';
import '../models/review_model.dart';
import '../models/user_model.dart';
import '../utils/app_constant.dart';
import '../widgets/constants_widgets.dart';

class Seeder{
  static Future<void> admin() async {
    List<UserModel> users=[
      UserModel(email: 'admin@gmail.com', name: 'Super Admin', password: '12345678',phoneNumber: "0599555999", typeUser: AppConstants.collectionAdmin),
      UserModel(email: 'a@gmail.com', name: 'Admin Admin', password: '12345678',phoneNumber: "0599555999", typeUser: AppConstants.collectionAdmin),
    ];
    try {
      ConstantsWidgets.showLoading();
      for(UserModel userModel in users){
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password!)
            .timeout(FirebaseFun.timeOut);
        if(userCredential.user!=null){
          userModel.uid=userCredential.user!.uid;
          await FirebaseFirestore.instance
              .collection(FirebaseConstants.collectionUser)
              .doc(userModel.uid)
              .set(userModel.toJson());
        }
      }
      ConstantsWidgets.closeDialog();
    } on FirebaseAuthException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      ConstantsWidgets.closeDialog();
      ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
    }
  }
  static educationResources() async {
    List<EducationResourceModel> items = [
      EducationResourceModel(
        title: "How to Change Engine Oil",
        about: "A comprehensive guide on how to change the engine oil in your car at home.",
        photoUrl: "https://i.ytimg.com/vi_webp/O1hF25Cowv8/maxresdefault.webp",
        urlLink: "https://www.youtube.com/watch?v=O1hF25Cowv8",
        review: 4.7,
        numLike: 1200,
      ),
      EducationResourceModel(
        title: "Checking and Adjusting Tire Pressure",
        about: "Learn why tire pressure is crucial and how to check and adjust it easily.",
        photoUrl: "https://i.ytimg.com/vi/GzQU6QcSJOs/hq720.jpg",
        urlLink: "https://youtu.be/GzQU6QcSJOs?si=oKsPpDkUP6mWpavu",
        review: 4.5,
        numLike: 980,
      ),
      EducationResourceModel(
        title: "How to Replace a Car Battery",
        about: "Step-by-step tutorial on how to safely replace your car battery.",
        photoUrl: "https://i.ytimg.com/vi/JHo9RG0FXwQ/hq720.jpg",
        urlLink: "https://youtu.be/JHo9RG0FXwQ?si=OPYt2nOOwM0CK1-l",
        review: 4.8,
        numLike: 1500,
      ),
      EducationResourceModel(
        title: "Car Brake Maintenance Tips",
        about: "Tips on how to maintain your car's brakes and ensure they are working properly.",
        photoUrl: "https://i.ytimg.com/vi/7so1O8qsUVs/hq720.jpg",
        urlLink: "https://youtu.be/7so1O8qsUVs?si=GItQaZxajTeX9zLh",
        review: 4.6,
        numLike: 1700,
      ),
      EducationResourceModel(
        title: "How to Properly Check and Fill Tires on Your Car",
        about: "Checking your tire pressure only takes a minute.",
        photoUrl: "https://i.ytimg.com/vi/0Q-Eb7aUyt4/hq720.jpg",
        urlLink: "https://youtu.be/0Q-Eb7aUyt4?si=OADXjBBux3wr9Kyf",
        review: 4.4,
        numLike: 3500,
      ),
    ];

    try {
      ConstantsWidgets.showLoading();
      for(EducationResourceModel item in items){
        await FirebaseFirestore.instance
            .collection(FirebaseConstants.collectionEducationResource)
            .add(item.toJson());
      }
      ConstantsWidgets.closeDialog();
    } on FirebaseAuthException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      ConstantsWidgets.closeDialog();
      ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
    }
  }
  static emergencyServices() async {
    List<EducationResourceModel> items = [
      EducationResourceModel(
        title: "My Car EDC Emergency Kit 2022",
        about: "In this kit I bring together a range of essential car items that you will want when things go wrong.",
        photoUrl: "https://i.ytimg.com/vi/ejQf1aPNZAQ/hqdefault.jpg",
        urlLink: "",
        review: 4.9,
        numLike: 5600,
      ),
      EducationResourceModel(
        title: "10 Must Have Emergency Kits for Your Car",
        about: "Whether you are driving back home after a hectic office day or enjoying a road trip with your famil.",
        photoUrl: "https://i.ytimg.com/vi/Q9xGMGBOsso/hq720.jpg",
        urlLink: "https://www.youtube.com/watch?v=Q9xGMGBOsso",
        review: 4.5,
        numLike: 248,
      ),

      EducationResourceModel(
        title: "DIY Winter Driving Vehicle Emergency Kit",
        about: "Things You Need To Stay Safe When Winter Weather Turns Bad",
        photoUrl: "https://i.ytimg.com/vi/bBcItzjenXQ/hq720.jpg",
        urlLink: "https://www.youtube.com/watch?v=bmBb97niQtE",
        review: 4.7,
        numLike: 1600,
      ),
      EducationResourceModel(
        title: "Winter Emergency Car Kit",
        about: "Survival In the Cold Weather - Are You Prepared? FULL LIST BELOW",
        photoUrl: "https://i.ytimg.com/vi/vBYq8zfbVDY/hqdefault.jpg",
        urlLink: "https://www.youtube.com/watch?v=vBYq8zfbVDY",
        review: 4.5,
        numLike: 440,
      ),
    ];

    try {
      ConstantsWidgets.showLoading();
      for(EducationResourceModel item in items){
        await FirebaseFirestore.instance
            .collection(FirebaseConstants.collectionEmergencyService)
            .add(item.toJson());
      }
      ConstantsWidgets.closeDialog();
    } on FirebaseAuthException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      ConstantsWidgets.closeDialog();
      ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
    }
  }
  static Future<void> serviceProvider() async {
    List<UserModel> users=[
      UserModel(email: 'sp@gmail.com', name: 'Service Pd', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionServiceProvider
      ,additionalInfo: additionalInfoServices[0]),
      UserModel(email: 'sp1@gmail.com', name: 'Service Pd1', password: '12345678',phoneNumber: "0599555441", typeUser: AppConstants.collectionServiceProvider
          ,additionalInfo: additionalInfoServices[1]),
      UserModel(email: 'sp2@gmail.com', name: 'Service Pd2', password: '12345678',phoneNumber: "0599555442", typeUser: AppConstants.collectionServiceProvider
          ,additionalInfo: additionalInfoServices[2]),
      UserModel(email: 'sp3@gmail.com', name: 'Service Pd3', password: '12345678',phoneNumber: "0599555443", typeUser: AppConstants.collectionServiceProvider
      ,additionalInfo: additionalInfoServices[3]),
      UserModel(email: 'sp4@gmail.com', name: 'Service Pd4', password: '12345678',phoneNumber: "0599555444", typeUser: AppConstants.collectionServiceProvider
      ,additionalInfo: additionalInfoServices[4]),
      UserModel(email: 'sp5@gmail.com', name: 'Service Pd5', password: '12345678',phoneNumber: "0599555445", typeUser: AppConstants.collectionServiceProvider
      ,additionalInfo: additionalInfoServices[5]),
   ];
    try {
      ConstantsWidgets.showLoading();
      for(UserModel userModel in users){
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password!)
            .timeout(FirebaseFun.timeOut);
        if(userCredential.user!=null){
          userModel.uid=userCredential.user!.uid;
          await FirebaseFirestore.instance
              .collection(FirebaseConstants.collectionUser)
              .doc(userModel.uid)
              .set(userModel.toJson());
        }
      }
      ConstantsWidgets.closeDialog();
    } on FirebaseAuthException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      ConstantsWidgets.closeDialog();
      ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
    }
  }
  static  Future<void> consultantProvider() async {
    List<UserModel> users=[
      UserModel(email: 'cp@gmail.com', name: 'Consultant Pd', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionConsultantProvider
          ,additionalInfo: additionalInfoConsultants[0]),
      UserModel(email: 'cp1@gmail.com', name: 'Consultant Pd1', password: '12345678',phoneNumber: "0599555441", typeUser: AppConstants.collectionConsultantProvider
          ,additionalInfo: additionalInfoConsultants[1]),
      UserModel(email: 'cp2@gmail.com', name: 'Consultant Pd2', password: '12345678',phoneNumber: "0599555442", typeUser: AppConstants.collectionConsultantProvider
          ,additionalInfo: additionalInfoConsultants[2]),
      UserModel(email: 'cp3@gmail.com', name: 'Consultant Pd3', password: '12345678',phoneNumber: "0599555443", typeUser: AppConstants.collectionConsultantProvider
          ,additionalInfo: additionalInfoConsultants[3]),
      UserModel(email: 'cp4@gmail.com', name: 'Consultant Pd4', password: '12345678',phoneNumber: "0599555444", typeUser: AppConstants.collectionConsultantProvider
          ,additionalInfo: additionalInfoConsultants[4]),
      UserModel(email: 'cp5@gmail.com', name: 'Consultant Pd5', password: '12345678',phoneNumber: "0599555445", typeUser: AppConstants.collectionConsultantProvider
          ,additionalInfo: additionalInfoConsultants[5]),
    ];
    try {
      ConstantsWidgets.showLoading();
      for(UserModel userModel in users){
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password!)
            .timeout(FirebaseFun.timeOut);
        if(userCredential.user!=null){
          userModel.uid=userCredential.user!.uid;
          await FirebaseFirestore.instance
              .collection(FirebaseConstants.collectionUser)
              .doc(userModel.uid)
              .set(userModel.toJson());
        }
      }
      ConstantsWidgets.closeDialog();
    } on FirebaseAuthException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      ConstantsWidgets.closeDialog();
      ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
    }
  }
  static List<AdditionalInfoModel> additionalInfoServices= [
    AdditionalInfoModel(
      name: "Ahmed's Auto Repair",
      workShopName: "Ahmed's Workshop",
      about: "Experienced in all types of car repair services.",
      files: [
        FileModel(id: "1", name: "service_manual.pdf", size: 1024, url: "https://example.com/service_manual.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "1", professionalReview: 4.5, timeScaleReview: 4.0, punctualityReview: 4.7),
      ],
      location: LocationModel(id: "1", address: "123 Elm St", latitude: 40.7128, longitude: -74.0060),
      fee: "50",
      expertise: "General Repairs",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: true,
      inspectionDiagnostics: true,
    ),
    AdditionalInfoModel(
      name: "Ali's Diagnostic Center",
      workShopName: "Ali's Workshop",
      about: "Specialized in vehicle diagnostics and inspection.",
      files: [
        FileModel(id: "2", name: "diagnostic_report.pdf", size: 2048, url: "https://example.com/diagnostic_report.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "2", professionalReview: 4.8, timeScaleReview: 4.9, punctualityReview: 4.5),
        ReviewModel(id: "2", professionalReview: 4.4, timeScaleReview: 4, punctualityReview: 1),
        ReviewModel(id: "2", professionalReview: 4.3, timeScaleReview: 4.9, punctualityReview: 3),
      ],
      location: LocationModel(id: "2", address: "456 Maple Ave", latitude: 40.7580, longitude: -73.9855),
      fee: "80",
      expertise: "Diagnostics",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: false,
      inspectionDiagnostics: true,
    ),
    AdditionalInfoModel(
      name: "Sara's Quick Fix",
      workShopName: "Sara's Garage",
      about: "Fast repairs for minor vehicle issues.",
      files: [
        FileModel(id: "3", name: "quick_fix_guide.pdf", size: 512, url: "https://example.com/quick_fix_guide.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "3", professionalReview: 4.2, timeScaleReview: 4.3, punctualityReview: 4.6),
      ],
      location: LocationModel(id: "3", address: "789 Oak Blvd", latitude: 40.7306, longitude: -73.9352),
      fee: "30",
      expertise: "Quick Repairs",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: true,
      inspectionDiagnostics: false,
    ),
    AdditionalInfoModel(
      name: "Mike's Car Solutions",
      workShopName: "Mike's Auto Services",
      about: "Comprehensive car repair and maintenance services.",
      files: [
        FileModel(id: "4", name: "maintenance_schedule.pdf", size: 2560, url: "https://example.com/maintenance_schedule.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "4", professionalReview: 4.9, timeScaleReview: 4.8, punctualityReview: 4.9),
      ],
      location: LocationModel(id: "4", address: "321 Cedar Lane", latitude: 40.7608, longitude: -73.9822),
      fee: "100",
      expertise: "Full Service",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: true,
      inspectionDiagnostics: true,
    ),
    AdditionalInfoModel(
      name: "Nina's Tire Shop",
      workShopName: "Nina's Tires and Wheels",
      about: "Specializing in tire and wheel services.",
      files: [
        FileModel(id: "5", name: "tire_guide.pdf", size: 1024, url: "https://example.com/tire_guide.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "5", professionalReview: 4.4, timeScaleReview: 4.6, punctualityReview: 4.7),
      ],
      location: LocationModel(id: "5", address: "654 Pine St", latitude: 40.7328, longitude: -74.0010),
      fee: "45",
      expertise: "Tires and Wheels",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: false,
      inspectionDiagnostics: true,
    ),
    AdditionalInfoModel(
      name: "Tom's Auto Detailing",
      workShopName: "Tom's Detail Center",
      about: "Professional car detailing and cleaning services.",
      files: [
        FileModel(id: "6", name: "detailing_info.pdf", size: 1536, url: "https://example.com/detailing_info.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "6", professionalReview: 4.5, timeScaleReview: 4.6, punctualityReview: 4.8),
      ],
      location: LocationModel(id: "6", address: "987 Birch Rd", latitude: 40.7351, longitude: -73.9997),
      fee: "70",
      expertise: "Detailing",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: true,
      inspectionDiagnostics: false,
    ),
  ];
  static List<AdditionalInfoModel> additionalInfoConsultants = [
    AdditionalInfoModel(
      name: "Rami's Auto Body Repair",
      workShopName: "Rami's Body Shop",
      about: "Specializing in auto body repair and paint jobs.",
      files: [
        FileModel(id: "7", name: "body_repair_manual.pdf", size: 1500, url: "https://example.com/body_repair_manual.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "7", professionalReview: 4.7, timeScaleReview: 4.5, punctualityReview: 4.6),
      ],
      location: LocationModel(id: "7", address: "111 Cherry Lane", latitude: 40.7488, longitude: -73.9854),
      fee: "120",
      expertise: "Auto Body Repair",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: true,
      inspectionDiagnostics: false,
    ),
    AdditionalInfoModel(
      name: "Laila's Electrical Services",
      workShopName: "Laila's Auto Electric",
      about: "Expert in automotive electrical systems and repairs.",
      files: [
        FileModel(id: "8", name: "electrical_repair_guide.pdf", size: 900, url: "https://example.com/electrical_repair_guide.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "8", professionalReview: 4.6, timeScaleReview: 4.4, punctualityReview: 4.7),
      ],
      location: LocationModel(id: "8", address: "202 Walnut St", latitude: 40.7590, longitude: -73.9845),
      fee: "70",
      expertise: "Electrical Repairs",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: true,
      inspectionDiagnostics: false,
    ),
    AdditionalInfoModel(
      name: "Khaled's Exhaust Specialists",
      workShopName: "Khaled's Exhaust Shop",
      about: "Focused on exhaust system repairs and replacements.",
      files: [
        FileModel(id: "9", name: "exhaust_system_guide.pdf", size: 1300, url: "https://example.com/exhaust_system_guide.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "9", professionalReview: 4.5, timeScaleReview: 4.6, punctualityReview: 4.8),
      ],
      location: LocationModel(id: "9", address: "303 Maple St", latitude: 40.7654, longitude: -73.9796),
      fee: "55",
      expertise: "Exhaust Systems",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: true,
      inspectionDiagnostics: false,
    ),
    AdditionalInfoModel(
      name: "Fatima's Brake Service",
      workShopName: "Fatima's Brake Center",
      about: "Specializes in brake repairs and replacements.",
      files: [
        FileModel(id: "10", name: "brake_service_guide.pdf", size: 800, url: "https://example.com/brake_service_guide.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "10", professionalReview: 4.8, timeScaleReview: 4.7, punctualityReview: 4.5),
      ],
      location: LocationModel(id: "10", address: "404 Fir Rd", latitude: 40.7800, longitude: -73.9532),
      fee: "60",
      expertise: "Brake Services",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: true,
      inspectionDiagnostics: false,
    ),
    AdditionalInfoModel(
      name: "Omar's Fleet Services",
      workShopName: "Omar's Fleet Maintenance",
      about: "Comprehensive maintenance for fleet vehicles.",
      files: [
        FileModel(id: "11", name: "fleet_maintenance_guide.pdf", size: 2500, url: "https://example.com/fleet_maintenance_guide.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "11", professionalReview: 4.9, timeScaleReview: 4.8, punctualityReview: 4.9),
      ],
      location: LocationModel(id: "11", address: "505 Pine Blvd", latitude: 40.7549, longitude: -73.9845),
      fee: "150",
      expertise: "Fleet Services",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: true,
      inspectionDiagnostics: true,
    ),
    AdditionalInfoModel(
      name: "Sam's Custom Garage",
      workShopName: "Sam's Performance Shop",
      about: "Custom modifications and performance upgrades.",
      files: [
        FileModel(id: "12", name: "performance_modification_guide.pdf", size: 1800, url: "https://example.com/performance_modification_guide.pdf", type: "document"),
      ],
      reviews: [
        ReviewModel(id: "12", professionalReview: 4.6, timeScaleReview: 4.5, punctualityReview: 4.7),
      ],
      location: LocationModel(id: "12", address: "606 Cedar Blvd", latitude: 40.7674, longitude: -73.9732),
      fee: "200",
      expertise: "Performance Upgrades",
      status: "accepted",
      dateTime: DateTime.now(),
      repairServices: true,
      inspectionDiagnostics: false,
    ),
  ];

}