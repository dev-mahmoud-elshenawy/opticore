part of '../import/base_import.dart';

/// A reactive value holder that notifies listeners when its value changes.
///
/// Similar to Flutter's [ValueNotifier] but with additional convenience methods
/// for updating values and controlling notifications.
///
/// ## Examples
///
/// ### Basic Usage
/// ```dart
/// final counter = ReactiveNotifier<int>(0);
///
/// // Update value (notifies listeners)
/// counter.value = 10;
///
/// // Update based on current value
/// counter.update((current) => current + 1);
/// ```
///
/// ### With Reactive Widget (Auto Dispose by Default)
/// The [Reactive] widget automatically disposes the notifier when removed:
///
/// ```dart
/// Reactive<int>(
///   notifier: counter,
///   builder: (context, value, child) => Text('Count: $value'),
/// )
/// // No manual dispose needed - handled automatically!
/// ```
///
/// ### Complex Objects
/// ```dart
/// class User {
///   final String name;
///   final int age;
///   User({required this.name, required this.age});
/// }
///
/// final user = ReactiveNotifier<User>(User(name: 'John', age: 25));
///
/// // Update the entire object
/// user.value = User(name: 'Jane', age: 30);
///
/// // Or update based on current value
/// user.update((current) => User(name: current.name, age: current.age + 1));
/// ```
///
/// ### Working with Lists
/// ```dart
/// final items = ReactiveNotifier<List<String>>([]);
///
/// // Add item (creates new list to trigger notification)
/// items.update((list) => [...list, 'new item']);
///
/// // Or modify in place and call refresh
/// items.value.add('another item');
/// items.refresh();  // Notify listeners manually
/// ```
///
/// ### Silent Updates
/// ```dart
/// final counter = ReactiveNotifier<int>(0);
///
/// // Update without notifying (useful for batching)
/// counter.silent(5);
/// counter.silent(10);
/// counter.refresh();  // Single notification with final value
/// ```
///
/// ### Manual Lifecycle Management
/// If you manage the notifier elsewhere, disable auto-dispose:
///
/// ```dart
/// Reactive<int>(
///   notifier: counter,
///   autoDispose: false,  // You handle disposal
///   builder: (context, value, child) => Text('Count: $value'),
/// )
///
/// // Then dispose manually when done:
/// @override
/// void dispose() {
///   counter.dispose();
///   super.dispose();
/// }
/// ```
///
/// See also:
/// - [Reactive] for building UI that responds to value changes
/// - [AsyncReactiveNotifier] for async operations with loading/error states
/// - [ReactiveProvider] for sharing notifiers across the widget tree
class ReactiveNotifier<T> extends ChangeNotifier {
  /// Creates a [ReactiveNotifier] with an initial value.
  ReactiveNotifier(this._value);

  T _value;

  /// The current value stored in this notifier.
  ///
  /// When the value is replaced with something that is not equal to the old
  /// value as evaluated by the equality operator ==, this class notifies its
  /// listeners.
  T get value => _value;

  /// Sets the value and notifies listeners if the value has changed.
  ///
  /// The listeners are only notified if [newValue] is not equal to the
  /// current [value] as determined by the equality operator ==.
  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  /// Updates the value using a function that receives the current value.
  ///
  /// This is useful when the new value depends on the current value.
  ///
  /// ### Example
  /// ```dart
  /// final counter = ReactiveNotifier<int>(0);
  /// counter.update((current) => current + 1); // Increments by 1
  ///
  /// final list = ReactiveNotifier<List<String>>([]);
  /// list.update((current) => [...current, 'new item']); // Adds item
  /// ```
  void update(T Function(T current) updater) {
    value = updater(_value);
  }

  /// Sets the value without notifying listeners.
  ///
  /// Use this when you need to update the value but don't want to trigger
  /// a UI rebuild. The next time [value] is set normally or [refresh] is
  /// called, listeners will be notified with the latest value.
  ///
  /// ### Example
  /// ```dart
  /// final counter = ReactiveNotifier<int>(0);
  /// counter.silent(5);  // Value is now 5, but no notification
  /// counter.value = 6;  // Now listeners are notified
  /// ```
  void silent(T newValue) {
    _value = newValue;
  }

  /// Forces a notification to all listeners even if the value hasn't changed.
  ///
  /// This is useful when the value is a mutable object (like a List or Map)
  /// that has been modified in place.
  ///
  /// ### Example
  /// ```dart
  /// final items = ReactiveNotifier<List<String>>(['a', 'b']);
  /// items.value.add('c');  // Modifying in place, no notification
  /// items.refresh();       // Now listeners are notified
  /// ```
  void refresh() {
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}
