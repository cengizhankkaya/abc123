/// Kimlik tabanlı eşitlik için temel sınıf (`03_domain_layer.md`, `11_data_modeling.md`).
///
/// Domain varlıkları freezed kullanmaz; güncellemeler `copyWith` ile yapılır.
abstract class Entity {
  Object get entityId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entity && runtimeType == other.runtimeType && entityId == other.entityId;

  @override
  int get hashCode => entityId.hashCode;
}
