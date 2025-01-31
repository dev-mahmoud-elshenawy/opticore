part of '../extensions_import.dart';

extension GroupByExtension<E> on List<E> {
  /// Groups elements by a key and returns a `Map<K, List<E>>`.
  ///
  /// **Example Usage:**
  /// ```dart
  /// List<String> words = ['apple', 'banana', 'apricot', 'blueberry'];
  /// var grouped = words.groupBy((word) => word[0]);
  /// print(grouped); // Output: {'a': ['apple', 'apricot'], 'b': ['banana', 'blueberry']}
  /// ```
  Map<K, List<E>> groupBy<K>(K Function(E) keySelector) {
    return fold({}, (map, element) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => []).add(element);
      return map;
    });
  }

  /// Groups elements and counts occurrences for each key.
  ///
  /// **Example Usage:**
  /// ```dart
  /// List<String> words = ['apple', 'banana', 'apricot', 'blueberry'];
  /// var counts = words.groupByCount((word) => word[0]);
  /// print(counts); // Output: {'a': 2, 'b': 2}
  /// ```
  Map<K, int> groupByCount<K>(K Function(E) keySelector) {
    return fold({}, (map, element) {
      final key = keySelector(element);
      map.update(key, (count) => count + 1, ifAbsent: () => 1);
      return map;
    });
  }

  /// Groups the elements of the list by a key selected using the provided function,
  /// and returns a default value if no group exists for a key.
  ///
  /// **Example usage:**
  /// ```dart
  /// List<String> words = ['apple', 'banana', 'apricot', 'blueberry'];
  /// Map<String, List<String>> groupedByFirstLetterWithDefault =
  ///     words.groupByWithDefault((word) => word[0], []);
  /// print(groupedByFirstLetterWithDefault); // Output: {'a': ['apple', 'apricot'], 'b': ['banana', 'blueberry']}
  /// ```
  Map<K, List<E>> groupByWithDefault<K>(
      K Function(E) keySelector, List<E> defaultValue) {
    final Map<K, List<E>> map = {};
    for (var element in this) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => defaultValue).add(element);
    }
    return map;
  }

  /// Groups elements and sums values in each group.
  ///
  /// **Example Usage:**
  /// ```dart
  /// List<Transaction> transactions = [
  ///   Transaction(category: 'Food', amount: 20),
  ///   Transaction(category: 'Food', amount: 30),
  ///   Transaction(category: 'Transport', amount: 15),
  /// ];
  /// var totalPerCategory = transactions.groupBySum((t) => t.category, (t) => t.amount);
  /// print(totalPerCategory); // Output: {'Food': 50, 'Transport': 15}
  /// ```
  Map<K, num> groupBySum<K>(
      K Function(E) keySelector, num Function(E) valueSelector) {
    return fold({}, (map, element) {
      final key = keySelector(element);
      final value = valueSelector(element);
      map.update(key, (sum) => sum + value, ifAbsent: () => value);
      return map;
    });
  }

  /// Groups elements and calculates the average value in each group.
  ///
  /// **Example Usage:**
  /// ```dart
  /// var scores = [
  ///   Student(name: 'Alice', score: 90),
  ///   Student(name: 'Bob', score: 80),
  ///   Student(name: 'Alice', score: 85),
  /// ];
  /// var avgScores = scores.groupByAverage((s) => s.name, (s) => s.score);
  /// print(avgScores); // Output: {'Alice': 87.5, 'Bob': 80.0}
  /// ```
  Map<K, double> groupByAverage<K>(
      K Function(E) keySelector, num Function(E) valueSelector) {
    final Map<K, num> sumMap = {};
    final Map<K, int> countMap = {};

    for (var element in this) {
      final key = keySelector(element);
      final value = valueSelector(element);
      sumMap.update(key, (sum) => sum + value, ifAbsent: () => value);
      countMap.update(key, (count) => count + 1, ifAbsent: () => 1);
    }

    return sumMap
        .map((key, totalSum) => MapEntry(key, totalSum / countMap[key]!));
  }

  /// Groups elements and applies a custom aggregation function.
  ///
  /// **Example Usage:**
  /// ```dart
  /// var scores = [
  ///   Student(name: 'Alice', score: 90),
  ///   Student(name: 'Bob', score: 80),
  ///   Student(name: 'Alice', score: 85),
  /// ];
  /// var minScores = scores.groupByCustomAggregation((s) => s.name, (s) => s.score, (a, b) => a < b ? a : b);
  /// print(minScores); // Output: {'Alice': 85, 'Bob': 80}
  /// ```
  Map<K, V> groupByCustomAggregation<K, V>(K Function(E) keySelector,
      V Function(E) valueSelector, V Function(V, V) aggregate) {
    return fold({}, (map, element) {
      final key = keySelector(element);
      final value = valueSelector(element);
      map.update(key, (existing) => aggregate(existing, value),
          ifAbsent: () => value);
      return map;
    });
  }

  /// Groups the elements of the list by a key and applies a transformation on each group.
  ///
  /// **Example usage:**
  /// ```dart
  /// List<String> words = ['apple', 'banana', 'apricot', 'blueberry'];
  /// Map<String, List<int>> groupedByFirstLetterAndMapped =
  ///     words.groupByAndMap((word) => word[0], (group) => group.length);
  /// print(groupedByFirstLetterAndMapped); // Output: {'a': [5, 7], 'b': [6, 9]}
  /// ```
  Map<K, List<R>> groupByAndMap<K, R>(
      K Function(E) keySelector, R Function(List<E>) transform) {
    final Map<K, List<E>> map = {};
    for (var element in this) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map.map((key, value) => MapEntry(key, [transform(value)]));
  }

  /// Groups the elements of the list by a key and finds the maximum element in each group.
  ///
  /// **Example usage:**
  /// ```dart
  /// List<int> numbers = [1, 2, 3, 4, 5, 6];
  /// Map<String, int> groupedByEvenOddMax = numbers.groupByMax((number) => number.isEven ? 'Even' : 'Odd', (number1, number2) => number1.compareTo(number2));
  /// print(groupedByEvenOddMax); // Output: {'Even': 6, 'Odd': 5}
  /// ```
  Map<K, E> groupByMax<K>(K Function(E) keySelector) {
    return fold({}, (map, element) {
      final key = keySelector(element);
      if (map.containsKey(key)) {
        final existing = map[key] as Comparable<E>;
        if (existing.compareTo(element) < 0) {
          map[key] = element;
        }
      } else {
        map[key] = element;
      }
      return map;
    });
  }

  /// Groups the elements of the list by a key and finds the minimum element in each group.
  ///
  /// **Example usage:**
  /// ```dart
  /// List<int> numbers = [1, 2, 3, 4, 5, 6];
  /// Map<String, int> groupedByEvenOddMin = numbers.groupByMin((number) => number.isEven ? 'Even' : 'Odd', (number1, number2) => number1.compareTo(number2));
  /// print(groupedByEvenOddMin); // Output: {'Even': 2, 'Odd': 1}
  /// ```
  Map<K, E> groupByMin<K>(K Function(E) keySelector) {
    return fold({}, (map, element) {
      final key = keySelector(element);
      if (map.containsKey(key)) {
        final existing = map[key] as Comparable<E>;
        if (existing.compareTo(element) > 0) {
          map[key] = element;
        }
      } else {
        map[key] = element;
      }
      return map;
    });
  }
}

