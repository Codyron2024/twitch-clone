import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:twitch_clone/src/data/model/home/live_model.dart';
import 'package:twitch_clone/src/data/repository/home/home_repository.dart';
import 'package:twitch_clone/src/injection.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homerepo}) : super(const HomeState.initial());
  final Homerepository homerepo;

  getallpost() async {
    try {
      emit(const HomeState.loading());
      final streamlive = homerepo.getlive();

      streamlive.listen((event) {
        emit(HomeState.loaded(event));
      });
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }

}
