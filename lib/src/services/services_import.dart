import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/io.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:opticore/opticore.dart';

import 'network/interceptor/dio_connectivity_request.dart';

part '../services/network/infrastructure/api_response.dart';
part '../services/network/infrastructure/network_helper.dart';
