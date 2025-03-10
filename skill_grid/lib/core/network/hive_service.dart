import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_hive_model.dart';
import 'package:skill_grid/features/auth/data/model/client_model/client_hive_model.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_hive_model.dart';
import 'package:skill_grid/features/education/data/model/education_hive_model.dart';
import 'package:skill_grid/features/employment/data/model/employment_hive_model.dart';
import 'package:skill_grid/features/freelancer_service/data/model/freelancer_service_hive_model.dart';
import 'package:skill_grid/features/payment/data/model/payment_hive_model.dart';
import 'package:skill_grid/features/portfolio/data/model/portfolio_hive_model.dart';
import 'package:skill_grid/features/review/data/model/review_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = "${directory.path}skill_grid.db";

    Hive.init(path);

    Hive.registerAdapter(ClientHiveModelAdapter());
    Hive.registerAdapter(FreelancerHiveModelAdapter());
    Hive.registerAdapter(FreelancerServiceHiveModelAdapter());
    Hive.registerAdapter(PortfolioHiveModelAdapter());
    Hive.registerAdapter(ReviewHiveModelAdapter());
    Hive.registerAdapter(EducationHiveModelAdapter());
    Hive.registerAdapter(EmploymentHiveModelAdapter());
    Hive.registerAdapter(AppointmentHiveModelAdapter());
    Hive.registerAdapter(PaymentHiveModelAdapter());
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

  Future<ClientHiveModel?> loginClient(String email, String password) async {
    var box = await Hive.openBox<ClientHiveModel>(HiveTableConstant.clientBox);
    var client = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    return client;
  }

  Future<void> updateClientProfilePicture(
      String clientId, String profilePicturePath) async {
    var box = await Hive.openBox<ClientHiveModel>(HiveTableConstant.clientBox);

    final client = box.get(clientId);

    if (client == null) {
      throw Exception("Client not found");
    }

    final updatedClient = client.copyWith(profilePicture: profilePicturePath);

    // Save the updated client back to Hive
    await box.put(clientId, updatedClient);
  }

  Future<void> updateClient(String clientId,
      {String? newFirstName,
      String? newLastName,
      String? newEmail,
      String? newMobileNo,
      String? newCity,
      String? newPassword}) async {
    var box = await Hive.openBox<ClientHiveModel>(HiveTableConstant.clientBox);

    final client = box.get(clientId);

    if (client == null) {
      throw Exception("Client not found");
    }

    final updatedClient = client.copyWith(
      firstName: newFirstName ?? client.firstName,
      lastName: newLastName ?? client.lastName,
      email: newEmail ?? client.email,
      mobileNo: newMobileNo ?? client.mobileNo,
      city: newCity ?? client.city,
      password: newPassword ?? client.password,
    );

    await box.put(clientId, updatedClient);
  }

  //--------------------Freelancer Queries------------------------------
  Future<String> registerFreelancer(FreelancerHiveModel freelancer) async {
    var box = await Hive.openBox<FreelancerHiveModel>(
        HiveTableConstant.freelancerBox);
    await box.put(freelancer.freelancerId, freelancer);
    return freelancer.freelancerId;
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

  Future<void> updateFreelancer(FreelancerHiveModel freelancer) async {
    var box = await Hive.openBox<FreelancerHiveModel>(
        HiveTableConstant.freelancerBox);

    if (box.containsKey(freelancer.freelancerId)) {
      final existingFreelancer = box.get(freelancer.freelancerId);

      if (existingFreelancer != null) {
        // Create an updated freelancer with only the fields that are being changed
        final updatedFreelancer = existingFreelancer.copyWith(
          firstName: freelancer.firstName,
          lastName: freelancer.lastName,
          dateOfBirth: freelancer.dateOfBirth,
          mobileNo: freelancer.mobileNo,
          address: freelancer.address,
          city: freelancer.city,
          email: freelancer.email,
          password: freelancer.password,
          jobCategory: freelancer.jobCategory,
          profession: freelancer.profession,
          skills: freelancer.skills,
          yearsOfExperience: freelancer.yearsOfExperience,
          bio: freelancer.bio,
          available: freelancer.available,
          profilePicture: freelancer.profilePicture,
          backgroundPicture: freelancer.backgroundPicture,
        );

        await box.put(freelancer.freelancerId, updatedFreelancer);
      } else {
        throw Exception(
            "Freelancer with ID ${freelancer.freelancerId} does not exist.");
      }
    } else {
      throw Exception(
          "Freelancer with ID ${freelancer.freelancerId} does not exist.");
    }
  }

  Future<List<FreelancerHiveModel>> searchFreelancers(
      String searchQuery) async {
    var box = await Hive.openBox<FreelancerHiveModel>(
      HiveTableConstant.freelancerBox,
    );

    return box.values
        .where((freelancer) =>
            freelancer.firstName
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            freelancer.lastName
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            (freelancer.profession?.toLowerCase() ?? '')
                .contains(searchQuery.toLowerCase()) ||
            (freelancer.jobCategory?.toLowerCase() ?? '')
                .contains(searchQuery.toLowerCase()))
        .toList();
  }

  //------------------Freelancer Service Queries---------------------
  Future<List<FreelancerServiceHiveModel>> getFreelancerServiceByFreelancerId(
      String freelancerId) async {
    var box = await Hive.openBox<FreelancerServiceHiveModel>(
      HiveTableConstant.freelancerServiceBox,
    );

    return box.values
        .where((freelancerService) =>
            freelancerService.freelancer.freelancerId == freelancerId)
        .toList();
  }

  //--------------------Portfolio Queries-----------------------
  Future<PortfolioHiveModel> getPortfolioByFreelancerServiceId(
      String freelancerServiceId) async {
    var box =
        await Hive.openBox<PortfolioHiveModel>(HiveTableConstant.portfolioBox);

    return box.values.firstWhere((portfolio) =>
        portfolio.freelancerService.freelancerServiceId == freelancerServiceId);
  }

  Future<List<PortfolioHiveModel>> getPortfolioByFreelancerId(
      String freelancerId) async {
    var box =
        await Hive.openBox<PortfolioHiveModel>(HiveTableConstant.portfolioBox);

    return box.values
        .where((portfolio) =>
            portfolio.freelancerService.freelancer.freelancerId == freelancerId)
        .toList();
  }

  //----------------------Review Queries------------------------
  Future<List<ReviewHiveModel>> getReviewByFreelancerId(
      String freelancerId) async {
    var box = await Hive.openBox<ReviewHiveModel>(HiveTableConstant.reviewBox);

    return box.values
        .where((review) => review.freelancer.freelancerId == freelancerId)
        .toList();
  }

  Future<List<ReviewHiveModel>> getReviewByRating(int rating) async {
    var box = await Hive.openBox<ReviewHiveModel>(HiveTableConstant.reviewBox);

    return box.values.where((review) => review.rating == rating).toList();
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.clientBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.freelancerBox);
  }

  Future<void> close() async {
    await Hive.close();
  }

  //--------------------Education Queries--------------------
  Future<List<EducationHiveModel>> getEducationByFreelancerId(
      String freelancerId) async {
    var box =
        await Hive.openBox<EducationHiveModel>(HiveTableConstant.educationBox);

    return box.values
        .where((education) => education.freelancer.freelancerId == freelancerId)
        .toList();
  }

  //--------------------Employment Queries--------------------
  Future<List<EmploymentHiveModel>> getEmploymentByFreelancerId(
      String freelancerId) async {
    var box = await Hive.openBox<EmploymentHiveModel>(
        HiveTableConstant.employmentBox);

    return box.values
        .where(
            (employment) => employment.freelancer.freelancerId == freelancerId)
        .toList();
  }

  //---------------------Appointment Queries---------------------
  Future<List<AppointmentHiveModel>> getAppointmentByFreelancerId(
      String freelancerId) async {
    var box = await Hive.openBox<AppointmentHiveModel>(
        HiveTableConstant.appointmentBox);

    return box.values
        .where(
            (appointment) => appointment.freelancerService.freelancer.freelancerId == freelancerId)
        .toList();
  }

  Future<List<AppointmentHiveModel>> getAppointmentByClientId(
      String clientId) async {
    var box = await Hive.openBox<AppointmentHiveModel>(
        HiveTableConstant.appointmentBox);

    return box.values
        .where(
            (appointment) => appointment.client.clientId == clientId)
        .toList();
  }

  Future<String> saveAppointment(AppointmentHiveModel appointment) async {
    var box = await Hive.openBox<AppointmentHiveModel>(HiveTableConstant.appointmentBox);
    await box.put(appointment.appointmentId, appointment);
    return appointment.appointmentId!;
  }

  Future<void> deleteAppointment(String appointmentId) async {
    var box = await Hive.openBox<AppointmentHiveModel>(HiveTableConstant.appointmentBox);
    await box.delete(appointmentId);
  }

  Future<AppointmentHiveModel?> getAppointmentById(String appointmentId) async {
    var box = await Hive.openBox<AppointmentHiveModel>(HiveTableConstant.appointmentBox);
    return box.get(appointmentId);
  }

  Future<void> updateAppointment(String appointmentId, {String? newAppointmentPurpose}) async {
    var box = await Hive.openBox<AppointmentHiveModel>(HiveTableConstant.appointmentBox);

    final appointment = box.get(appointmentId);

    if (appointment == null) {
      throw Exception("Appointment not found");
    }

    final updatedAppointment = appointment.copyWith(
      
    );

    await box.put(appointmentId, updatedAppointment);
  }

  //--------------------------Payment Queries-----------------------------
  Future<PaymentHiveModel> getPaymentByAppointmentId(String appointmentId) async {
    var box = await Hive.openBox<PaymentHiveModel>(HiveTableConstant.paymentBox);

    return box.values.firstWhere((payment) =>
        payment.appointment.appointmentId == appointmentId);
  }
}

