import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/billing_address/data/data_source/billing_address_data_source.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';

class BillingAddressRemoteDataSource implements IBillingAddressDataSource {
  final Dio _dio;
  BillingAddressRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<void> saveBillingAddress(
      BillingAddressEntity billingAddressEntity, String? token) async {
    try {
      Response response = await _dio.post(ApiEndpoints.saveBillingAddress,
          data: {
            "address": billingAddressEntity.address,
            "city": billingAddressEntity.city
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
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
