import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/lawyer_model.dart';
import '../../data/lawyer_repository.dart';

abstract class LawyerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LawyerInitial extends LawyerState {}
class LawyerLoading extends LawyerState {}
class LawyersLoaded extends LawyerState {
  final List<LawyerModel> lawyers;
  final String selectedCategory;

  LawyersLoaded({
    required this.lawyers,
    this.selectedCategory = 'All',
  });

  @override
  List<Object?> get props => [lawyers, selectedCategory];
}
class LawyerDetailsLoaded extends LawyerState {
  final LawyerModel lawyer;
  final List<AvailabilitySlotModel> slots;

  LawyerDetailsLoaded({
    required this.lawyer,
    required this.slots,
  });

  @override
  List<Object?> get props => [lawyer, slots];
}
class LawyerError extends LawyerState {
  final String message;
  LawyerError(this.message);
  @override
  List<Object?> get props => [message];
}

class LawyerCubit extends Cubit<LawyerState> {
  final LawyerRepository lawyerRepository;

  LawyerCubit({required this.lawyerRepository}) : super(LawyerInitial());

  Future<void> loadLawyers({String? category, String? query}) async {
    emit(LawyerLoading());
    try {
      final list = await lawyerRepository.getLawyers(
        category: category,
        searchQuery: query,
      );
      emit(LawyersLoaded(lawyers: list, selectedCategory: category ?? 'All'));
    } catch (e) {
      emit(LawyerError(e.toString()));
    }
  }

  Future<void> loadLawyerDetails(String id) async {
    emit(LawyerLoading());
    try {
      final lawyer = await lawyerRepository.getLawyerDetails(id);
      final slots = await lawyerRepository.getLawyerAvailability(id, 'May 2024');
      emit(LawyerDetailsLoaded(lawyer: lawyer, slots: slots));
    } catch (e) {
      emit(LawyerError(e.toString()));
    }
  }

  Future<void> loadSavedLawyers() async {
    emit(LawyerLoading());
    try {
      final list = await lawyerRepository.getSavedLawyers();
      emit(LawyersLoaded(lawyers: list));
    } catch (e) {
      emit(LawyerError(e.toString()));
    }
  }
}
