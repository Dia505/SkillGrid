import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/payment/data/data_source/payment_data_source.dart';
import 'package:skill_grid/features/payment/data/dto/get_payment_by_appointment_id_dto.dart';
import 'package:skill_grid/features/payment/data/model/payment_api_model.dart';
import 'package:skill_grid/features/payment/domain/entity/payment_entity.dart';

class PaymentRemoteDataSource implements IPaymentDataSource {
  final Dio _dio;
  PaymentRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<PaymentEntity> getPaymentByAppointmentId(String appointmentId, String? token) async {
    try {
      final String url = "${ApiEndpoints.getPaymentByAppointmentId}/$appointmentId";

      var response = await _dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        GetPaymentByAppointmentIdDto paymentDto =
            GetPaymentByAppointmentIdDto.fromJson(response.data);

        PaymentEntity paymentEntity = PaymentApiModel.getPaymentByAppointmentIdDtoToEntity(paymentDto);

        return paymentEntity;
      } else {
        throw Exception(response.statusMessage);
      }
    }
    on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception('Error occurred while fetching payment: $e');
    }
  }

  @override
  Future<void> savePayment(PaymentEntity paymentEntity) async {
    try {
      Response response = await _dio.post(ApiEndpoints.savePayment,
          data: {
            "amount": paymentEntity.amount,
            "payment_method": paymentEntity.paymentMethod,
            "payment_status": paymentEntity.paymentStatus,
            "payment_timestamp": paymentEntity.paymentTimestamp,
            "appointment_id": paymentEntity.appointment,
            "billing_address_id": paymentEntity.billingAddress
          });
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}