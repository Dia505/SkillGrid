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
      required UpdateClientProfilePictureUsecase updateClientProfilePictureUsecase
      })
      : _getClientByIdUseCase = getClientByIdUseCase,
        _tokenHelper = tokenHelper,
        _updateClientProfilePictureUsecase = updateClientProfilePictureUsecase,
        super(ClientEditProfileInitial());

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

  Future<void> updateProfilePicture(String clientId, File file, String? token) async {
    emit(ClientEditProfileLoading());  // Show loading indicator

    try {
      final result = await _updateClientProfilePictureUsecase(
        UpdateClientProfilePictureParams(clientId: clientId, file: file, token: token ?? ""),
      );

      result.fold(
        (failure) {
          emit(ClientEditProfileError(failure.message)); // Emit error state
        },
        (updatedImagePath) {
          emit(ClientEditProfileSuccess(profilePicturePath: updatedImagePath)); // Emit success state
        },
      );
    } catch (e) {
      emit(ClientEditProfileError("Error occurred: $e"));
      print("Exception occurred: $e");
    }
  }
}
