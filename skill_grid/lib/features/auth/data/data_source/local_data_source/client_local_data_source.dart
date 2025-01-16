import 'package:skill_grid/core/network/hive_service.dart';
import 'package:skill_grid/features/auth/data/data_source/client_data_source.dart';
import 'package:skill_grid/features/auth/data/model/client_hive_model.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';

class ClientLocalDataSource implements IClientDataSource {
  final HiveService _hiveService;
  ClientLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> registerClient(ClientEntity clientEntity) async {
    try {
      final clientHiveModel = ClientHiveModel.fromEntity(clientEntity);
      await _hiveService.registerClient(clientHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteClient(String clientId) async {
    try {
      await _hiveService.deleteClient(clientId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ClientEntity> getClientById(String clientId) async {
    try {
      final clientHiveModel = await _hiveService.getClientById(clientId);
      return clientHiveModel!.toEntity();
    } catch (e) {
      throw Exception(e);
    }
  }
}
