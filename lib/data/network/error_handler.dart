// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';
import "package:flutter/services.dart" as s;
import 'package:route_task/app/extenstions.dart';

import '../../resources/strings_manager.dart';
import '../failure/failure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
  Connection_Error,
  Bad_Certificate,
  Service_Unavailable
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // LoginFailure, API rejected request
  static const int UNAUTORISED = 401; // LoginFailure, user is not authorised
  static const int FORBIDDEN = 403; //  LoginFailure, API rejected request
  static const int INTERNAL_SERVER_ERROR =
      500; // LoginFailure, crash in server side
  static const int NOT_FOUND = 404; // LoginFailure, not found

  static const int Service_Unavailable = 503;

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
  static const int Connection_Error = -8;
  static const int Bad_Certificate = -9;
}

class ResponseMessage {
  static const String SUCCESS = StringsManager.success; // success with data
  static const String NO_CONTENT =
      StringsManager.success; // success with no data (no content)
  static const String BAD_REQUEST =
      StringsManager.badRequestError; // LoginFailure, API rejected request
  static const String UNAUTORISED =
      StringsManager.unauthorizedError; // LoginFailure, user is not authorised
  static const String FORBIDDEN =
      StringsManager.forbiddenError; //  LoginFailure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      StringsManager.internalServerError; // LoginFailure, crash in server side
  static const String NOT_FOUND =
      StringsManager.notFoundError; // LoginFailure, crash in server side

  static const String Service_Unavailable = StringsManager.serviceUnavailable;

  // local status code
  static const String CONNECT_TIMEOUT = StringsManager.timeoutError;
  static const String CANCEL = StringsManager.defaultError;
  static const String RECIEVE_TIMEOUT = StringsManager.timeoutError;
  static const String SEND_TIMEOUT = StringsManager.timeoutError;
  static const String CACHE_ERROR = StringsManager.cacheError;
  static const String NO_INTERNET_CONNECTION = StringsManager.noInternetError;
  static const String DEFAULT = StringsManager.defaultError;
  static const String Connection_Error = StringsManager.connectionError;
  static const String Bad_Certificate = StringsManager.badCertificate;
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int LoginFailure = 1;
}

extension DataSourceExtension on DataSource {
  Failure failure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTORISED:
        return Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
      case DataSource.Connection_Error:
        return Failure(
            ResponseCode.Connection_Error, ResponseMessage.Connection_Error);
      case DataSource.Bad_Certificate:
        return Failure(
            ResponseCode.Bad_Certificate, ResponseMessage.Bad_Certificate);
      case DataSource.Service_Unavailable:
        return Failure(ResponseCode.Service_Unavailable,
            ResponseMessage.Service_Unavailable);
    }
  }
}

Failure handleResponseStatus({required int statusCode}) {
  final List<Failure> failures = [
    DataSource.SUCCESS.failure(),
    DataSource.NO_CONTENT.failure(),
    DataSource.BAD_REQUEST.failure(),
    DataSource.FORBIDDEN.failure(),
    DataSource.UNAUTORISED.failure(),
    DataSource.NOT_FOUND.failure(),
    DataSource.INTERNAL_SERVER_ERROR.failure(),
    DataSource.Service_Unavailable.failure()
  ];
  Failure failure = DataSource.DEFAULT.failure();
  for (var i = 0; i < failures.length; i++) {
    if (failures[i].code == statusCode) {
      failure = failures[i];
      return failure;
    }
  }
  return failure;
}

class ErrorHandler implements Exception {
  late final Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.failure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.failure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.failure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.failure();
    case DioExceptionType.badResponse:
      if (error.response != null && error.response!.statusCode != null) {
        return Failure(error.response!.statusCode.orZero(),
            error.response!.statusMessage.orEmpty());
      } else {
        return DataSource.DEFAULT.failure();
      }

    case DioExceptionType.cancel:
      return DataSource.CANCEL.failure();
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.failure();
    case DioExceptionType.badCertificate:
      return DataSource.Bad_Certificate.failure();
    case DioExceptionType.connectionError:
      return DataSource.Connection_Error.failure();
  }
}
