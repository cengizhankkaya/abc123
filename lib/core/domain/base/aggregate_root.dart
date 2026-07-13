import 'package:abc123/core/domain/base/entity.dart';

abstract class DomainEvent {
  const DomainEvent();
}

abstract class AggregateRoot extends Entity {
  final List<DomainEvent> _domainEvents = [];

  List<DomainEvent> get domainEvents => List.unmodifiable(_domainEvents);

  void addDomainEvent(DomainEvent event) {
    _domainEvents.add(event);
  }

  void clearDomainEvents() {
    _domainEvents.clear();
  }
}
