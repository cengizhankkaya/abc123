import re

path = 'test/features/home/application/quest_rollover_resolver_test.dart'
with open(path, 'r') as f:
    content = f.read()

content = content.replace('hasLength(3)', 'hasLength(7)')

dummy_quests = """
          Quest(id: 'daily_color_$dayKey', titleKey: 'daily_color', targetType: DrawingType.any, targetCount: 1, rewardPoints: 10),
          Quest(id: 'daily_word_$dayKey', titleKey: 'daily_word', targetType: DrawingType.any, targetCount: 1, rewardPoints: 10),
          Quest(id: 'weekly_letters_$weekKey', titleKey: 'weekly_letters', targetType: DrawingType.any, targetCount: 1, rewardPoints: 10),
          Quest(id: 'weekly_shapes_$weekKey', titleKey: 'weekly_shapes', targetType: DrawingType.any, targetCount: 1, rewardPoints: 10),
"""

dummy_quests_no_vars = """
          Quest(id: 'daily_color_2026-01-01', titleKey: 'daily_color', targetType: DrawingType.any, targetCount: 1, rewardPoints: 10),
          Quest(id: 'daily_word_2026-01-01', titleKey: 'daily_word', targetType: DrawingType.any, targetCount: 1, rewardPoints: 10),
          Quest(id: 'weekly_letters_2026W01', titleKey: 'weekly_letters', targetType: DrawingType.any, targetCount: 1, rewardPoints: 10),
          Quest(id: 'weekly_shapes_2026W01', titleKey: 'weekly_shapes', targetType: DrawingType.any, targetCount: 1, rewardPoints: 10),
"""

content = content.replace("rewardPoints: 100,\n          ),\n        ],", "rewardPoints: 100,\n          )," + dummy_quests + "        ],")
content = content.replace("rewardPoints: 100,\n          ),\n        ],\n      );\n\n      final r = resolver.resolve(now: DateTime(2026, 4, 13), saved: saved);", "rewardPoints: 100,\n          )," + dummy_quests_no_vars + "        ],\n      );\n\n      final r = resolver.resolve(now: DateTime(2026, 4, 13), saved: saved);")

with open(path, 'w') as f:
    f.write(content)

print("Patched test file.")
