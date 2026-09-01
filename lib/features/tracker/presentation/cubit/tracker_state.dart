import 'package:equatable/equatable.dart';
import '../../domain/entities/crime_alert.dart';

enum PatrolStatus { active, standby }

final class TrackerState extends Equatable {
  final PatrolStatus patrolStatus;
  final double webFluidPercentage;
  final double citySafetyIndex;
  final List<CrimeAlert> alerts;
  final bool isScanning;
  final String? errorMessage;

  const TrackerState({
    this.patrolStatus = PatrolStatus.active,
    this.webFluidPercentage = 0.92,
    this.citySafetyIndex = 84.5,
    this.alerts = const [],
    this.isScanning = false,
    this.errorMessage,
  });

  bool get isPatrolActive => patrolStatus == PatrolStatus.active;
  int get activeAlertsCount => alerts.where((a) => !a.isResolved).length;

  TrackerState copyWith({
    PatrolStatus? patrolStatus,
    double? webFluidPercentage,
    double? citySafetyIndex,
    List<CrimeAlert>? alerts,
    bool? isScanning,
    String? errorMessage,
  }) {
    return TrackerState(
      patrolStatus: patrolStatus ?? this.patrolStatus,
      webFluidPercentage: webFluidPercentage ?? this.webFluidPercentage,
      citySafetyIndex: citySafetyIndex ?? this.citySafetyIndex,
      alerts: alerts ?? this.alerts,
      isScanning: isScanning ?? this.isScanning,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        patrolStatus,
        webFluidPercentage,
        citySafetyIndex,
        alerts,
        isScanning,
        errorMessage,
      ];
}
