import '../../domain/entities/crime_alert.dart';

class CrimeAlertModel extends CrimeAlert {
  const CrimeAlertModel({
    required super.id,
    required super.title,
    required super.location,
    required super.timestamp,
    required super.severity,
    required super.description,
    super.isResolved,
  });

  factory CrimeAlertModel.fromJson(Map<String, dynamic> json) {
    return CrimeAlertModel(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      timestamp: json['timestamp'] as String,
      severity: _parseSeverity(json['severity'] as String?),
      description: json['description'] as String,
      isResolved: json['isResolved'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'timestamp': timestamp,
      'severity': severity.name,
      'description': description,
      'isResolved': isResolved,
    };
  }

  static AlertSeverity _parseSeverity(String? severity) {
    switch (severity?.toLowerCase()) {
      case 'critical':
        return AlertSeverity.critical;
      case 'high':
        return AlertSeverity.high;
      case 'medium':
        return AlertSeverity.medium;
      case 'low':
      default:
        return AlertSeverity.low;
    }
  }
}
