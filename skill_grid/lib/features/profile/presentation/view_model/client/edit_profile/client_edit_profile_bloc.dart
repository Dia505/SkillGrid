import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/core/utils/token_helper.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/get_client_by_id_use_case.dart';
import 'package:skill_grid/features/auth/domain/use_case/client_use_case/update_client_profile_picture_usecase.dart';

part 'client_edit_profile_event.dart';
part 'client_edit_profile_state.dart';

class ClientEditProfileBloc
    extends Bloc<ClientEditProfileEvent, ClientEditProfileState> {
  final GetClientByIdUseCase _getClientByIdUseCase;
  final TokenHelper _tokenHelper;
  final UpdateClientProfilePictureUsecase _updateClientProfilePictureUsecase;

  ClientEditProfileBloc(
      {required GetClientByIdUseCase getClientByIdUseCase,
      required TokenHelper tokenHelper,
      required UpdateClientProfilePictureUsecase
          updateClientProfilePictureUsecase})
      : _getClientByIdUseCase = getClientByIdUseCase,
        _tokenHelper = tokenHelper,
        _updateClientProfilePictureUsecase = updateClientProfilePictureUsecase,
        super(ClientEditProfileInitial()) {
    on<UpdateProfilePicture>(_onUpdateProfilePicture);
  }

  Future<void> loadClient() async {
    emit(ClientEditProfileLoading());

    try {
      final userId = await _tokenHelper.getUserIdFromToken();
      if (userId == null) {
        emit(const ClientEditProfileError("Client id not found"));
        return;
      }

      final Either<Failure, ClientEntity> result =
          await _getClientByIdUseCase(GetClientByIdParams(clientId: userId));

      result.fold(
        (failure) {
          emit(ClientEditProfileError(failure.message));
          print("Error in cubit: ${failure.message}");
        },
        (clientEntity) {
          emit(ClientEditProfileLoaded(clientEntity));
          print("Client loaded: ${clientEntity.toString()}");
        },
      );
    } catch (e) {
      emit(ClientEditProfileError("Error occurred: $e"));
      print("Exception occurred: $e");
    }
  }

  void _onUpdateProfilePicture(
      UpdateProfilePicture event, Emitter<ClientEditProfileState> emit) async {
    emit(ClientEditProfileLoading());

    try {
      final result = await _updateClientProfilePictureUsecase(
        UpdateClientProfilePictureParams(
            clientId: event.clientId,
            file: event.file,
            token: event.token ?? ""),
      );

      result.fold(
        (failure) {
          emit(ClientEditProfileError(failure.message));
        },
        (updatedImagePath) {
          // Access the clientEntity by casting the state to ClientEditProfileLoaded
          if (state is ClientEditProfileLoaded) {
            final currentClientEntity =
                (state as ClientEditProfileLoaded).clientEntity;
            final updatedClientEntity = currentClientEntity.copyWith(
              profilePicture: updatedImagePath,
            );

            // Emit the loaded state with the updated client data
            emit(ClientEditProfileLoaded(updatedClientEntity));
          } else {
            // Handle the case where the state is not ClientEditProfileLoaded
            emit(const ClientEditProfileError("Client data not loaded"));
          }
        },
      );
    } catch (e) {
      emit(ClientEditProfileError("Error occurred: $e"));
      print("Exception occurred: $e");
    }
  }
}
