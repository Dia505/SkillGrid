import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';

part 'client_home_state.dart';

class ClientHomeCubit extends Cubit<ClientHomeState> {
  final GetClientByIdUseCase _getClientByIdUseCase;
  final TokenHelper _tokenHelper;

  ClientHomeCubit({
    required GetClientByIdUseCase getClientByIdUseCase,
    required TokenHelper tokenHelper
  }) :  _getClientByIdUseCase = getClientByIdUseCase,
        _tokenHelper = tokenHelper,
        super(ClientHomeInitial());

  Future<void> loadClient() async {
    emit(ClientHomeLoading());

    try {
      final userId = await _tokenHelper.getUserIdFromToken();
      if(userId == null) {
        emit(ClientHomeError("Client id not found"));
        return;
      }

      final Either<Failure, ClientEntity> result = await _getClientByIdUseCase(GetClientByIdParams(clientId: userId));

      result.fold(
        (failure) {
          emit(ClientHomeError(failure.message));
        },
        (clientEntity) {
          emit(ClientHomeLoaded(clientEntity));
        },
      );
    }
    catch(e) {
      emit(ClientHomeError("Error occurred: $e"));
    }
  }
}