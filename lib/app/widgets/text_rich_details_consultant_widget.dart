import 'package:flutter/material.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';
import '../../core/widgets/app_padding.dart';

class TextRichDetailsConsultant extends StatelessWidget {
  const TextRichDetailsConsultant({
    super.key, required this.number, required this.text,
  });

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      verticalPadding: 0.0,
      child: Text.rich(TextSpan(
          children: [
            TextSpan(
              text: '${number} ',
              style: StyleManager.font20Bold(),
            ),
            TextSpan(
                text: text,
                style: StyleManager.font14Regular(
                    color: ColorManager.hintTextColor
                )
            )
          ]
      )),
    );
  }
}
