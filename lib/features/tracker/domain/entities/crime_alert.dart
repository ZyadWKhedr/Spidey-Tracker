import 'package:equatable/equatable.dart';

enum AlertSeverity { low, medium, high, critical }

class CrimeAlert extends Equatable {
  final String id;
  final String title;
  final String location;
  final String timestamp;
  final AlertSeverity severity;
  final String description;
  final bool isResolved;

  const CrimeAlert({
    required this.id,
    required this.title,
    required this.location,
    required this.timestamp,
    required this.severity,
    required this.description,
    this.isResolved = false,
  });

  CrimeAlert copyWith({
    String? id,
    String? title,
    String? location,
    String? timestamp,
    AlertSeverity? severity,
    String? description,
    bool? isResolved,
  }) {
    return CrimeAlert(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      timestamp: timestamp ?? this.timestamp,
      severity: severity ?? this.severity,
      description: description ?? this.description,
      isResolved: isResolved ?? this.isResolved,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        timestamp,
        severity,
        description,
        isResolved,
      ];
}
