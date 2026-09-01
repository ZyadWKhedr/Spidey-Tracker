import '../entities/crime_alert.dart';

abstract interface class TrackerRepository {
  Future<List<CrimeAlert>> getActiveAlerts();
  Future<List<CrimeAlert>> scanCityRadar();
  Future<CrimeAlert> resolveAlert(String alertId);
}
