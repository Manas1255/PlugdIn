import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';

class FitThereRichText extends StatelessWidget {
  const FitThereRichText({
    required this.textBefore,
    required this.richText,
    required this.textAfter,
    super.key,
    this.normalTextStyle,
    this.richTextStyle,
    this.richTextColor,
    this.onRichTextTap,
    this.textAlign = TextAlign.center,
    this.noSpace = false,
  });

  final TextStyle? normalTextStyle;
  final TextStyle? richTextStyle;
  final bool noSpace;
  final String textBefore;
  final String textAfter;
  final String richText;
  final Color? richTextColor;
  final VoidCallback? onRichTextTap;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        text: textBefore,
        style:
            normalTextStyle ??
            context.b3.copyWith(
              color: AppColors.black,
            ),
        children: [
          TextSpan(
            text: noSpace ? richText : ' $richText ',
            style:
                richTextStyle ??
                context.b3.copyWith(
                  color: richTextColor ?? AppColors.black,
                ),
            recognizer: TapGestureRecognizer()..onTap = onRichTextTap,
          ),
          TextSpan(
            text: textAfter,
            style:
                normalTextStyle ??
                context.b3.copyWith(
                  color: AppColors.black,
                ),
          ),
        ],
      ),
    );
  }
}
