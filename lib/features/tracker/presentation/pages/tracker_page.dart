import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../data/repositories/tracker_repository_impl.dart';
import '../cubit/tracker_cubit.dart';
import '../widgets/crime_alert_list.dart';
import '../widgets/patrol_status_card.dart';
import '../widgets/radar_scanner_widget.dart';
import '../widgets/tracker_app_bar.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrackerCubit(
        repository: TrackerRepositoryImpl(),
      )..loadInitialData(),
      child: const TrackerView(),
    );
  }
}

class TrackerView extends StatelessWidget {
  const TrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TrackerAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.p16,
            vertical: AppDimensions.p12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              PatrolStatusCard(),
              SizedBox(height: AppDimensions.p16),
              RadarScannerWidget(),
              SizedBox(height: AppDimensions.p16),
              CrimeAlertList(),
              SizedBox(height: AppDimensions.p24),
            ],
          ),
        ),
      ),
    );
  }
}
