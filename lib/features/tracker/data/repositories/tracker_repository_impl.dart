import '../../domain/entities/crime_alert.dart';
import '../../domain/repositories/tracker_repository.dart';
import '../models/crime_alert_model.dart';

class TrackerRepositoryImpl implements TrackerRepository {
  final List<CrimeAlertModel> _mockAlerts = [
    const CrimeAlertModel(
      id: 'DISP-101',
      title: 'Armed Robbery in Progress',
      location: 'Queens Blvd & 46th St',
      timestamp: '2m ago',
      severity: AlertSeverity.critical,
      description: 'Shoplifters trapped clerk at bodegas. Suspects armed.',
    ),
    const CrimeAlertModel(
      id: 'DISP-102',
      title: 'Runaway Crane Cable Snap',
      location: 'Midtown Construction Site',
      timestamp: '6m ago',
      severity: AlertSeverity.high,
      description: 'Cables snapped. Heavy beam dangling over pedestrian zone.',
    ),
    const CrimeAlertModel(
      id: 'DISP-103',
      title: 'Stolen Vehicle Pursuit',
      location: 'FDR Drive Northbound',
      timestamp: '12m ago',
      severity: AlertSeverity.medium,
      description: 'Black sedan fleeing traffic stop at high velocity.',
    ),
    const CrimeAlertModel(
      id: 'DISP-104',
      title: 'Cat Stuck on 4th Story Fire Escape',
      location: 'Forest Hills, Queens',
      timestamp: '25m ago',
      severity: AlertSeverity.low,
      description: 'Friendly neighborhood request. Kitten cannot climb down.',
    ),
  ];

  @override
  Future<List<CrimeAlert>> getActiveAlerts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List<CrimeAlert>.from(_mockAlerts);
  }

  @override
  Future<List<CrimeAlert>> scanCityRadar() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List<CrimeAlert>.from(_mockAlerts);
  }

  @override
  Future<CrimeAlert> resolveAlert(String alertId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _mockAlerts.indexWhere((a) => a.id == alertId);
    if (index != -1) {
      final updated = _mockAlerts[index].copyWith(isResolved: true);
      _mockAlerts[index] = updated as CrimeAlertModel;
      return updated;
    }
    throw Exception('Alert $alertId not found');
  }
}
