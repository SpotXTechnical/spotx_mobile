// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart' show debugPrint;
import 'package:owner/data/remote/add_unit/model/feature_entity.dart';
import 'package:owner/data/remote/add_unit/model/image_entity.dart';
import 'package:owner/data/remote/add_unit/model/post_image_response_entity.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/add_unit/model/review_entity.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/auth/models/force_update_entity.dart';
import 'package:owner/data/remote/auth/models/forget_password_request_entity_entity.dart';
import 'package:owner/data/remote/auth/models/guest.dart';
import 'package:owner/data/remote/auth/models/login_errors_entity.dart';
import 'package:owner/data/remote/auth/models/login_request_entity.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/data/remote/auth/models/register_error_entity.dart';
import 'package:owner/data/remote/auth/models/register_request_entity.dart';
import 'package:owner/data/remote/auth/models/register_response_entity.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/data/remote/reservation/model/reservation_error.dart';
import 'package:owner/data/remote/statistics/model/income_entity.dart';
import 'package:owner/data/remote/statistics/model/payment_entity.dart';
import 'package:owner/data/remote/statistics/model/total_icomes_entity.dart';
import 'package:owner/utils/network/list_helper/links.dart';
import 'package:owner/utils/network/list_helper/meta.dart';

JsonConvert jsonConvert = JsonConvert();
typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);
typedef EnumConvertFunction<T> = T Function(String value);

class JsonConvert {
	static final Map<String, JsonConvertFunction> convertFuncMap = {
		(Feature).toString(): Feature.fromJson,
		(ImageEntity).toString(): ImageEntity.fromJson,
		(PostImageResponseEntity).toString(): PostImageResponseEntity.fromJson,
		(PriceRange).toString(): PriceRange.fromJson,
		(ReviewEntity).toString(): ReviewEntity.fromJson,
		(Unit).toString(): Unit.fromJson,
		(Room).toString(): Room.fromJson,
		(ForceUpdateEntity).toString(): ForceUpdateEntity.fromJson,
		(ForgetPasswordRequestEntityEntity).toString(): ForgetPasswordRequestEntityEntity.fromJson,
		(Guest).toString(): Guest.fromJson,
		(LoginErrorsEntity).toString(): LoginErrorsEntity.fromJson,
		(LoginRequestEntity).toString(): LoginRequestEntity.fromJson,
		(LoginResponseEntity).toString(): LoginResponseEntity.fromJson,
		(Token).toString(): Token.fromJson,
		(User).toString(): User.fromJson,
		(RegisterErrorsEntity).toString(): RegisterErrorsEntity.fromJson,
		(RegisterRequestEntity).toString(): RegisterRequestEntity.fromJson,
		(RegisterResponseEntity).toString(): RegisterResponseEntity.fromJson,
		(RegisterResponseEntityDataToken).toString(): RegisterResponseEntityDataToken.fromJson,
		(GetRegionsResponseEntity).toString(): GetRegionsResponseEntity.fromJson,
		(Region).toString(): Region.fromJson,
		(Reservation).toString(): Reservation.fromJson,
		(ReservationError).toString(): ReservationError.fromJson,
		(IncomeEntity).toString(): IncomeEntity.fromJson,
		(PaymentEntity).toString(): PaymentEntity.fromJson,
		(TotalIncomesEntity).toString(): TotalIncomesEntity.fromJson,
		(Links).toString(): Links.fromJson,
		(Meta).toString(): Meta.fromJson,
	};

  T? convert<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    if (value is T) {
      return value;
    }
    try {
      return _asT<T>(value, enumConvert: enumConvert);
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return null;
    }
  }

  List<T?>? convertList<T>(List<dynamic>? value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => _asT<T>(e,enumConvert: enumConvert)).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

