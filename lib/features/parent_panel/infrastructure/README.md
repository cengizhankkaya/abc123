# Parent Panel — Infrastructure Layer

Bu dizin, `01_project_structure.md` standardına göre `data/` katmanına karşılık gelen
infrastructure implementasyonlarını içerir.

## Mevcut Durum

Şu an `features/parent_panel/data/` altında çalışan implementasyonlar mevcuttur.
Kodun kararlılığını korumak için tam migration ayrı bir adımda yapılacaktır.

## Hedef Yapı

```
infrastructure/
├── datasources/   # ParentLocalDataSource, ProgressDataSource
├── mappers/       # ScreenTime ↔ domain mappers
├── models/        # ScreenTimeModel, ProgressModel (DTO)
└── repositories/  # IParentPanelRepository impl
```

## Referans

Mevcut implementasyon: `features/parent_panel/data/`
