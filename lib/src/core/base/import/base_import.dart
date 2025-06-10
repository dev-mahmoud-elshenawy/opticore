import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opticore/opticore.dart';
import 'package:opticore/src/core/base/widget/exception_widget.dart';
import 'package:opticore/src/core/base/widget/loading_widget.dart';
import 'package:opticore/src/core/config/body_scaffold_config.dart';

import '../../../utils/ui/core_assets.dart';
import '../../../utils/ui/core_colors.dart';
import '../widget/appbar/leading_widget.dart';
import '../widget/content_builder.dart';
import '../widget/loading_animated_widget.dart';

part '../../config/app_bar_config.dart';
part '../../config/scaffold_config.dart';
part '../bloc/base_bloc.dart';
part '../event/base_event.dart';
part '../factory/base_factory.dart';
part '../observer/bloc_observer.dart';
part '../repo/base_repo.dart';
part '../screen/base_screen.dart';
part '../state/base_state.dart';
part '../state/error_type.dart';
part '../state/non_render_state.dart';
part '../state/render_state.dart';
part '../view/base_view.dart';
part '../widget/appbar/core_app_bar.dart';
part '../widget/state_builder.dart';
