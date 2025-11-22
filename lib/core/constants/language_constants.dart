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
  final String flag; // Emoji veya asset yolu

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
    flag: '🇿🇿',
  ),
  LanguageOption(
    value: AppLanguage.german,
    label: 'Deutsch (Almanca)',
    code: 'DE',
    flag: '🇩🇪',
  ),
];

final localizedActionToolbarTexts = {
  AppLanguage.turkish: {
    'sequentialMode': 'Sıralı Çizme Modu:',
    'correctTotal': (int correct, int total) =>
        'Doğru: $correct / Toplam: $total',
    'clear': 'Temizle',
    'pen': 'Kalem',
    'eraser': 'Silgi',
    'recognize': 'Tanımla',
  },
  AppLanguage.english: {
    'sequentialMode': 'Sequential Drawing Mode:',
    'correctTotal': (int correct, int total) =>
        'Correct: $correct / Total: $total',
    'clear': 'Clear',
    'pen': 'Pen',
    'eraser': 'Eraser',
    'recognize': 'Recognize',
  },
  AppLanguage.chinese: {
    'sequentialMode': '顺序绘画模式：',
    'correctTotal': (int correct, int total) => '正确: $correct / 总数: $total',
    'clear': '清除',
    'pen': '笔',
    'eraser': '橡皮擦',
    'recognize': '识别',
  },
  AppLanguage.spanish: {
    'sequentialMode': 'Modo de dibujo secuencial:',
    'correctTotal': (int correct, int total) =>
        'Correcto: $correct / Total: $total',
    'clear': 'Limpiar',
    'pen': 'Bolígrafo',
    'eraser': 'Borrador',
    'recognize': 'Reconocer',
  },
  AppLanguage.hindi: {
    'sequentialMode': 'अनुक्रमिक चित्रण मोड:',
    'correctTotal': (int correct, int total) => 'सही: $correct / कुल: $total',
    'clear': 'साफ़ करें',
    'pen': 'कलम',
    'eraser': 'रबर',
    'recognize': 'पहचानें',
  },
  AppLanguage.french: {
    'sequentialMode': 'Mode de dessin séquentiel :',
    'correctTotal': (int correct, int total) =>
        'Correct : $correct / Total : $total',
    'clear': 'Effacer',
    'pen': 'Stylo',
    'eraser': 'Gomme',
    'recognize': 'Reconnaître',
  },
  AppLanguage.arabic: {
    'sequentialMode': 'وضع الرسم المتسلسل:',
    'correctTotal': (int correct, int total) =>
        'صحيح: $correct / الإجمالي: $total',
    'clear': 'مسح',
    'pen': 'قلم',
    'eraser': 'ممحاة',
    'recognize': 'تعرّف',
  },
  AppLanguage.portuguese: {
    'sequentialMode': 'Modo de desenho sequencial:',
    'correctTotal': (int correct, int total) =>
        'Correto: $correct / Total: $total',
    'clear': 'Limpar',
    'pen': 'Caneta',
    'eraser': 'Borracha',
    'recognize': 'Reconhecer',
  },
  AppLanguage.bengali: {
    'sequentialMode': 'ক্রমিক আঁকার মোড:',
    'correctTotal': (int correct, int total) => 'সঠিক: $correct / মোট: $total',
    'clear': 'পরিষ্কার করুন',
    'pen': 'কলম',
    'eraser': 'রাবার',
    'recognize': 'সনাক্ত করুন',
  },
  AppLanguage.russian: {
    'sequentialMode': 'Режим последовательного рисования:',
    'correctTotal': (int correct, int total) =>
        'Правильно: $correct / Всего: $total',
    'clear': 'Очистить',
    'pen': 'Ручка',
    'eraser': 'Ластик',
    'recognize': 'Распознать',
  },
  AppLanguage.urdu: {
    'sequentialMode': 'تسلسلی ڈرائنگ موڈ:',
    'correctTotal': (int correct, int total) => 'درست: $correct / کل: $total',
    'clear': 'صاف کریں',
    'pen': 'قلم',
    'eraser': 'ریزر',
    'recognize': 'پہچانیں',
  },
  AppLanguage.azerbaijani: {
    'sequentialMode': 'Ardıcıl çəkmə rejimi:',
    'correctTotal': (int correct, int total) =>
        'Düzgün: $correct / Cəmi: $total',
    'clear': 'Təmizlə',
    'pen': 'Qələm',
    'eraser': 'Pozan',
    'recognize': 'Tanın',
  },
  AppLanguage.german: {
    'sequentialMode': 'Sequenzieller Zeichenmodus:',
    'correctTotal': (int correct, int total) =>
        'Richtig: $correct / Gesamt: $total',
    'clear': 'Löschen',
    'pen': 'Stift',
    'eraser': 'Radiergummi',
    'recognize': 'Erkennen',
  },
};

