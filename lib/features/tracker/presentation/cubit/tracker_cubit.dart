import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/tracker_repository.dart';
import 'tracker_state.dart';

class TrackerCubit extends Cubit<TrackerState> {
  final TrackerRepository repository;

  TrackerCubit({required this.repository})
      : super(const TrackerState());

  Future<void> loadInitialData() async {
    try {
      final alerts = await repository.getActiveAlerts();
      emit(state.copyWith(alerts: alerts));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to load dispatch telemetry: $e'));
    }
  }

  void togglePatrol() {
    final nextStatus = state.isPatrolActive
        ? PatrolStatus.standby
        : PatrolStatus.active;
    emit(state.copyWith(patrolStatus: nextStatus));
  }

  Future<void> scanRadar() async {
    emit(state.copyWith(isScanning: true));
    try {
      final alerts = await repository.scanCityRadar();
      emit(state.copyWith(
        alerts: alerts,
        isScanning: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isScanning: false,
        errorMessage: 'Radar scan failed: $e',
      ));
    }
  }

  void shootWeb() {
    if (state.webFluidPercentage > 0.05) {
      final nextFluid = (state.webFluidPercentage - 0.08).clamp(0.0, 1.0);
      emit(state.copyWith(webFluidPercentage: nextFluid));
    }
  }

  void reloadWebCartridge() {
    emit(state.copyWith(webFluidPercentage: 1.0));
  }

  Future<void> resolveAlert(String alertId) async {
    try {
      final updated = await repository.resolveAlert(alertId);
      final updatedList = state.alerts.map((a) {
        return a.id == alertId ? updated : a;
      }).toList();
      emit(state.copyWith(alerts: updatedList));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to resolve alert: $e'));
    }
  }
}
