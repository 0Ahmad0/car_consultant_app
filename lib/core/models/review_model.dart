import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? id;
  double? professionalReview;
  double? timeScaleReview;
  double? punctualityReview;

  ReviewModel(
      {
        this.id,
        this.professionalReview,
        this.timeScaleReview,
        this.punctualityReview,
      });

  double get avgRate{
    int countReview=0;
    double sumReview=0;
    if(professionalReview!=null){
      countReview++;
      sumReview+=professionalReview!;
    }
    if(timeScaleReview!=null){
      countReview++;
      sumReview+=timeScaleReview!;
    }
    if(punctualityReview!=null){
      countReview++;
      sumReview+=punctualityReview!;
    }
    countReview=countReview==0?1:countReview;
    return sumReview/countReview;

  }
  factory ReviewModel.fromJson( json){
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;

    return ReviewModel(
      professionalReview: data["professionalReview"],
      timeScaleReview: data["timeScaleReview"],
      punctualityReview: data["punctualityReview"],
    );
  }
  Map<String,dynamic> toJson() {
    return {
      'id': id,
      'professionalReview': professionalReview,
      'timeScaleReview': timeScaleReview,
      'punctualityReview': punctualityReview,
    };
  }
  factory ReviewModel.init(){
    return ReviewModel();
  }
}