final localizedToolControlPanelTexts = {
  AppLanguage.turkish: {
    'penColor': 'Kalem Rengi',
    'numberTitle': 'Rakam Öğrenme',
    'letterTitle': 'Harf Öğrenme',
    'shapeTitle': 'Şekil Öğrenme',
  },
  AppLanguage.english: {
    'penColor': 'Pen Color',
    'numberTitle': 'Learn Numbers',
    'letterTitle': 'Learn Letters',
    'shapeTitle': 'Learn Shapes',
  },
  AppLanguage.chinese: {
    'penColor': '笔的颜色',
    'numberTitle': '学习数字',
    'letterTitle': '学习字母',
    'shapeTitle': '学习形状',
  },
  AppLanguage.spanish: {
    'penColor': 'Color del bolígrafo',
    'numberTitle': 'Aprender números',
    'letterTitle': 'Aprender letras',
    'shapeTitle': 'Aprender figuras',
  },
  AppLanguage.hindi: {
    'penColor': 'कलम का रंग',
    'numberTitle': 'संख्या सीखें',
    'letterTitle': 'अक्षर सीखें',
    'shapeTitle': 'आकृतियाँ सीखें',
  },
  AppLanguage.french: {
    'penColor': 'Couleur du stylo',
    'numberTitle': 'Apprendre les chiffres',
    'letterTitle': 'Apprendre les lettres',
    'shapeTitle': 'Apprendre les formes',
  },
  AppLanguage.arabic: {
    'penColor': 'لون القلم',
    'numberTitle': 'تعلم الأرقام',
    'letterTitle': 'تعلم الحروف',
    'shapeTitle': 'تعلم الأشكال',
  },
  AppLanguage.portuguese: {
    'penColor': 'Cor da caneta',
    'numberTitle': 'Aprender números',
    'letterTitle': 'Aprender letras',
    'shapeTitle': 'Aprender formas',
  },
  AppLanguage.bengali: {
    'penColor': 'কলমের রং',
    'numberTitle': 'সংখ্যা শিখুন',
    'letterTitle': 'অক্ষর শিখুন',
    'shapeTitle': 'আকৃতি শিখুন',
  },
  AppLanguage.russian: {
    'penColor': 'Цвет ручки',
    'numberTitle': 'Изучать числа',
    'letterTitle': 'Изучать буквы',
    'shapeTitle': 'Изучать фигуры',
  },
  AppLanguage.urdu: {
    'penColor': 'قلم کا رنگ',
    'numberTitle': 'نمبر سیکھیں',
    'letterTitle': 'حروف سیکھیں',
    'shapeTitle': 'اشکال سیکھیں',
  },
  AppLanguage.azerbaijani: {
    'penColor': 'Qələm rəngi',
    'numberTitle': 'Rəqəmləri öyrən',
    'letterTitle': 'Hərfləri öyrən',
    'shapeTitle': 'Fiqurları öyrən',
  },
  AppLanguage.german: {
    'penColor': 'Stiftfarbe',
    'numberTitle': 'Zahlen lernen',
    'letterTitle': 'Buchstaben lernen',
    'shapeTitle': 'Formen lernen',
  },
};

