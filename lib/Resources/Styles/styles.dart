import 'package:flutter/material.dart';

import '../Theme/theme_manager.dart';
import 'font_size.dart';

abstract class AryanText {
  static AppColorsManager get defaultColors =>
      AppColorsManager(AppTheme().themeMode ?? ThemeMode.light);

  static TextStyle primaryStyle([AppColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'IRANSansX',
      color: colors.primary,
    );
  }

  //Hesaraki Change

  static TextStyle objectStyle([AppColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.primaryFontSize14,
      fontWeight: FontWeight.w500,
      fontFamily: 'IRANSansX',
      color: colors.primary,
    );
  }

  static TextStyle subItemStyle([AppColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.subFontSize14,
      fontWeight: FontWeight.w500,
      fontFamily: 'IRANSansX',
      color: colors.primary,
    );
  }

  static TextStyle exitStyle([AppColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.subFontSize14,
      fontWeight: FontWeight.w500,
      fontFamily: 'IRANSansX',
      color: colors.exitColor,
    );
  }

  //Hesaraki Change

  static TextStyle primButtonTextStyle([AppColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.primButtonTextFontSize24,
      fontWeight: FontWeight.bold,
      fontFamily: 'IRANSansX',
      color: colors.aryanOrdinaryWhite,
    );
  }

  static TextStyle listTitleStyle([AppColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.listTitleFontSize24,
      fontWeight: FontWeight.bold,
      color: colors.listTitlePrimary,
    );
  }

  static TextStyle listContentTitleStyle([AppColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.listContentTitleFontSize24,
      fontWeight: FontWeight.bold,
      color: colors.listContentTitlePrimary,
    );
  }

  static TextStyle listContentStyle([AppColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.darkTextStyleFontSize24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Yekan',
      color: colors.listContentPrimary,
    );
  }

  static TextStyle darkStyle([AppColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.darkTextStyleFontSize24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Yekan',
      color: colors.listTitlePrimary,
    );
  }

  static TextStyle secondary([AppColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.listTileFontSize14,
      leadingDistribution: TextLeadingDistribution.proportional,
      fontStyle: FontStyle.normal,
      height: 1,
      fontWeight: FontWeight.w700,
      fontFamily: 'Yekan',
      color: colors.primary,
      letterSpacing: 1,
    );
  }
}

class aryanSecondaryFormField extends TextFormField {
  aryanSecondaryFormField({
    super.key,
    super.controller,
    super.validator,
    super.onChanged,
    void Function(String)? onFieldSubmited,
    super.onTap,
    super.obscureText,
    bool ignorePointer = true,
    String? hintText,
    AppColorsManager? colors,
    InputDecoration? decoration,
    super.inputFormatters,
    super.keyboardType,
    bool? suggestion,
    bool? correct,
    String? obsChar,
    bool IsRtl = true,
  }) : super(
         onFieldSubmitted: onFieldSubmited,
         cursorColor: Colors.black,
         obscuringCharacter: (obscureText == true ? (obsChar ?? " ") : " "),
         enableSuggestions: suggestion ?? false,
         autocorrect: correct ?? false,
         autofocus: true,
         textAlign: TextAlign.start,
         textDirection: (IsRtl == true ? TextDirection.rtl : TextDirection.ltr),
         cursorOpacityAnimates: false,
         ignorePointers: ignorePointer,
         selectAllOnFocus: true,
         cursorErrorColor: Colors.red,
         cursorHeight: 25,
         style: AryanText.secondary(AppTheme.colors),
         decoration: decoration ?? aryanSecondaryInputDecoration(),
       );
}

class aryanSecondaryInputDecoration extends InputDecoration {
  aryanSecondaryInputDecoration({
    String? customHintText,
    IconButton? suffixIcon,
    Color? hintColor,
    super.fillColor,
    Widget? customHint,
  }) : super(
         suffixIcon: suffixIcon,
         hintFadeDuration: Duration(milliseconds: 550),
         maintainHintSize: true,
         contentPadding: EdgeInsets.all(10),
         isDense: false,
         hintTextDirection: TextDirection.ltr,
         hint:
             customHint ??
             Align(
               alignment: Alignment.centerRight,
               child: Text(
                 textDirection: TextDirection.ltr,
                 customHintText ?? "******",
                 style: TextStyle(
                   color: hintColor ?? Colors.white38,
                   fontSize: 15,
                 ),
               ),
             ),

         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
         enabledBorder: OutlineInputBorder(
           borderSide: const BorderSide(color: Colors.black, width: 0.5),
           borderRadius: BorderRadius.circular(10),
         ),
         focusedBorder: OutlineInputBorder(
           borderSide: const BorderSide(color: Colors.black, width: 1),
           borderRadius: BorderRadius.circular(10),
         ),
         errorBorder: OutlineInputBorder(
           borderSide: const BorderSide(color: Colors.red, width: 1),
           borderRadius: BorderRadius.circular(10),
         ),
         focusedErrorBorder: OutlineInputBorder(
           borderSide: const BorderSide(color: Colors.red, width: 2),
           borderRadius: BorderRadius.circular(10),
         ),
         filled: true,
         errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
       );
}
