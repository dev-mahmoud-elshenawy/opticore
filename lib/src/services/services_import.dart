import 'dart:async';
import 'dart:convert';

import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:opticore/opticore.dart';

import 'network/interceptor/dio_connectivity_request.dart';
import 'network/interceptor/retry_connection.dart';

part '../services/network/infrastructure/api_response.dart';
part '../services/network/infrastructure/network_helper.dart';
