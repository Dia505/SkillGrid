import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';

abstract interface class IClientDataSource {
  Future<void> registerClient(ClientEntity clientEntity);
  Future<void> deleteClient(String clientId);
  Future<ClientEntity> getClientById(String clientId);
}