final localizedInfoScreenTexts = {
  AppLanguage.turkish: {
    'drawingNotFound': 'Çizim Bulunamadı',
    'drawnLetter': 'Çizdiğin Harf',
    'congrats': 'Tebrikler!',
    'successMessage': 'Harika iş çıkardın! Bu harfi doğru bir şekilde tanıdım!',
    'back': 'Geri Dön',
  },
  AppLanguage.english: {
    'drawingNotFound': 'Drawing Not Found',
    'drawnLetter': 'Your Drawing',
    'congrats': 'Congratulations!',
    'successMessage': 'Great job! I recognized this letter correctly!',
    'back': 'Go Back',
  },
  AppLanguage.chinese: {
    'drawingNotFound': '未找到绘图',
    'drawnLetter': '你的绘图',
    'congrats': '恭喜！',
    'successMessage': '干得好！我正确识别了这个字母！',
    'back': '返回',
  },
  AppLanguage.spanish: {
    'drawingNotFound': 'Dibujo no encontrado',
    'drawnLetter': 'Tu dibujo',
    'congrats': '¡Felicidades!',
    'successMessage': '¡Buen trabajo! ¡He reconocido esta letra correctamente!',
    'back': 'Volver',
  },
  AppLanguage.hindi: {
    'drawingNotFound': 'चित्र नहीं मिला',
    'drawnLetter': 'आपकी ड्राइंग',
    'congrats': 'बधाई हो!',
    'successMessage': 'शानदार! मैंने इस अक्षर को सही पहचाना!',
    'back': 'वापस जाएं',
  },
  AppLanguage.french: {
    'drawingNotFound': 'Dessin non trouvé',
    'drawnLetter': 'Votre dessin',
    'congrats': 'Félicitations !',
    'successMessage': 'Bravo ! J\'ai reconnu cette lettre correctement !',
    'back': 'Retour',
  },
  AppLanguage.arabic: {
    'drawingNotFound': 'لم يتم العثور على الرسم',
    'drawnLetter': 'رسمك',
    'congrats': 'تهانينا!',
    'successMessage': 'عمل رائع! لقد تعرفت على هذا الحرف بشكل صحيح!',
    'back': 'عودة',
  },
  AppLanguage.portuguese: {
    'drawingNotFound': 'Desenho não encontrado',
    'drawnLetter': 'Seu desenho',
    'congrats': 'Parabéns!',
    'successMessage': 'Ótimo trabalho! Reconheci esta letra corretamente!',
    'back': 'Voltar',
  },
  AppLanguage.bengali: {
    'drawingNotFound': 'অঙ্কন পাওয়া যায়নি',
    'drawnLetter': 'তোমার অঙ্কন',
    'congrats': 'অভিনন্দন!',
    'successMessage': 'দারুণ কাজ! আমি এই অক্ষরটি সঠিকভাবে চিনতে পেরেছি!',
    'back': 'ফিরে যাও',
  },
  AppLanguage.russian: {
    'drawingNotFound': 'Рисунок не найден',
    'drawnLetter': 'Ваш рисунок',
    'congrats': 'Поздравляем!',
    'successMessage': 'Отличная работа! Я правильно распознал эту букву!',
    'back': 'Назад',
  },
  AppLanguage.urdu: {
    'drawingNotFound': 'ڈراؤنگ نہیں ملی',
    'drawnLetter': 'آپ کی ڈرائنگ',
    'congrats': 'مبارک ہو!',
    'successMessage': 'زبردست! میں نے اس حرف کو صحیح پہچانا!',
    'back': 'واپس جائیں',
  },
  AppLanguage.azerbaijani: {
    'drawingNotFound': 'Çizim tapılmadı',
    'drawnLetter': 'Sənin çəkdiyin',
    'congrats': 'Təbriklər!',
    'successMessage': 'Əla iş! Bu hərfi düzgün tanıdım!',
    'back': 'Geri dön',
  },
  AppLanguage.german: {
    'drawingNotFound': 'Zeichnung nicht gefunden',
    'drawnLetter': 'Dein gezeichneter Buchstabe',
    'congrats': 'Glückwunsch!',
    'successMessage':
        'Großartige Arbeit! Ich habe diesen Buchstaben richtig erkannt!',
    'back': 'Zurück',
  },
};

