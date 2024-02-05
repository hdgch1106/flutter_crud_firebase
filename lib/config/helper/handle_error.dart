import 'dart:io';

import 'package:crud_firebase/features/shared/infrastructure/infrastructure.dart';
import 'package:dio/dio.dart';

CustomError handleError(dynamic e) {
  if (e is DioException) {
    switch (e.response?.statusCode) {
      case 400:
        final errorMessage =
            e.response?.data["mensaje"] ?? "Solicitud incorrecta";
        return CustomError(
          code: 400,
          message: "Error 400: $errorMessage",
        );
      case 401:
        final errorMessage = e.response?.data["mensaje"] ?? "No autorizado";
        return CustomError(
          code: 401,
          message: "Error 401: $errorMessage",
        );
      case 403:
        final errorMessage =
            e.response?.data["mensaje"] ?? "Acceso no autorizado";
        return CustomError(
          code: 403,
          message: "Error 403: $errorMessage",
        );
      case 404:
        final errorMessage =
            e.response?.data["mensaje"] ?? "Contenido no encontrado";
        return CustomError(
          code: 404,
          message: "Error 404: $errorMessage",
        );
      case 409:
        final errorMessage =
            e.response?.data["mensaje"] ?? "Conflicto en la actualización";
        return CustomError(
          code: 409,
          message: "Error 409: $errorMessage",
        );
      case 413:
        final errorMessage =
            e.response?.data["mensaje"] ?? "Solicitud demasiado grande";
        return CustomError(
          code: 413,
          message: "Error 413: $errorMessage",
        );
      case 500:
        final errorMessage = e.response?.data["mensaje"] ??
            "Error en el servidor al procesar la solicitud";
        return CustomError(
          code: 500,
          message: "Error 500: $errorMessage",
        );
      case 503:
        final errorMessage = e.response?.data["mensaje"] ??
            "Servidor temporalmente fuera de servicio";
        return CustomError(
          code: 503,
          message: "Error 503: $errorMessage",
        );
      default:
        if (e.error is HandshakeException ||
            e.error is SocketException ||
            e.type == DioExceptionType.connectionError) {
          return CustomError(message: "Fallo en la conexión a internet");
        } else {
          return CustomError(message: "Error no controlado");
        }
    }
  }
  return CustomError(message: "Error no controlado");
}
