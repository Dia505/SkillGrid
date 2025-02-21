class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  static const String baseUrl = "http://10.0.2.2:3000/api/";

  //Client routes
  static const String registerClient = "client";
  static const String findClientById = "client";
  static const String imageUrl = "http://10.0.2.2:3000/client_images/";
  static const String updateClientProfilePicture = "client";
  static const String updateClient = "client";
  static const String deleteClient = "client";

  //Freelancer routes
  static const String registerFreelancer = "freelancer";
  static const String findFreelancerById = "freelancer";
  static const String searchFreelancers = "freelancer/search";

  //Login routes
  static const String login = "auth/login";

  //Freelancer Service routes
  static const String getFreelancerServiceByFreelancerId = "freelancer-service/freelancer";

  //Portfolio routes
  static const String getPortfolioByFreelancerServiceId = "portfolio/freelancer-service";
  static const String getPortfolioByFreelancerId = "portfolio/freelancer";

  //Review routes
  static const String getReviewByFreelancerId = "review/freelancer";
  static const String getReviewByRating = "review/rating";

  //Education routes
  static const String getEducationByFreelancerId = "education/freelancer";

  //Employment routes
  static const String getEmploymentByFreelancerId = "employment/freelancer";

  //Appointment routes
  static const String saveAppointment = "appointment";
  static const String getAppointmentById = "appointment";
  static const String deleteAppointment = "appointment";
  static const String updateAppointment = "appointment";
  static const String getAppointmentByClientId = "appointment/client";
  static const String getAppointmentByFreelancerId = "appointment/freelancer";

  //Billing address routes
  static const String saveBillingAddress = "billing-address";
  static const String getBillingAddressById = "billing-address";

  //Payment address routes
  static const String savePayment = "payment";
  static const String getPaymentByAppointmentId = "payment/appointment";
}
