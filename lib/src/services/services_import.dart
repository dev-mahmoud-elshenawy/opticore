import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:opticore/opticore.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'network/interceptor/dio_connectivity_request.dart';
import 'network/interceptor/retry_interceptory.dart';

part '../services/network/infrastructure/api_response.dart';
part '../services/network/infrastructure/network_helper.dart';
