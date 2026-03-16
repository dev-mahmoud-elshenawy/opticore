part of '../reusable_import.dart';

/// A widget that conditionally shows its [child] based on whether the provided
/// value(s) are non-empty and meaningful.
///
/// Handles `null`, empty strings, empty collections, zero numbers, and `false` booleans
/// as "empty" values. When all values are empty, shows [replacement] or [SizedBox.shrink].
///
/// ## Examples
///
/// ### Single Value
/// ```dart
/// ShowIfHasValue<String>(
///   value: user.bio,
///   child: Text(user.bio!),
/// )
/// ```
///
/// ### Multiple Values (all must have value)
/// ```dart
/// ShowIfHasValue<String>(
///   values: [user.firstName, user.lastName],
///   child: Text('${user.firstName} ${user.lastName}'),
/// )
/// ```
///
/// ### With Replacement Widget
/// ```dart
/// ShowIfHasValue<String>(
///   value: user.avatar,
///   replacement: const Icon(Icons.person),
///   child: Image.network(user.avatar!),
/// )
/// ```
class ShowIfHasValue<T> extends StatelessWidget {
  /// A single value to check. If non-empty, [child] is shown.
  final T? value;

  /// Multiple values to check. If any value is non-empty, [child] is shown.
  final List<T?>? values;

  /// The widget to display when value(s) are non-empty.
  final Widget child;

  /// Optional widget to display when value(s) are empty.
  /// Defaults to [SizedBox.shrink] if not provided.
  final Widget replacement;

  const ShowIfHasValue({
    super.key,
    this.value,
    this.values,
    required this.child,
    this.replacement = const SizedBox.shrink(),
  });

  static bool isEmpty(dynamic value) {
    if (value == null) return true;
    if (value is bool) return !value;
    if (value is num) return value == 0;
    if (value is String) return value.isEmpty;
    if (value is Iterable) return value.isEmpty;
    if (value is Map) return value.isEmpty;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (value != null) {
      return isEmpty(value) ? replacement : child;
    }

    if (values != null) {
      final allEmpty = values!.isEmpty || values!.every(isEmpty);
      return allEmpty ? replacement : child;
    }

    return replacement;
  }
}