final localizedResultScreenTexts = {
  AppLanguage.turkish: {
    'drawingNotFound': 'Çizim Bulunamadı',
    'drawn': 'Çizdiğin:',
    'congrats': 'Tebrikler!',
    'tryAgain': 'Tekrar Dene!',
    'targetLetter': 'Hedef Çizim:',
    'successMessage':
        'Harika iş çıkardın! Çizimini doğru bir şekilde tanıdım!',
    'failMessage':
        'Tekrar denemelisin! Çizimin farklı bir şeye benziyor.',
    'progress': (int correct, int total) => 'Doğru: $correct / Toplam: $total',
    'tryAgainBtn': 'Tekrar Dene',
    'nextLetter': 'Sonrakine Geç',
    'nextLetterFail': 'Sonrakine Geç',
  },
  AppLanguage.english: {
    'drawingNotFound': 'Drawing Not Found',
    'drawn': 'Your Drawing:',
    'congrats': 'Congratulations!',
    'tryAgain': 'Try Again!',
    'targetLetter': 'Target:',
    'successMessage': 'Great job! I recognized your drawing correctly!',
    'failMessage': 'Try again! Your drawing looks like something else.',
    'progress': (int correct, int total) => 'Correct: $correct / Total: $total',
    'tryAgainBtn': 'Try Again',
    'nextLetter': 'Next',
    'nextLetterFail': 'Go to Next',
  },
  AppLanguage.chinese: {
    'drawingNotFound': '未找到绘图',
    'drawn': '你画的是：',
    'congrats': '恭喜！',
    'tryAgain': '请再试一次！',
    'targetLetter': '目标：',
    'successMessage': '干得好！我正确识别了你的绘画！',
    'failMessage': '请再试一次！你的绘画看起来像别的东西。',
    'progress': (int correct, int total) => '正确: $correct / 总数: $total',
    'tryAgainBtn': '再试一次',
    'nextLetter': '下一个',
    'nextLetterFail': '跳到下一个',
  },
  AppLanguage.spanish: {
    'drawingNotFound': 'Dibujo no encontrado',
    'drawn': 'Tu dibujo:',
    'congrats': '¡Felicidades!',
    'tryAgain': '¡Inténtalo de nuevo!',
    'targetLetter': 'Objetivo:',
    'successMessage':
        '¡Buen trabajo! ¡He reconocido correctamente tu dibujo!',
    'failMessage':
        '¡Inténtalo de nuevo! Tu dibujo parece otra cosa.',
    'progress': (int correct, int total) =>
        'Correcto: $correct / Total: $total',
    'tryAgainBtn': 'Intentar de nuevo',
    'nextLetter': 'Siguiente',
    'nextLetterFail': 'Ir al siguiente',
  },
  AppLanguage.hindi: {
    'drawingNotFound': 'चित्र नहीं मिला',
    'drawn': 'आपकी ड्राइंग:',
    'congrats': 'बधाई हो!',
    'tryAgain': 'फिर से प्रयास करें!',
    'targetLetter': 'लक्ष्य:',
    'successMessage': 'शानदार! मैंने आपकी ड्राइंग को सही पहचाना!',
    'failMessage':
        'फिर से प्रयास करें! आपकी ड्राइंग किसी और चीज़ जैसी लगती है।',
    'progress': (int correct, int total) => 'सही: $correct / कुल: $total',
    'tryAgainBtn': 'फिर से प्रयास करें',
    'nextLetter': 'आगे बढ़ें',
    'nextLetterFail': 'अगले पर जाएं',
  },
  AppLanguage.french: {
    'drawingNotFound': 'Dessin non trouvé',
    'drawn': 'Votre dessin :',
    'congrats': 'Félicitations !',
    'tryAgain': 'Réessayez !',
    'targetLetter': 'Cible :',
    'successMessage':
        'Bravo ! J\'ai correctement reconnu votre dessin !',
    'failMessage':
        'Réessayez ! Votre dessin ressemble à autre chose.',
    'progress': (int correct, int total) =>
        'Correct : $correct / Total : $total',
    'tryAgainBtn': 'Réessayer',
    'nextLetter': 'Suivant',
    'nextLetterFail': 'Passer au suivant',
  },
  AppLanguage.arabic: {
    'drawingNotFound': 'لم يتم العثور على الرسم',
    'drawn': 'رسمك:',
    'congrats': 'تهانينا!',
    'tryAgain': 'حاول مرة أخرى!',
    'targetLetter': 'الهدف:',
    'successMessage': 'عمل رائع! لقد تعرفت على رسمك بشكل صحيح!',
    'failMessage': 'حاول مرة أخرى! يبدو أن رسمك يشبه شيئًا آخر.',
    'progress': (int correct, int total) => 'صحيح: $correct / الإجمالي: $total',
    'tryAgainBtn': 'حاول مرة أخرى',
    'nextLetter': 'التالي',
    'nextLetterFail': 'انتقل إلى التالي',
  },
  AppLanguage.portuguese: {
    'drawingNotFound': 'Desenho não encontrado',
    'drawn': 'Seu desenho:',
    'congrats': 'Parabéns!',
    'tryAgain': 'Tente novamente!',
    'targetLetter': 'Alvo:',
    'successMessage':
        'Ótimo trabalho! Reconheci corretamente o seu desenho!',
    'failMessage':
        'Tente novamente! Seu desenho parece outra coisa.',
    'progress': (int correct, int total) => 'Correto: $correct / Total: $total',
    'tryAgainBtn': 'Tentar novamente',
    'nextLetter': 'Próximo',
    'nextLetterFail': 'Ir para o próximo',
  },
  AppLanguage.bengali: {
    'drawingNotFound': 'অঙ্কন পাওয়া যায়নি',
    'drawn': 'তোমার অঙ্কন:',
    'congrats': 'অভিনন্দন!',
    'tryAgain': 'আবার চেষ্টা করুন!',
    'targetLetter': 'লক্ষ্যঃ',
    'successMessage':
        'দারুণ কাজ! আমি তোমার অঙ্কনটি সঠিকভাবে চিনতে পেরেছি!',
    'failMessage':
        'আবার চেষ্টা করুন! তোমার অঙ্কনটি অন্য কিছুর মতো দেখাচ্ছে।',
    'progress': (int correct, int total) => 'সঠিক: $correct / মোট: $total',
    'tryAgainBtn': 'আবার চেষ্টা করুন',
    'nextLetter': 'পরবর্তী',
    'nextLetterFail': 'পরবর্তীতে যান',
  },
  AppLanguage.russian: {
    'drawingNotFound': 'Рисунок не найден',
    'drawn': 'Ваш рисунок:',
    'congrats': 'Поздравляем!',
    'tryAgain': 'Попробуйте еще раз!',
    'targetLetter': 'Цель:',
    'successMessage':
        'Отличная работа! Я правильно распознал ваш рисунок!',
    'failMessage':
        'Попробуйте еще раз! Ваш рисунок похож на что‑то другое.',
    'progress': (int correct, int total) =>
        'Правильно: $correct / Всего: $total',
    'tryAgainBtn': 'Попробовать снова',
    'nextLetter': 'Далее',
    'nextLetterFail': 'Перейти далее',
  },
  AppLanguage.urdu: {
    'drawingNotFound': 'ڈراؤنگ نہیں ملی',
    'drawn': 'آپ کی ڈرائنگ:',
    'congrats': 'مبارک ہو!',
    'tryAgain': 'دوبارہ کوشش کریں!',
    'targetLetter': 'ہدف:',
    'successMessage': 'زبردست! میں نے آپ کی ڈرائنگ کو صحیح پہچانا!',
    'failMessage':
        'دوبارہ کوشش کریں! آپ کی ڈرائنگ کسی اور چیز جیسی لگتی ہے۔',
    'progress': (int correct, int total) => 'درست: $correct / کل: $total',
    'tryAgainBtn': 'دوبارہ کوشش کریں',
    'nextLetter': 'اگلا',
    'nextLetterFail': 'اگلے پر جائیں',
  },
  AppLanguage.azerbaijani: {
    'drawingNotFound': 'Çizim tapılmadı',
    'drawn': 'Sənin çəkdiyin:',
    'congrats': 'Təbriklər!',
    'tryAgain': 'Yenidən cəhd et!',
    'targetLetter': 'Hədəf:',
    'successMessage': 'Əla iş! Çizimini düzgün tanıdım!',
    'failMessage':
        'Yenidən cəhd et! Çizimin başqa bir şeyə bənzəyir.',
    'progress': (int correct, int total) => 'Düzgün: $correct / Cəmi: $total',
    'tryAgainBtn': 'Yenidən cəhd et',
    'nextLetter': 'Növbəti',
    'nextLetterFail': 'Növbətiyə keç',
  },
  AppLanguage.german: {
    'drawingNotFound': 'Zeichnung nicht gefunden',
    'drawn': 'Deine Zeichnung:',
    'congrats': 'Glückwunsch!',
    'tryAgain': 'Nochmal versuchen!',
    'targetLetter': 'Ziel:',
    'successMessage':
        'Großartige Arbeit! Ich habe deine Zeichnung richtig erkannt!',
    'failMessage':
        'Versuche es erneut! Deine Zeichnung sieht nach etwas anderem aus.',
    'progress': (int correct, int total) =>
        'Richtig: $correct / Gesamt: $total',
    'tryAgainBtn': 'Nochmal versuchen',
    'nextLetter': 'Weiter',
    'nextLetterFail': 'Zum nächsten',
  },
};

