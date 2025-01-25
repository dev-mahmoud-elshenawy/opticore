part of '../enum_import.dart';

/// Enum for request body type
///
/// [formData] for form data
/// [json] for json data
///
/// Used in [BaseApi] to determine the request body type
enum RequestBodyType {
  /// Form data request body type
  formData,

  /// JSON request body type
  json
}