extension ListGrouping<T> on List<T> {
  /// Groups elements by a **key selector** and returns a `Map<K, Set<T>>` for unique values.
  ///
  /// **Example Usage:**
  /// ```dart
  /// List<User> users = [
  ///  User(id: 1, name: 'Alice'),
  ///  User(id: 2, name: 'Bob'),
  ///  User(id: 1, name: 'Charlie')
  ///  ];
  ///  Map<int, Set<User>> groupedUsers = users.groupByToSet((user) => user.id);
  ///  print(groupedUsers);
  ///  // Output: {1: {Alice, Charlie}, 2: {Bob}}
  Map<K, Set<T>> groupByToSet<K>(K Function(T) keySelector) {
    return fold<Map<K, Set<T>>>({}, (map, element) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => {}).add(element);
      return map;
    });
  }

  /// Groups elements by a **key selector** and maps each group to a `Map<K, Map<K2, V>>`.
  ///
  /// **Example Usage:**
  /// ```dart
  /// List<User> users = [
  /// User(id: 1, name: 'Alice'),
  /// User(id: 2, name: 'Bob'),
  /// User(id: 1, name: 'Charlie')
  /// ];
  /// Map<int, Map<String, User>> groupedUsers = users.groupByToMap(
  ///   (user) => user.id,
  ///   (user) => user.name,
  /// );
  /// print(groupedUsers);
  /// // Output: {1: {Alice: User(id: 1, name: 'Alice'), Charlie: User(id: 1, name: 'Charlie')}, 2: {Bob: User(id: 2, name: 'Bob')}}
  /// ```
  Map<K, Map<K2, V>> groupByToMap<K, K2, V>(
    K Function(T) keySelector,
    K2 Function(T) nestedKeySelector,
    V Function(T) valueSelector,
  ) {
    return fold<Map<K, Map<K2, V>>>({}, (map, element) {
      final key = keySelector(element);
      final nestedKey = nestedKeySelector(element);
      final value = valueSelector(element);

      map.putIfAbsent(key, () => {})[nestedKey] = value;
      return map;
    });
  }

  /// Groups elements by a **key selector** and maps to the **first value in each group**.
  ///
  /// **Use Case:** When you only need one value per group instead of a list.
  ///
  /// **Example Usage:**
  /// ```dart
  /// List<User> users = [
  ///  User(id: 1, name: 'Alice'),
  ///  User(id: 2, name: 'Bob'),
  ///  User(id: 1, name: 'Charlie')
  ///  ];
  /// Map<int, String> groupedUsers = users.groupByToValue(
  ///   (user) => user.id,
  ///   (user) => user.name,
  /// );
  /// print(groupedUsers);
  /// // Output: {1: Alice, 2: Bob}
  /// ```
  Map<K, V> groupByToValue<K, V>(
    K Function(T) keySelector,
    V Function(T) valueSelector,
  ) {
    return fold<Map<K, V>>({}, (map, element) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => valueSelector(element));
      return map;
    });
  }
}
