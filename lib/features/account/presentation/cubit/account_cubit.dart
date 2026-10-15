import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/models/referral_model.dart';
import '../../data/account_repository.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {}
class AccountLoading extends AccountState {}
class AccountLoaded extends AccountState {
  final UserModel user;
  final ReferralModel referralInfo;

  AccountLoaded({
    required this.user,
    required this.referralInfo,
  });

  @override
  List<Object?> get props => [user, referralInfo];
}
class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
  @override
  List<Object?> get props => [message];
}

class AccountCubit extends Cubit<AccountState> {
  final AccountRepository accountRepository;

  AccountCubit({required this.accountRepository}) : super(AccountInitial());

  Future<void> loadAccountData() async {
    emit(AccountLoading());
    try {
      final user = await accountRepository.getProfile();
      final referral = await accountRepository.getReferralInfo();
      emit(AccountLoaded(user: user, referralInfo: referral));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }
}
