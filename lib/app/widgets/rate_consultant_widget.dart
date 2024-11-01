import 'package:car_consultant/app/widgets/starts_text_rate_widget.dart';
import 'package:flutter/material.dart';

import '../../core/models/user_model.dart';
import '../../core/utils/string_manager.dart';
import '../../core/utils/style_manager.dart';
import '../../core/widgets/app_padding.dart';

class RateConsultantWidget extends StatelessWidget {
  const RateConsultantWidget({
    super.key, this.provider,
  });
  final UserModel? provider;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppPaddingWidget(
            child: Text(
              '${provider?.additionalInfo?.getRate.toStringAsFixed(1)??4.5}',
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
                rate: provider?.additionalInfo?.professionalRate??5,
              ),
              StartsTextRateWidget(
                text: StringManager.timeScaleText,
                rate: provider?.additionalInfo?.timeScaleRate??2,
              ),
              StartsTextRateWidget(
                text: StringManager.punctualityText,
                rate: provider?.additionalInfo?.punctualityRate??2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
