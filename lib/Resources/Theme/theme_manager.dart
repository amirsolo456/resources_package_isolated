import 'package:flutter/material.dart';
import 'package:models_package/base/app_color.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '/Resources/Styles/Colors/dark.dart' as dark;
import '/Resources/Styles/Colors/light.dart' as light;

class AppTheme {
  final ThemeMode themeMode;
  final Color primaryColor;
  final Color secondaryColor;
  final Locale localMode;
  static final ValueNotifier<ThemeMode> mode = ValueNotifier<ThemeMode>(ThemeMode.light);

  AppTheme({
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.green,
    this.localMode = const Locale('fa'),
    this.themeMode = ThemeMode.light,
  });

  // تغییر اسم ValueNotifier از 'mode' به 'themeModeNotifier'
  static final ValueNotifier<ThemeMode> themeModeNotifier =
  ValueNotifier<ThemeMode>(ThemeMode.light);

  factory AppTheme.dark() => AppTheme(
    themeMode: ThemeMode.dark,
    primaryColor: Colors.blue,
    secondaryColor: Colors.green,
    localMode: const Locale('fa'),
  );

  factory AppTheme.light() => AppTheme(
    themeMode: ThemeMode.light,
    primaryColor: Colors.blue,
    secondaryColor: Colors.green,
    localMode: const Locale('fa'),
  );

  AppTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Locale? localMode,
  }) {
    return AppTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      localMode: localMode ?? this.localMode,
      themeMode: themeMode,
    );
  }

  static AppColorsManager get colors => AppColorsManager(themeModeNotifier.value);

  static Future<void> setTheme(ThemeMode newMode, {bool persist = true}) async {
    themeModeNotifier.value = newMode;
    if (persist) {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs!.setString(
        _prefKey,
        newMode == ThemeMode.dark
            ? 'dark'
            : newMode == ThemeMode.system
            ? 'system'
            : 'light',
      );
    }
  }


  bool get isRtlByLocalize => (localMode.languageCode == 'fa');

  String get localeLanguageCode => localMode.languageCode;
  static SharedPreferences? _prefs;
  static const _prefKey = 'app_theme_mode';

  // static AppColorsManager get colors => AppColorsManager(AppTheme.mode.value);

  static Future<void> init({ThemeMode fallback = ThemeMode.light}) async {
    _prefs = await SharedPreferences.getInstance();
    final saved = _prefs!.getString(_prefKey);
    if (saved == 'dark') {
      mode.value = ThemeMode.dark;
    } else if (saved == 'system') {
      mode.value = ThemeMode.system;
    } else if (saved == 'light') {
      mode.value = ThemeMode.light;
    } else {
      mode.value = fallback;
    }
  }


  // static Future<void> setTheme(ThemeMode newMode, {bool persist = true}) async {
  //   mode.value = newMode;
  //   if (persist) {
  //     _prefs ??= await SharedPreferences.getInstance();
  //     await _prefs!.setString(
  //       _prefKey,
  //       newMode == ThemeMode.dark
  //           ? 'dark'
  //           : newMode == ThemeMode.system
  //           ? 'system'
  //           : 'light',
  //     );
  //   }
  // }

  // static Future<void> toggle() async {
  // themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  //   await setTheme(themeMode);
  // }

  // static String get currentThemeString =>
  //     themeMode == ThemeMode.light
  //         ? 'Light Theme'
  //         : themeMode == ThemeMode.dark
  //         ? 'Dark Theme'
  //         : 'System';

  // static Brightness get currentThemeBrightness {
  //   switch (themeMode) {
  //     case ThemeMode.dark:
  //       return Brightness.dark;
  //     case ThemeMode.light:
  //       return Brightness.light;
  //     case ThemeMode.system:
  //       return WidgetsBinding.instance.window.platformBrightness;
  //   }
  // }

  static ThemeData build(Color seedColor, Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    // رنگ‌های محاسبه‌شده (مثل قبلی)
    final Color smallOpaColors = isDark ? Colors.white54 : Colors.grey.shade900;
    final Color borderColor = isDark ? Colors.white : Colors.grey.shade600;
    final Color shadowColors = isDark
        ? Colors.transparent
        : Colors.grey.shade600;
    final Color mainBackColors = isDark
        ? Colors.grey.shade900
        : const Color(0xF9FFFFFF);
    final Color textColor = isDark ? Colors.white54 : Colors.grey.shade900;
    final Color selectionColor = isDark ? Colors.lightBlue : Colors.lightGreen;
    final Color splashTr = Colors.transparent;
    final Color hoverTr = Colors.transparent;
    final Color optionalColor1 = Colors.lightGreen;
    final Color optionalColor2 = Colors.lightBlueAccent;
    final Color optionalColor3 = Colors.lightGreenAccent;
    final Color optionalColor4 = const Color(0xFFDDDDDD);

    // AppColors instance
    final AppColors appColors = AppColors(
      primary: seedColor,
      secondary: optionalColor1,
      border: borderColor,
      main: mainBackColors,
      text: textColor,
      hint: smallOpaColors,
      selection: selectionColor,
      optional1: optionalColor1,
      optional2: optionalColor2,
      optional3: optionalColor3,
      splashTransparent: splashTr,
      hoverTransparent: hoverTr,
      shadowColors: shadowColors,
      optionalColor4: optionalColor4,
    );

    final ThemeData base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      ),
      useMaterial3: true,
      fontFamily: 'Vazirani',
      scaffoldBackgroundColor: mainBackColors,
      shadowColor: shadowColors,
      focusColor: smallOpaColors,
      hintColor: smallOpaColors,
      hoverColor: hoverTr,
      splashColor: splashTr,
      // ... بقیه مقادیر قبلی‌ات
      brightness: brightness,
      // ...
    );

    return base.copyWith(
      // اگر از copyWith برای برخی فیلدها استفاده می‌کنی اینجا بذار
      extensions: <ThemeExtension<dynamic>>[
        appColors, // مهم: اینجا AppColors را اضافه می‌کنیم
      ],
    );
  }

