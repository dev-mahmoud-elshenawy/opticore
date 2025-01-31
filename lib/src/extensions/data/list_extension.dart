part of '../extensions_import.dart';

extension SafeListExtensions<M> on List<M?>? {
  /// Filters out all null values from a list, returning a list of only non-null elements.
  ///
  /// If the list itself is `null`, it returns an empty list instead.
  ///
  /// **Example:**
  /// ```dart
  /// List<int?> values = [1, null, 3, null, 5];
  /// print(values.filterNonNull); // Outputs: [1, 3, 5]
  /// ```
  List<M> get filterNonNull => this?.whereType<M>().toList() ?? [];

  /// Safely retrieves an item at the specified [index], returning `null` if out of bounds.
  ///
  /// **Example:**
  /// ```dart
  /// List<String> names = ["Alice", "Bob"];
  /// print(names.safeGet(1));  // Outputs: "Bob"
  /// print(names.safeGet(5));  // Outputs: null
  /// ```
  M? safeGet(int index) {
    if (this == null || index < 0 || index >= (this ?? []).length) return null;
    return this![index];
  }

  /// Returns the first non-null element in the list, or `null` if all elements are null.
  ///
  /// **Example:**
  /// ```dart
  /// List<String?> names = [null, null, "Alice", "Bob"];
  /// print(names.firstNonNull);  // Outputs: "Alice"
  /// ```
  M? get firstNonNull => this?.firstWhere((e) => e != null, orElse: () => null);

  /// Merges this list with another list, ensuring unique values.
  ///
  /// **Example:**
  /// ```dart
  /// List<int>? list1 = [1, 2, 3];
  /// List<int> list2 = [3, 4, 5];
  /// print(list1.mergeUnique(list2));  // Outputs: [1, 2, 3, 4, 5]
  /// ```
  List<M?>? mergeUnique(List<M> other) {
    return {...?this, ...other}.toList();
  }
}

extension ListDeduplication<T> on List<T> {
  /// Removes duplicate elements from a **list**.
  ///
  /// By default, it uses `Set` to remove exact duplicates.
  ///
  /// You can also pass a **custom key selector** to remove duplicates based on specific attributes.
  ///
  /// **Example Usage:**
  /// ```dart
  /// List<int> numbers = [1, 2, 2, 3, 4, 4, 5];
  /// print(numbers.removeDuplicates); // Output: [1, 2, 3, 4, 5]
  ///
  /// List<User> users = [
  ///   User(id: 1, name: 'Alice'),
  ///   User(id: 2, name: 'Bob'),
  ///   User(id: 1, name: 'Alice')
  /// ];
  /// print(users.clean); // Output: [User(id: 1, name: 'Alice'), User(id: 2, name: 'Bob')]
  /// ```
  List<T> get clean {
    return toSet().toList(); // Default: Removes exact duplicates
  }

  /// Removes duplicate elements based on a **custom key selector**.
  ///
  /// **Example Usage:**
  /// ```dart
  /// List<User> users = = [
  ///  User(id: 1, name: 'Alice'),
  ///  User(id: 2, name: 'Bob'),
  ///  User(id: 1, name: 'Alice')
  ///  ];
  /// List<User> uniqueUsers = users.cleanBy((user) => user.id);
  /// print(uniqueUsers); // Output: [User(id: 1, name: 'Alice'), User(id: 2, name: 'Bob')]
  /// ```
  List<T> cleanBy(Object Function(T) keySelector) {
    final Set<Object> seen = <Object>{};
    return where((element) => seen.add(keySelector(element))).toList();
  }

  /// Sorts the list **without modifying the original list**.
  ///
  /// **Example:**
  /// ```dart
  /// List<int> numbers = [5, 3, 8, 1];
  /// print(numbers.sorted()); // Output: [1, 3, 5, 8]
  /// ```
  List<T> sorted([int Function(T a, T b)? compare]) {
    final List<T> newList = List.from(this);
    newList.sort(compare);
    return newList;
  }

  /// Reverses the list **without modifying the original list**.
  ///
  /// **Example:**
  /// ```dart
  /// List<int> numbers = [1, 2, 3, 4, 5];
  /// print(numbers.reversedList); // Output: [5, 4, 3, 2, 1]
  /// ```
  List<T> get reversedList => List.from(reversed);
}
