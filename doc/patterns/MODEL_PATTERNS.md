# Model Patterns Analysis

After analyzing the 3 files, here are the **4 common patterns** I identified:

---

## Pattern 1: Base Model Structure

**When to use:** Every data model in the project.

```dart
class MyModel extends Equatable {
  final int? id;
  final String? name;
  final NestedModel? nested;
  final List<ItemModel>? items;

  const MyModel({
    this.id,
    this.name,
    this.nested,
    this.items,
  });

  @override
  List<Object?> get props => [id, name, nested, items];
}
```

**Your conventions:**
- Extends `Equatable` for value equality
- All fields are `final` and nullable (`T?`)
- Constructor is `const` with named optional parameters
- `props` lists all fields for equality comparison

---

## Pattern 2: Safe JSON Parsing (fromJson)

**When to use:** Deserializing API responses into models.

```dart
factory MyModel.fromJson(Map<String, dynamic> json) {
  return MyModel(
    id: json.safeInt('id'),
    name: json.safeString('name').capitalizeFirst,
    isActive: json.safeBool('is_active'),
    amount: json.safeDouble('amount'),
    status: StatusType.fromValue(json.safeString('status')),
    nested: json.safeObject(
      key: 'nested',
      parser: (e) => NestedModel.fromJson(e),
    ),
    items: json.safeList(
      key: 'items',
      parser: (e) => ItemModel.fromJson(e),
    ),
  );
}
```

**Your conventions:**
- Uses Map extension methods: `safeInt`, `safeString`, `safeBool`, `safeDouble`
- Nested objects via `safeObject(key:, parser:)`
- Lists via `safeList(key:, parser:)`
- JSON keys are `snake_case`, Dart fields are `camelCase`
- Name fields use `.capitalizeFirst`
- Enums via `EnumType.fromValue()` or `.toEnumType` extension

---

## Pattern 3: Conditional Serialization (toJson/toAdd/toUpdate)

**When to use:** Sending model data to API (create/update requests).

```dart
Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};

  data.addIfNotNull(key: 'id', value: id);
  data.addIfNotNull(key: 'name', value: name);
  data.addIfNotNull(key: 'status', value: status?.value);
  data.addIfNotNull(key: 'nested', value: nested?.toJson());
  data.addIfNotNull(key: 'image', value: image?.pathStorage);
  data.addIfNotNull(
    key: 'files',
    value: files?.map((e) => e.pathStorage)
        .where((path) => (path ?? "").isNotEmpty).toList(),
  );

  return data;
}
```

**Your conventions:**
- Uses `addIfNotNull(key:, value:)` extension to skip nulls
- Enums serialized via `.value` property
- Nested models via `.toJson()`
- File models via `.pathStorage` (for uploads)
- Multiple methods for different contexts: `toJson()`, `toUpdate()`, `toAdd()`

---

## Pattern 4: Immutable Copy (copyWith)

**When to use:** Models that need state updates (forms, BLoC state).

```dart
MyModel copyWith({
  int? id,
  String? name,
  StatusType? status,
  NestedModel? nested,
  List<ItemModel>? items,
}) {
  return MyModel(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
    nested: nested ?? this.nested,
    items: items ?? this.items,
  );
}
```

**Your conventions:**
- All parameters optional, matching field names exactly
- Uses null-coalescing: `param ?? this.param`
- Returns new instance (immutability)
- Used on entity models (UserModel, MemberData), not on simple/read-only models

---

## Bonus: List Wrapper Model

**When to use:** API responses that return a list under a key.

```dart
class ItemsModel extends Equatable {
  final List<ItemData>? items;

  const ItemsModel({this.items});

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(
      items: json.safeList(
        key: 'items',
        parser: (e) => ItemData.fromJson(e),
      ),
    );
  }

  @override
  List<Object?> get props => [items];
}
```

---

## Summary Table

| Pattern | Required | Methods | Use Case |
|---------|----------|---------|----------|
| Base Structure | Always | constructor, props | All models |
| Safe Parsing | Always | `fromJson` | API → Model |
| Conditional Serialization | For mutations | `toJson`/`toUpdate`/`toAdd` | Model → API |
| Immutable Copy | For editable models | `copyWith` | State updates |
| List Wrapper | For list responses | `fromJson` | Wrap API arrays |
