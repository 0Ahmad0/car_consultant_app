import 'package:car_consultant/app/widgets/starts_text_rate_widget.dart';
import 'package:flutter/material.dart';

import '../../core/utils/string_manager.dart';
import '../../core/utils/style_manager.dart';
import '../../core/widgets/app_padding.dart';

class RateConsultantWidget extends StatelessWidget {
  const RateConsultantWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppPaddingWidget(
            child: Text(
              '${4.6}',
              style: StyleManager.font40Bold(),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            children: [
              StartsTextRateWidget(
                text: StringManager.professionalismText,
                rate: 5,
              ),
              StartsTextRateWidget(
                text: StringManager.timeScaleText,
                rate: 2,
              ),
              StartsTextRateWidget(
                text: StringManager.punctualityText,
                rate: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
