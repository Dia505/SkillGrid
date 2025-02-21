import 'package:dio/dio.dart';
import 'package:skill_grid/app/constants/api_endpoints.dart';
import 'package:skill_grid/features/billing_address/data/data_source/billing_address_data_source.dart';
import 'package:skill_grid/features/billing_address/data/dto/get_billing_address_by_id_dto.dart';
import 'package:skill_grid/features/billing_address/data/model/billing_address_api_model.dart';
import 'package:skill_grid/features/billing_address/domain/entity/billing_address_entity.dart';

class BillingAddressRemoteDataSource implements IBillingAddressDataSource {
  final Dio _dio;
  BillingAddressRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<String> saveBillingAddress(
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
        final billingAddressId = response.data['_id'];
        return billingAddressId;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<BillingAddressEntity> getBillingAddressById(String billingAddressId, String? token) async {
    try {
      final String url = "${ApiEndpoints.getBillingAddressById}/$billingAddressId";

      var response = await _dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        GetBillingAddressByIdDto billingAddressDto =
            GetBillingAddressByIdDto.fromJson(response.data);

        BillingAddressEntity billingAddressEntity =
            BillingAddressApiModel.findBillingAddressByIdDtoToEntity(billingAddressDto);

        return billingAddressEntity;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception('Error occurred while fetching billing address: $e');
    }
  }
}
