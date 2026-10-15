import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/category_model.dart';
import '../../data/home_repository.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeLoadedState extends HomeState {
  final List<CategoryModel> categories;
  final String location;
  final String userName;

  HomeLoadedState({
    required this.categories,
    required this.location,
    required this.userName,
  });

  @override
  List<Object?> get props => [categories, location, userName];
}
class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit({required this.homeRepository}) : super(HomeInitialState());

  Future<void> loadHomeData() async {
    emit(HomeLoadingState());
    try {
      final categories = await homeRepository.getCategories();
      emit(
        HomeLoadedState(
          categories: categories,
          location: 'Chennai, TN',
          userName: 'Karthik',
        ),
      );
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
}
