import 'dart:ui';

import 'package:flutter/widgets.dart';

class Utils {
  /// 计算文本高度
  ///
  /// [value] 文本内容
  /// [fontFamily] 字体
  /// [fontSize] 文字的大小
  /// [fontWeight] 文字权重
  /// [maxWidth] 文本框的最大宽度
  /// [maxLines] 文本支持最大多少行
  /// [locale] 本地化语言，可通过上下文获取：`Localizations.localeOf(GlobalStatic.context, nullOk: true)`
  /// 华为手机如果不指定locale的时候，该方法算出来的文字高度是比系统计算偏小的
  static double calculateTextHeight(
      String value,
      String? fontFamily,
      double? fontSize,
      FontWeight? fontWeight,
      double maxWidth,
      int? maxLines,
      Locale? locale,
      ) {
    TextPainter painter = TextPainter(
      locale: locale,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: value,
        style: TextStyle(
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
    painter.layout(maxWidth: maxWidth);
    return painter.height;
  }
}