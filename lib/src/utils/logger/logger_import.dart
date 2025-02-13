import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talker/talker.dart';

import '../../../opticore.dart';
import 'logs/critical_log.dart';
import 'logs/debug_log.dart';
import 'logs/error_log.dart';
import 'logs/good_log.dart';
import 'logs/info_log.dart';
import 'logs/route_log.dart';
import 'logs/verbose_log.dart';
import 'logs/warning_log.dart';

part 'dio_logger.dart';
part 'logger.dart';
part 'observers/route_observer.dart';
