import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/utils/assets_manager.dart';
class ImageUserProvider extends StatelessWidget {
  const ImageUserProvider({super.key, this.url, this.height, this.width, this.fit, this.radius, this.errorBuilder});
  final String? url;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit? fit;
  final Widget? errorBuilder;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        radius: radius,
        child: Image.network(
          url??'',fit:fit,// BoxFit.fitHeight,
          height: height,
          width: width,
          frameBuilder:(context,widget,i,a)=>i!=null?widget:
          errorBuilder??Icon(Icons.person),
          // Image.asset(AssetsManager.consultIMG,width: width,height: height,),
          errorBuilder:(context,_,__)=>
              errorBuilder??Icon(Icons.person),
              // Image.asset(AssetsManager.consultIMG,width: width,height: height,),
        ),
      ),
    );
  }
}
