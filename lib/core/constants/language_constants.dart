enum AppLanguage {
  turkish,
  english,
  chinese,
  spanish,
  hindi,
  french,
  arabic,
  portuguese,
  bengali,
  russian,
  urdu,
  azerbaijani,
  german
}

class LanguageOption {
  final AppLanguage value;
  final String label;
  final String code;
  final String flag;

  const LanguageOption({
    required this.value,
    required this.label,
    required this.code,
    required this.flag,
  });
}

const supportedLanguages = [
  LanguageOption(
    value: AppLanguage.turkish,
    label: 'Türkçe',
    code: 'TR',
    flag: '🇹🇷',
  ),
  LanguageOption(
    value: AppLanguage.english,
    label: 'English',
    code: 'EN',
    flag: '🇬🇧',
  ),
  LanguageOption(
    value: AppLanguage.chinese,
    label: '中文 (Çince)',
    code: 'ZH',
    flag: '🇨🇳',
  ),
  LanguageOption(
    value: AppLanguage.spanish,
    label: 'Español (İspanyolca)',
    code: 'ES',
    flag: '🇪🇸',
  ),
  LanguageOption(
    value: AppLanguage.hindi,
    label: 'हिन्दी (Hintçe)',
    code: 'HI',
    flag: '🇮🇳',
  ),
  LanguageOption(
    value: AppLanguage.french,
    label: 'Français (Fransızca)',
    code: 'FR',
    flag: '🇫🇷',
  ),
  LanguageOption(
    value: AppLanguage.arabic,
    label: 'العربية (Arapça)',
    code: 'AR',
    flag: '🇸🇦',
  ),
  LanguageOption(
    value: AppLanguage.portuguese,
    label: 'Português (Portekizce)',
    code: 'PT',
    flag: '🇵🇹',
  ),
  LanguageOption(
    value: AppLanguage.bengali,
    label: 'বাংলা (Bengalce)',
    code: 'BN',
    flag: '🇧🇩',
  ),
  LanguageOption(
    value: AppLanguage.russian,
    label: 'Русский (Rusça)',
    code: 'RU',
    flag: '🇷🇺',
  ),
  LanguageOption(
    value: AppLanguage.urdu,
    label: 'اردو (Urduca)',
    code: 'UR',
    flag: '🇵🇰',
  ),
  LanguageOption(
    value: AppLanguage.azerbaijani,
    label: 'Azərbaycanca (Azerice)',
    code: 'AZ',
    flag: '🇦🇿',
  ),
  LanguageOption(
    value: AppLanguage.german,
    label: 'Deutsch (Almanca)',
    code: 'DE',
    flag: '🇩🇪',
  ),
];
