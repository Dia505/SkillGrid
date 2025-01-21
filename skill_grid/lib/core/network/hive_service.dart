import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/auth/data/model/client_hive_model.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = "${directory.path}skill_grid.db";

    Hive.init(path);

    Hive.registerAdapter(ClientHiveModelAdapter());
    Hive.registerAdapter(FreelancerHiveModelAdapter());
  }

  //-------------------------Client Queries--------------------------------------
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

  Future<ClientHiveModel?> loginClient(
      String email, String password) async {
        var box = await Hive.openBox<ClientHiveModel>(
            HiveTableConstant.clientBox);
        var client = box.values.firstWhere(
            (element) => element.email == email && element.password == password);
        box.close();
        return client;
  }

  //--------------------Freelancer Queries------------------------------
  Future<void> registerFreelancer(FreelancerHiveModel freelancer) async {
    var box = await Hive.openBox<FreelancerHiveModel>(
        HiveTableConstant.freelancerBox);
    await box.put(freelancer.freelancerId, freelancer);
  }

  Future<void> deleteFreelancer(String freelancerId) async {
    var box = await Hive.openBox<FreelancerHiveModel>(
        HiveTableConstant.freelancerBox);
    await box.delete(freelancerId);
  }

  Future<FreelancerHiveModel?> getFreelancerById(String freelancerId) async {
    var box = await Hive.openBox<FreelancerHiveModel>(
        HiveTableConstant.freelancerBox);
    return box.get(freelancerId);
  }

  Future<List<FreelancerHiveModel>> getAllFreelancers() async {
    var box = await Hive.openBox<FreelancerHiveModel>(
        HiveTableConstant.freelancerBox);
    return box.values.toList();
  }

  Future<FreelancerHiveModel?> loginFreelancer(
      String email, String password) async {
        var box = await Hive.openBox<FreelancerHiveModel>(
            HiveTableConstant.freelancerBox);
        var freelancer = box.values.firstWhere(
            (element) => element.email == email && element.password == password);
        box.close();
        return freelancer;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.clientBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.freelancerBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
