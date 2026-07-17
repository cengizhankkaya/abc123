import json
import os

keys_by_lang = {
    "en": {
        "colorFailureLoad": "Game could not be loaded. Please try again.",
        "colorFailurePalette": "Could not fetch color palette.",
        "colorFailureUnknown": "An unexpected error occurred."
    },
    "tr": {
        "colorFailureLoad": "Oyun yüklenemedi. Lütfen tekrar deneyin.",
        "colorFailurePalette": "Renk paleti alınamadı.",
        "colorFailureUnknown": "Beklenmeyen bir hata oluştu."
    },
    "ar": {
        "colorFailureLoad": "تعذر تحميل اللعبة. يرجى المحاولة مرة أخرى.",
        "colorFailurePalette": "تعذر جلب لوحة الألوان.",
        "colorFailureUnknown": "حدث خطأ غير متوقع."
    },
    "az": {
        "colorFailureLoad": "Oyun yüklənə bilmədi. Zəhmət olmasa yenidən cəhd edin.",
        "colorFailurePalette": "Rəng palitrasını almaq mümkün olmadı.",
        "colorFailureUnknown": "Gözlənilməz bir xəta baş verdi."
    },
    "bn": {
        "colorFailureLoad": "গেমটি লোড করা যায়নি। অনুগ্রহ করে আবার চেষ্টা করুন।",
        "colorFailurePalette": "রঙের প্যালেট আনা যায়নি।",
        "colorFailureUnknown": "একটি অপ্রত্যাশিত ত্রুটি ঘটেছে।"
    },
    "de": {
        "colorFailureLoad": "Spiel konnte nicht geladen werden. Bitte versuchen Sie es erneut.",
        "colorFailurePalette": "Farbpalette konnte nicht abgerufen werden.",
        "colorFailureUnknown": "Ein unerwarteter Fehler ist aufgetreten."
    },
    "es": {
        "colorFailureLoad": "El juego no se pudo cargar. Por favor, inténtalo de nuevo.",
        "colorFailurePalette": "No se pudo obtener la paleta de colores.",
        "colorFailureUnknown": "Ocurrió un error inesperado."
    },
    "fr": {
        "colorFailureLoad": "Le jeu n'a pas pu être chargé. Veuillez réessayer.",
        "colorFailurePalette": "Impossible de récupérer la palette de couleurs.",
        "colorFailureUnknown": "Une erreur inattendue s'est produite."
    },
    "hi": {
        "colorFailureLoad": "खेल लोड नहीं किया जा सका। कृपया पुनः प्रयास करें।",
        "colorFailurePalette": "रंग पैलेट प्राप्त नहीं किया जा सका।",
        "colorFailureUnknown": "एक अप्रत्याशित त्रुटि हुई।"
    },
    "pt": {
        "colorFailureLoad": "O jogo não pôde ser carregado. Por favor, tente novamente.",
        "colorFailurePalette": "Não foi possível obter a paleta de cores.",
        "colorFailureUnknown": "Ocorreu um erro inesperado."
    },
    "ru": {
        "colorFailureLoad": "Не удалось загрузить игру. Пожалуйста, попробуйте еще раз.",
        "colorFailurePalette": "Не удалось получить цветовую палитру.",
        "colorFailureUnknown": "Произошла непредвиденная ошибка."
    },
    "ur": {
        "colorFailureLoad": "گیم لوڈ نہیں ہو سکی۔ براہ کرم دوبارہ کوشش کریں۔",
        "colorFailurePalette": "رنگ پیلیٹ حاصل نہیں کیا جا سکا۔",
        "colorFailureUnknown": "ایک غیر متوقع خامی پیش آگئی۔"
    },
    "zh": {
        "colorFailureLoad": "无法加载游戏。请重试。",
        "colorFailurePalette": "无法获取调色板。",
        "colorFailureUnknown": "发生意外错误。"
    }
}

directory = "lib/features/colors/l10n"

for lang, new_keys in keys_by_lang.items():
    filename = f"colors_{lang}.arb"
    filepath = os.path.join(directory, filename)
    if os.path.exists(filepath):
        with open(filepath, "r", encoding="utf-8") as f:
            data = json.load(f)
        
        for k, v in new_keys.items():
            data[k] = v
            
        with open(filepath, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)

print("Updated ARB files")
