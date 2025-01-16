import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/auth/data/model/client_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = "${directory.path}skill_grid.db";

    Hive.init(path);

    Hive.registerAdapter(ClientHiveModelAdapter());
  }

  //Client Queries
  Future<void> registerClient(ClientHiveModel client) async {
    var box = await Hive.openBox<ClientHiveModel>(HiveTableConstant.clientBox);
    await box.put(client.clientId, client);
  }

  Future<void> deleteClient(String clientId) async {
    var box = await Hive.openBox<ClientHiveModel>(HiveTableConstant.clientBox);
    await box.delete(clientId);
  }

  Future<ClientHiveModel?> getClientById(String clientId) async {
    var box = await Hive.openBox<ClientHiveModel>(HiveTableConstant.clientBox);
    return box.get(clientId); 
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.clientBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
