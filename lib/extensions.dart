import 'package:flutter/material.dart';
import 'package:models_package/base/app_color.dart';

import 'Resources/Theme/theme_manager.dart';
import 'l10n/app_localizations.dart';
import 'l10n/app_localizations_en.dart';
import 'l10n/app_localizations_fa.dart';

extension LocalizationX on BuildContext {
  AppLocalizations get l10n {
    final Locale locale = Localizations.localeOf(this);
    return AppLocalizations.of(this) ??
        (locale.languageCode == 'fa' ? AppLocalizationsFa() : AppLocalizationsEn());
  }
}

extension ThemeColorsX on BuildContext {
  AppColors get colors {

    final AppColors? ext = Theme.of(this).extension<AppColors>();
    assert(ext != null, 'AppColors not found in ThemeData.extensions — make sure to add it.');
    return ext!;
  }
  AppColorsManager get appColors {
    final AppColorsManager ext = AppColorsManager();
    return ext;
  }

}