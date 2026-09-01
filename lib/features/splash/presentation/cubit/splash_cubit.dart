import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Timer? _timer;

  void startInitialization() {
    emit(const SplashLoading(
      statusMessage: AppStrings.splashCalibrating,
      progress: 0.15,
    ));

    _timer = Timer(const Duration(milliseconds: 700), () {
      if (isClosed) return;
      emit(const SplashLoading(
        statusMessage: AppStrings.splashConnecting,
        progress: 0.50,
      ));

      _timer = Timer(const Duration(milliseconds: 800), () {
        if (isClosed) return;
        emit(const SplashLoading(
          statusMessage: AppStrings.splashScanning,
          progress: 0.85,
        ));

        _timer = Timer(const Duration(milliseconds: 700), () {
          if (isClosed) return;
          emit(const SplashLoading(
            statusMessage: AppStrings.splashReady,
            progress: 1.0,
          ));

          _timer = Timer(const Duration(milliseconds: 500), () {
            if (isClosed) return;
            emit(const SplashCompleted());
          });
        });
      });
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