final localizedTexts = {
  'hello': {
    AppLanguage.turkish: 'Merhaba',
    AppLanguage.english: 'Hello',
    AppLanguage.chinese: '你好',
    AppLanguage.spanish: 'Hola',
    AppLanguage.hindi: 'नमस्ते',
    AppLanguage.french: 'Bonjour',
    AppLanguage.arabic: 'مرحبا',
    AppLanguage.portuguese: 'Olá',
    AppLanguage.bengali: 'হ্যালো',
    AppLanguage.russian: 'Здравствуйте',
    AppLanguage.urdu: 'سلام',
    AppLanguage.azerbaijani: 'Salam',
    AppLanguage.german: 'Hallo',
  },
  'slogan': {
    AppLanguage.turkish: 'Çiz, Öğren, Eğlen!',
    AppLanguage.english: 'Draw, Learn, Have Fun!',
    AppLanguage.chinese: '画画，学习，玩耍！',
    AppLanguage.spanish: '¡Dibuja, aprende, diviértete!',
    AppLanguage.hindi: 'ड्रॉ करें, सीखें, मज़े करें!',
    AppLanguage.french: 'Dessine, apprends, amuse-toi !',
    AppLanguage.arabic: 'ارسم، تعلم، استمتع!',
    AppLanguage.portuguese: 'Desenhe, aprenda, divirta-se!',
    AppLanguage.bengali: 'আঁকো, শিখো, মজা করো!',
    AppLanguage.russian: 'Рисуй, учись, развлекайся!',
    AppLanguage.urdu: 'ڈرا کریں، سیکھیں، مزہ کریں!',
    AppLanguage.azerbaijani: 'Çək, öyrən, əylən!',
    AppLanguage.german: 'Zeichne, lerne, hab Spaß!',
  },
  'seeTutorial': {
    AppLanguage.turkish: 'Öğreticiye bak',
    AppLanguage.english: 'See Tutorial',
    AppLanguage.chinese: '查看教程',
    AppLanguage.spanish: 'Ver tutorial',
    AppLanguage.hindi: 'ट्यूटोरियल देखें',
    AppLanguage.french: 'Voir le tutoriel',
    AppLanguage.arabic: 'شاهد البرنامج التعليمي',
    AppLanguage.portuguese: 'Ver tutorial',
    AppLanguage.bengali: 'টিউটোরিয়াল দেখুন',
    AppLanguage.russian: 'Смотреть учебник',
    AppLanguage.urdu: 'سبق دیکھیں',
    AppLanguage.azerbaijani: 'Təlimata bax',
    AppLanguage.german: 'Tutorial ansehen',
  },
  'tutorial': {
    AppLanguage.turkish: 'Öğretici',
    AppLanguage.english: 'Tutorial',
    AppLanguage.chinese: '教程',
    AppLanguage.spanish: 'Tutorial',
    AppLanguage.hindi: 'ट्यूटोरियल',
    AppLanguage.french: 'Tutoriel',
    AppLanguage.arabic: 'البرنامج التعليمي',
    AppLanguage.portuguese: 'Tutorial',
    AppLanguage.bengali: 'টিউটোরিয়াল',
    AppLanguage.russian: 'Учебник',
    AppLanguage.urdu: 'سبق',
    AppLanguage.azerbaijani: 'Təlimat',
    AppLanguage.german: 'Tutorial',
  },
  'drawNumberInstruction': {
    AppLanguage.turkish: '{number} rakamını çiziniz',
    AppLanguage.english: 'Draw the number {number}',
    AppLanguage.chinese: '{number} 数字を描いてください',
    AppLanguage.spanish: 'Dibuja el número {number}',
    AppLanguage.hindi: 'संख्या {number} बनाएं',
    AppLanguage.french: 'Dessine le chiffre {number}',
    AppLanguage.arabic: 'ارسم الرقم {number}',
    AppLanguage.portuguese: 'Desenhe o número {number}',
    AppLanguage.bengali: '{number} নম্বরটি আঁকুন',
    AppLanguage.russian: 'Нарисуйте цифру {number}',
    AppLanguage.urdu: '{number} نمبر بنائیں',
    AppLanguage.azerbaijani: '{number} rəqəmini çəkin',
    AppLanguage.german: 'Zeichne die Zahl {number}',
  },
  'drawAnyNumberInstruction': {
    AppLanguage.turkish: 'Bir rakam çiziniz',
    AppLanguage.english: 'Draw a number',
    AppLanguage.chinese: '任意数字を描いてください',
    AppLanguage.spanish: 'Dibuja un número',
    AppLanguage.hindi: 'कोई संख्या बनाएं',
    AppLanguage.french: 'Dessine un chiffre',
    AppLanguage.arabic: 'ارسم رقماً',
    AppLanguage.portuguese: 'Desenhe um número',
    AppLanguage.bengali: 'একটি নম্বর আঁকুন',
    AppLanguage.russian: 'Нарисуйте любую цифру',
    AppLanguage.urdu: 'کوئی نمبر بنائیں',
    AppLanguage.azerbaijani: 'Bir rəqəm çəkin',
    AppLanguage.german: 'Zeichne eine Zahl',
  },
  'watchAdToUnlock': {
    AppLanguage.turkish: 'Bu Bölümü Açmak için Reklam izle Puan Topla',
    AppLanguage.english: 'Watch ads to earn points and unlock this section',
    AppLanguage.chinese: '观看广告赚取积分以解锁此部分',
    AppLanguage.spanish:
        'Mira anuncios para ganar puntos y desbloquear esta sección',
    AppLanguage.hindi:
        'इस अनुभाग को अनलॉक करने के लिए विज्ञापन देखें और अंक अर्जित करें',
    AppLanguage.french:
        'Regardez des publicités pour gagner des points et débloquer cette section',
    AppLanguage.arabic: 'شاهد الإعلانات لكسب النقاط وفتح هذا القسم',
    AppLanguage.portuguese:
        'Assista anúncios para ganhar pontos e desbloquear esta seção',
    AppLanguage.bengali:
        'এই অংশটি আনলক করতে বিজ্ঞাপন দেখুন এবং পয়েন্ট অর্জন করুন',
    AppLanguage.russian:
        'Смотрите рекламу, чтобы заработать очки и открыть этот раздел',
    AppLanguage.urdu:
        'اس سیکشن کو کھولنے کے لیے اشتہارات دیکھیں اور پوائنٹس حاصل کریں',
    AppLanguage.azerbaijani: 'Bu bölməni açmaq üçün reklam izləyib xal topla',
    AppLanguage.german:
        'Sieh dir Werbung an, um Punkte zu sammeln und diesen Bereich freizuschalten',
  },
};

