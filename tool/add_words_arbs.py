import json
import os

arb_dir = 'lib/features/words/l10n'
en_file = os.path.join(arb_dir, 'words_en.arb')

missing_locales = ['zh', 'es', 'hi', 'fr', 'ar', 'pt', 'bn', 'ru', 'ur', 'az', 'de']

with open(en_file, 'r', encoding='utf-8') as f:
    en_data = json.load(f)

for loc in missing_locales:
    target_data = en_data.copy()
    target_data['@@locale'] = loc
    
    target_path = os.path.join(arb_dir, f'words_{loc}.arb')
    with open(target_path, 'w', encoding='utf-8') as f:
        json.dump(target_data, f, ensure_ascii=False, indent=2)
    print(f'Created {target_path}')
