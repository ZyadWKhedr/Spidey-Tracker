import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashLoading extends SplashState {
  final String statusMessage;
  final double progress;

  const SplashLoading({
    required this.statusMessage,
    required this.progress,
  });

  @override
  List<Object?> get props => [statusMessage, progress];
}

final class SplashCompleted extends SplashState {
  const SplashCompleted();
}