String getLocalizedText(String key, AppLanguage lang) {
  return localizedTexts[key]?[lang] ??
      localizedTexts[key]?[AppLanguage.english] ??
      '';
}

/// Şekil adları için dil bazlı gösterim (özellikle sonuç ekranında daire/üçgen/kare)
///
/// Anahtar olarak, model ve sıralı modda kullanılan Türkçe büyük harf kodları
/// kullanılıyor: 'DAIRE', 'KARE', 'ÜÇGEN'.
final Map<AppLanguage, Map<String, String>> localizedShapeNames = {
  AppLanguage.turkish: {
    'DAIRE': 'Daire',
    'KARE': 'Kare',
    'ÜÇGEN': 'Üçgen',
  },
  AppLanguage.english: {
    'DAIRE': 'Circle',
    'KARE': 'Square',
    'ÜÇGEN': 'Triangle',
  },
  AppLanguage.chinese: {
    'DAIRE': '圆形',
    'KARE': '正方形',
    'ÜÇGEN': '三角形',
  },
  AppLanguage.spanish: {
    'DAIRE': 'Círculo',
    'KARE': 'Cuadrado',
    'ÜÇGEN': 'Triángulo',
  },
  AppLanguage.hindi: {
    'DAIRE': 'वृत्त',
    'KARE': 'वर्ग',
    'ÜÇGEN': 'त्रिभुज',
  },
  AppLanguage.french: {
    'DAIRE': 'Cercle',
    'KARE': 'Carré',
    'ÜÇGEN': 'Triangle',
  },
  AppLanguage.arabic: {
    'DAIRE': 'دائرة',
    'KARE': 'مربع',
    'ÜÇGEN': 'مثلث',
  },
  AppLanguage.portuguese: {
    'DAIRE': 'Círculo',
    'KARE': 'Quadrado',
    'ÜÇGEN': 'Triângulo',
  },
  AppLanguage.bengali: {
    'DAIRE': 'বৃত্ত',
    'KARE': 'বর্গ',
    'ÜÇGEN': 'ত্রিভুজ',
  },
  AppLanguage.russian: {
    'DAIRE': 'Круг',
    'KARE': 'Квадрат',
    'ÜÇGEN': 'Треугольник',
  },
  AppLanguage.urdu: {
    'DAIRE': 'دایره',
    'KARE': 'مربع',
    'ÜÇGEN': 'مثلث',
  },
  AppLanguage.azerbaijani: {
    'DAIRE': 'Dairə',
    'KARE': 'Kvadrat',
    'ÜÇGEN': 'Üçbucaq',
  },
  AppLanguage.german: {
    'DAIRE': 'Kreis',
    'KARE': 'Quadrat',
    'ÜÇGEN': 'Dreieck',
  },
};

/// Şekil kodunu (ör. 'DAIRE', 'KARE', 'ÜÇGEN') aktif dile göre kullanıcıya
/// gösterilecek metne çevirir. Eşleşme bulunamazsa orijinal kodu geri döner.
String getLocalizedShapeName(String shapeCode, AppLanguage lang) {
  final upperCode = shapeCode.toUpperCase();
  return localizedShapeNames[lang]?[upperCode] ??
      localizedShapeNames[AppLanguage.english]?[upperCode] ??
      shapeCode;
}