List<T>? convertListNotNull<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => _asT<T>(e,enumConvert: enumConvert)!).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  T? _asT<T extends Object?>(dynamic value,
      {EnumConvertFunction? enumConvert}) {
    final String type = T.toString();
    final String valueS = value.toString();
    if (enumConvert != null) {
      return enumConvert(valueS) as T;
    } else if (type == "String") {
      return valueS as T;
    } else if (type == "int") {
      final int? intValue = int.tryParse(valueS);
      if (intValue == null) {
        return double.tryParse(valueS)?.toInt() as T?;
      } else {
        return intValue as T;
      }
    } else if (type == "double") {
      return double.parse(valueS) as T;
    } else if (type == "DateTime") {
      return DateTime.parse(valueS) as T;
    } else if (type == "bool") {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return (valueS == 'true') as T;
    } else if (type == "Map" || type.startsWith("Map<")) {
      return value as T;
    } else {
      if (convertFuncMap.containsKey(type)) {
        if (value == null) {
          return null;
        }
        return convertFuncMap[type]!(Map<String, dynamic>.from(value)) as T;
      } else {
        throw UnimplementedError('$type unimplemented');
      }
    }
  }

	//list is returned by type
	static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
		if(<Feature>[] is M){
			return data.map<Feature>((Map<String, dynamic> e) => Feature.fromJson(e)).toList() as M;
		}
		if(<ImageEntity>[] is M){
			return data.map<ImageEntity>((Map<String, dynamic> e) => ImageEntity.fromJson(e)).toList() as M;
		}
		if(<PostImageResponseEntity>[] is M){
			return data.map<PostImageResponseEntity>((Map<String, dynamic> e) => PostImageResponseEntity.fromJson(e)).toList() as M;
		}
		if(<PriceRange>[] is M){
			return data.map<PriceRange>((Map<String, dynamic> e) => PriceRange.fromJson(e)).toList() as M;
		}
		if(<ReviewEntity>[] is M){
			return data.map<ReviewEntity>((Map<String, dynamic> e) => ReviewEntity.fromJson(e)).toList() as M;
		}
		if(<Unit>[] is M){
			return data.map<Unit>((Map<String, dynamic> e) => Unit.fromJson(e)).toList() as M;
		}
		if(<Room>[] is M){
			return data.map<Room>((Map<String, dynamic> e) => Room.fromJson(e)).toList() as M;
		}
		if(<ForceUpdateEntity>[] is M){
			return data.map<ForceUpdateEntity>((Map<String, dynamic> e) => ForceUpdateEntity.fromJson(e)).toList() as M;
		}
		if(<ForgetPasswordRequestEntityEntity>[] is M){
			return data.map<ForgetPasswordRequestEntityEntity>((Map<String, dynamic> e) => ForgetPasswordRequestEntityEntity.fromJson(e)).toList() as M;
		}
		if(<Guest>[] is M){
			return data.map<Guest>((Map<String, dynamic> e) => Guest.fromJson(e)).toList() as M;
		}
		if(<LoginErrorsEntity>[] is M){
			return data.map<LoginErrorsEntity>((Map<String, dynamic> e) => LoginErrorsEntity.fromJson(e)).toList() as M;
		}
		if(<LoginRequestEntity>[] is M){
			return data.map<LoginRequestEntity>((Map<String, dynamic> e) => LoginRequestEntity.fromJson(e)).toList() as M;
		}
		if(<LoginResponseEntity>[] is M){
			return data.map<LoginResponseEntity>((Map<String, dynamic> e) => LoginResponseEntity.fromJson(e)).toList() as M;
		}
		if(<Token>[] is M){
			return data.map<Token>((Map<String, dynamic> e) => Token.fromJson(e)).toList() as M;
		}
		if(<User>[] is M){
			return data.map<User>((Map<String, dynamic> e) => User.fromJson(e)).toList() as M;
		}
		if(<RegisterErrorsEntity>[] is M){
			return data.map<RegisterErrorsEntity>((Map<String, dynamic> e) => RegisterErrorsEntity.fromJson(e)).toList() as M;
		}
		if(<RegisterRequestEntity>[] is M){
			return data.map<RegisterRequestEntity>((Map<String, dynamic> e) => RegisterRequestEntity.fromJson(e)).toList() as M;
		}
		if(<RegisterResponseEntity>[] is M){
			return data.map<RegisterResponseEntity>((Map<String, dynamic> e) => RegisterResponseEntity.fromJson(e)).toList() as M;
		}
		if(<RegisterResponseEntityDataToken>[] is M){
			return data.map<RegisterResponseEntityDataToken>((Map<String, dynamic> e) => RegisterResponseEntityDataToken.fromJson(e)).toList() as M;
		}
		if(<GetRegionsResponseEntity>[] is M){
			return data.map<GetRegionsResponseEntity>((Map<String, dynamic> e) => GetRegionsResponseEntity.fromJson(e)).toList() as M;
		}
		if(<Region>[] is M){
			return data.map<Region>((Map<String, dynamic> e) => Region.fromJson(e)).toList() as M;
		}
		if(<Reservation>[] is M){
			return data.map<Reservation>((Map<String, dynamic> e) => Reservation.fromJson(e)).toList() as M;
		}
		if(<ReservationError>[] is M){
			return data.map<ReservationError>((Map<String, dynamic> e) => ReservationError.fromJson(e)).toList() as M;
		}
		if(<IncomeEntity>[] is M){
			return data.map<IncomeEntity>((Map<String, dynamic> e) => IncomeEntity.fromJson(e)).toList() as M;
		}
		if(<PaymentEntity>[] is M){
			return data.map<PaymentEntity>((Map<String, dynamic> e) => PaymentEntity.fromJson(e)).toList() as M;
		}
		if(<TotalIncomesEntity>[] is M){
			return data.map<TotalIncomesEntity>((Map<String, dynamic> e) => TotalIncomesEntity.fromJson(e)).toList() as M;
		}
		if(<Links>[] is M){
			return data.map<Links>((Map<String, dynamic> e) => Links.fromJson(e)).toList() as M;
		}
		if(<Meta>[] is M){
			return data.map<Meta>((Map<String, dynamic> e) => Meta.fromJson(e)).toList() as M;
		}

		debugPrint("${M.toString()} not found");
	
		return null;
	}

	static M? fromJsonAsT<M>(dynamic json) {
		if (json is M) {
			return json;
		}
		if (json is List) {
			return _getListChildType<M>(json.map((e) => e as Map<String, dynamic>).toList());
		} else {
			return jsonConvert.convert<M>(json);
		}
	}
}