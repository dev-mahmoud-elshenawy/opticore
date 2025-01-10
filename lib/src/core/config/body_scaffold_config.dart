import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../base/import/base_import.dart';

/// A class that combines [ScaffoldConfig] with a provided [body] widget.
///
/// This class is used to encapsulate the configuration of a `Scaffold` widget
/// along with a body widget, enabling the separation of the Scaffold's configuration
/// from its content. It allows you to define all properties of the `Scaffold`
/// while providing the flexibility to inject the body separately, making the
/// configuration of the `Scaffold` more modular and reusable.
///
/// Example usage:
/// ```dart
/// BodyScaffoldConfig(
///   scaffoldConfig: ScaffoldConfig(
///     appBar: AppBar(title: Text('Example')),
///     backgroundColor: Colors.blue,
///     floatingActionButton: FloatingActionButton(onPressed: () {}),
///   ),
///   body: Center(child: Text('Hello World')),
/// );
/// ```
/// The above code creates a `Scaffold` with a configured `AppBar` and `FloatingActionButton`,
/// and the body contains a `Center` widget with a `Text` widget.
///
/// The [toScaffold] method combines the configuration with the provided [body]
/// to return a fully constructed `Scaffold` widget.
///
/// Properties:
/// - [scaffoldConfig]: The configuration of the `Scaffold` including app bar, background color, etc.
/// - [body]: The widget that will be displayed as the content of the `Scaffold`.
///
/// Methods:
/// - [toScaffold]: Returns a `Scaffold` widget using the provided [scaffoldConfig] and [body].
class BodyScaffoldConfig extends Equatable {
  /// The configuration object that defines the properties of the `Scaffold`.
  ///
  /// This includes elements such as the app bar, floating action button, background color,
  /// and any other properties typically associated with a `Scaffold`.
  final ScaffoldConfig scaffoldConfig;

  /// The widget to be displayed as the body of the `Scaffold`.
  ///
  /// This widget serves as the primary content of the `Scaffold`, which will be displayed
  /// in the center area of the `Scaffold`.
  final Widget body;

  /// Constructor for [BodyScaffoldConfig].
  ///
  /// [scaffoldConfig] is a required parameter that defines the configuration of the `Scaffold`.
  /// [body] is a required parameter that specifies the content widget to be displayed.
  const BodyScaffoldConfig({
    required this.scaffoldConfig,
    required this.body,
  });

  /// Combines the [scaffoldConfig] and [body] to return a fully constructed `Scaffold`.
  ///
  /// This method utilizes the [scaffoldConfig] to configure the `Scaffold` and injects
  /// the provided [body] as the content of the `Scaffold`.
  ///
  /// Returns:
  /// - A fully constructed [Scaffold] widget based on the configuration and body provided.
  Scaffold toScaffold() {
    return scaffoldConfig.toScaffold(body);
  }

  @override
  List<Object?> get props => [
    scaffoldConfig,
    body,
  ];
}