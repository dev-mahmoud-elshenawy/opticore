part of '../import/base_import.dart';

/// Represents the base class for all events within the BLoC architecture.
///
/// This abstract class serves as the foundation for defining events that are
/// dispatched to the `BaseBloc`. By extending this class, developers can create
/// specific events that trigger state transitions or business logic execution
/// within the BLoC.
///
/// ### Usage
/// Subclass `BaseEvent` to define specific events for your BLoC:
///
/// ```dart
/// class FetchDataEvent extends BaseEvent {
///   final int id;
///
///   FetchDataEvent(this.id);
/// }
/// ```
///
/// ### Example Workflow
/// 1. Define a `BaseEvent` subclass (e.g., `FetchDataEvent`).
/// 2. Dispatch the event to the BLoC using `add(event)`.
/// 3. Handle the event in the BLoC by overriding `on<EventType>` methods.
///
/// ### Key Benefits
/// - Provides a clean and modular approach to define and manage events.
/// - Ensures separation of concerns between the UI and business logic layers.
abstract class BaseEvent {}