// static IconData get currentThemeIcon {
//   switch (themeMode) {
//     case ThemeMode.light:
//       return Icons.dark_mode;
//     case ThemeMode.dark:
//       return Icons.light_mode;
//     case ThemeMode.system:
//       return Icons.brightness_auto;
//   }
// }
}

class AppColorsManager {
  final ThemeMode? themeMode;

  AppColorsManager([this.themeMode]);

  ThemeMode get _mode => themeMode ?? ThemeMode.light;

  bool get isDark => effectiveBrightness == Brightness.dark;

  Brightness get effectiveBrightness {
    final mode = _mode;
    if (mode == ThemeMode.system) {
      try {
        return WidgetsBinding.instance.platformDispatcher.platformBrightness;
      } catch (_) {
        return Brightness.light;
      }
    }
    return mode == ThemeMode.dark ? Brightness.dark : Brightness.light;
  }

  AppColorsManager.fromBrightness(Brightness brightness)
      : themeMode = brightness == Brightness.dark
      ? ThemeMode.dark
      : ThemeMode.light;

  ThemeData get aryanTheme =>
      isDark ? dark.DarkColorTheme.darkTheme : light.LightColorTheme.lightTheme;

  Color get darkPrimary =>
      isDark ? dark.AppColors.darkPrimary : light.AppColors.darkPrimary;

  Color get hintColor =>
      isDark
          ? dark.AppColors.aryanTextHintColor
          : light.AppColors.aryanTextHintColor;

  Color get aryanText =>
      isDark ? dark.AppColors.aryanText : light.AppColors.aryanText;

  Color get listTitlePrimary =>
      isDark
          ? dark.AppColors.listTitlePrimary
          : light.AppColors.listTitlePrimary;

  Color get listContentTitlePrimary =>
      isDark
          ? dark.AppColors.listContentTitlePrimary
          : light.AppColors.listContentTitlePrimary;

  Color get listContentPrimary =>
      isDark
          ? dark.AppColors.listContentSecondary
          : light.AppColors.listContentSecondary;

  Color get aryanBorder =>
      isDark
          ? dark.AppColors.aryanTextBorderColor
          : light.AppColors.aryanTextBorderColor;

  Color get aryanDarkBorder =>
      isDark ? dark.AppColors.darkBorder : light.AppColors.darkBorder;

  Color get aryanOrdinaryWhite =>
      isDark ? dark.AppColors.ordinaryWhite : light.AppColors.ordinaryWhite;

  Color get primary =>
      isDark ? dark.AppColors.primary : light.AppColors.primary;

  Color get secondary =>
      isDark ? dark.AppColors.secondary : light.AppColors.secondary;

  Color get subColor =>
      isDark ? dark.AppColors.subColor : light.AppColors.secondary;

  Color get exitColor => isDark ? dark.AppColors.exit : light.AppColors.exit;

  Color get themCounterColor =>
      isDark ? dark.AppColors.counterTheme : light.AppColors.counterTheme;

  Color get themNotCounterColor =>
      isDark
          ? dark.AppColors.notCounterTheme
          : light.AppColors.notCounterTheme;
}
