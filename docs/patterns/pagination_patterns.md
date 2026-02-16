# OptiCore Pagination Patterns

Based on analyzing PartnersListScreen, SearchScreen, and NotificationsScreen.

---

## Pattern 1: PaginationScreen Setup

**When to use:** Any list that loads data from API with infinite scroll

**Structure:**
```dart
PaginationScreen<ModelType>(
  bloc: PaginationBloc(
    params: PaginationParams(
      url: Api.endpoint,
      jsonObjectName: 'items',
      params: filterParams.toJson(),  // Optional
    ),
    fromJsonInstance: (json) => ModelType.fromJson(json),
  ),
  loadingData: loadingData,
  pullRefresh: true,  // or false
  emptyView: EmptyWidget(),  // Optional
  itemView: (data, index, dataList, pagination) {
    return ItemWidget(data: data);
  },
)
```

**Conventions:**
- Generic type matches model: `PaginationScreen<PartnersData>`
- `jsonObjectName` matches API response key
- `fromJsonInstance` uses model's `fromJson`

---

## Pattern 2: Pagination Skeleton Data

**When to use:** To show shimmer loading placeholders

**Structure:**
```dart
List<ModelType>? loadingData = List.filled(
  8,  // Number of skeleton items
  ModelType(
    title: '---------',
    description: '------',
  ),
);
```

**Conventions:**
- Use `List.filled()` for uniform placeholders
- Use dashes `'---------'` for placeholder text (not `'xxxxxxxxxx'`)
- 4-8 items typical count
- Field values sized to approximate real content width

---

## Pattern 3: Pagination ItemView Builder

**When to use:** Every PaginationScreen item rendering

**Structure:**
```dart
itemView: (data, index, dataList, pagination) {
  return InkWell(
    onTap: () {
      context.pushNamed(
        RoutePath.detailScreen,
        arguments: DetailEntity(id: data.id),
      );
    },
    child: ItemWidget(data: data),
  );
},
```

**Conventions:**
- Signature always: `(data, index, dataList, pagination)`
- Wrap in `InkWell` for tap handling
- Navigate using `context.pushNamed` with entity arguments
- Return single widget (no need to handle loading state)

---

## Pattern 4: Pagination Refresh/Filter

**When to use:** When params change dynamically (search, filters, tabs)

**Structure:**
```dart
// 1. Store refresh callback
Function(Map<String, dynamic>)? refresh;

// 2. Define mutable params
FilterParam paginationParams = FilterParam(query: '');

// 3. In PaginationScreen
PaginationScreen(
  refresh: (retry) => refresh = retry,
  bloc: PaginationBloc(
    params: PaginationParams(
      url: Api.search,
      jsonObjectName: 'results',
      params: paginationParams.toJson(),
    ),
    // ...
  ),
)

// 4. Trigger refresh
void _refresh(String newQuery) {
  paginationParams = paginationParams.copyWith(query: newQuery);
  refresh!(paginationParams.toJson());
}
```

**Conventions:**
- Store refresh callback as nullable `Function?`
- Use `FilterParam.copyWith()` to update params immutably
- Call `refresh!(params.toJson())` to reload

---

## Summary Table

| Pattern | Key Marker | Files Using |
|---------|-----------|-------------|
| PaginationScreen Setup | `PaginationBloc` + `PaginationParams` | All 3 |
| Skeleton Data | `List.filled(N, Model(...))` | All 3 |
| ItemView Builder | `(data, index, dataList, pagination)` | All 3 |
| Refresh/Filter | `refresh: (retry) => refresh = retry` | Search |

---

## Quick Reference: Minimal Pagination

```dart
PaginationScreen<MyModel>(
  loadingData: List.filled(6, MyModel(title: '--------')),
  bloc: PaginationBloc(
    params: PaginationParams(url: Api.myEndpoint, jsonObjectName: 'items'),
    fromJsonInstance: (json) => MyModel.fromJson(json),
  ),
  itemView: (data, i, list, pg) => MyItemWidget(data: data),
)
```
