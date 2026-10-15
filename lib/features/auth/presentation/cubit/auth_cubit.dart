import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/user_model.dart';
import '../../data/auth_repository.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class OtpSentState extends AuthState {
  final String mobileNumber;
  OtpSentState(this.mobileNumber);
  @override
  List<Object?> get props => [mobileNumber];
}
class AuthenticatedState extends AuthState {
  final UserModel user;
  AuthenticatedState(this.user);
  @override
  List<Object?> get props => [user];
}
class UnauthenticatedState extends AuthState {}
class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  Future<void> sendOtp(String mobileNumber) async {
    emit(AuthLoading());
    try {
      final success = await authRepository.sendOtp(mobileNumber);
      if (success) {
        emit(OtpSentState(mobileNumber));
      } else {
        emit(AuthErrorState('Failed to send OTP'));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> verifyOtp(String mobileNumber, String otp) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.verifyOtp(mobileNumber, otp);
      emit(AuthenticatedState(user));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await authRepository.logout();
    emit(UnauthenticatedState());
  }

  Future<void> checkAuthStatus() async {
    final user = await authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthenticatedState(user));
    } else {
      emit(UnauthenticatedState());
    }
  }
}
