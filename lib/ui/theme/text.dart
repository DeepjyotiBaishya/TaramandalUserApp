import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/ui/theme/text_style.dart';
import 'package:rashi_network/viewmodel/darkmode_state.dart';

class DesignText extends ConsumerWidget {
  final String text;
  final TextStyle? style;
  final int? fontWeight;
  final bool muted, xMuted;
  final double? letterSpacing;
  final Color? color;
  final bool iscolor;
  final bool iscolorSecond;
  final bool isDesignButton;
  final TextDecoration decoration;
  final double? height;
  final double wordSpacing;
  final double? fontSize;
  final DesignTextType textType;
  final TextAlign? textAlign;
  final int? maxLines;
  final Locale? locale;
  final TextOverflow? overflow;
  final String? semanticsLabel;
  final bool? softWrap;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextHeightBehavior? textHeightBehavior;
  final double? textScaleFactor;
  final TextWidthBasis? textWidthBasis;

  const DesignText(this.text,
      {Key? key,
      this.style,
      this.fontWeight = 700,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing = 0.15,
      this.color,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.fontSize,
      this.textType = DesignTextType.b1,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);

  const DesignText.caption(this.text,
      {Key? key,
      this.style,
      this.fontWeight = 500,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing,
      this.color,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.fontSize,
      this.textType = DesignTextType.caption,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);

  const DesignText.title(this.text,
      {Key? key,
      this.style,
      this.fontWeight = 800,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing,
      this.color,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.fontSize,
      this.textType = DesignTextType.title,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);

  const DesignText.overline(this.text,
      {Key? key,
      this.style,
      this.fontWeight = 500,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing,
      this.color,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.fontSize,
      this.textType = DesignTextType.overline,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);

  const DesignText.bold1(this.text,
      {Key? key,
      this.style,
      this.fontWeight,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing,
      this.color,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.fontSize,
      this.textType = DesignTextType.b1,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);
  const DesignText.bold2(this.text,
      {Key? key,
      this.style,
      this.fontWeight,
      this.muted = false,
      this.xMuted = false,
      this.letterSpacing,
      this.color,
      this.iscolor = false,
      this.iscolorSecond = false,
      this.isDesignButton = false,
      this.decoration = TextDecoration.none,
      this.height,
      this.wordSpacing = 0,
      this.fontSize,
      this.textType = DesignTextType.b2,
      this.textAlign,
      this.maxLines,
      this.locale,
      this.overflow,
      this.semanticsLabel,
      this.softWrap,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeRef);
    return Text(
      text,
      style: style ??
          DesignTextStyle.designStyle(
            textStyle: style,
            color: iscolor
                ? color
                : darkMode.isDark
                    ? isDesignButton
                        ? Colors.white
                        : AppColors.blackText
                    : color,
            fontWeight: fontWeight ??
                DesignTextStyle.defaultTextFontWeight[textType] ??
                500,
            muted: muted,
            letterSpacing: letterSpacing ??
                DesignTextStyle.defaultLetterSpacing[textType] ??
                0.15,
            height: height,
            xMuted: xMuted,
            decoration: decoration,
            wordSpacing: wordSpacing,
            fontSize: fontSize != null
                ? fontSize! + 1
                : DesignTextStyle.defaultTextSize[textType],
          ),
      textAlign: textAlign,
      maxLines: maxLines,
      locale: locale,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textDirection: TextDirection.ltr,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
      key: key,
    );
  }
}
