# Repository Patterns Analysis

After analyzing the 3 files, here are the **4 common patterns** I identified:

---

## Pattern 1: Simple Fetch

**When to use:** Fetching data from a fixed endpoint with no parameters.

```dart
Future<ApiResponse<T?>> getData() async {
  ApiResponse<T?> response = await networkHelper!.request<T?>(
    Api.endpoint,
    (data) => Model.fromJson(data!['data']),
    method: HTTPMethod.get,
  );
  return response;
}
```

**Examples:** `ProfileRepo.getData()`, `ServiceRepo.getCategories()`, `ProfileRepo.getBadge()`

**Your conventions:**
- Parser extracts from `data!['data']` (or `data!['data']['field']` for primitives)
- Always returns `ApiResponse<T?>`

---

## Pattern 2: Fetch with Query Params

**When to use:** Fetching lists with filters, pagination, or optional constraints.

```dart
Future<ApiResponse<T?>> getData({int? limit, bool? flag}) async {
  ApiResponse<T?> response = await networkHelper!.request<T?>(
    Api.endpoint,
    (data) => Model.fromJson(data!['data']),
    method: HTTPMethod.get,
    params: {
      'limit': limit ?? defaultValue,
      'flag': flag ? '1' : '0',
    },
  );
  return response;
}
```

**Examples:** `ProjectsRepo.getData(limit:)`, `ServiceRepo.getData(isRecommended:, limit:)`, `ServiceRepo.getRequestedServices(type:, filter:)`

**Your conventions:**
- Params built inline or via `filter?.toJson()`
- Booleans converted to `'1'`/`'0'` strings

---

## Pattern 3: Resource Fetch (by ID)

**When to use:** Fetching a specific resource or nested resource by ID(s).

```dart
Future<ApiResponse<T?>> getResource({int? parentId, int? childId}) async {
  ApiResponse<T?> response = await networkHelper!.request<T?>(
    "${Api.parent}/$parentId/child/$childId/resource",
    (data) => Model.fromJson(data!['data']),
    method: HTTPMethod.get,
  );
  return response;
}
```

**Examples:** `ProjectsRepo.getPhaseOverView(projectId:, phaseId:)`, `ServiceRepo.getDetails(serviceId)`, `ServiceRepo.getAvailabilities(serviceId, subServiceId)`

**Your conventions:**
- URL built via string interpolation: `"${Api.base}/$id/resource"`
- Nested resources follow RESTful path: `/parent/{id}/child/{id}/action`

---

## Pattern 4: Action (Mutation)

**When to use:** Creating, updating, or deleting resources (POST/PUT/DELETE).

```dart
Future<ApiResponse<MessageModel?>> performAction({
  int? resourceId,
  required DataModel data,
}) async {
  ApiResponse<MessageModel?> response =
      await networkHelper!.request<MessageModel?>(
    "${Api.resource}/$resourceId/action",
    (data) => MessageModel.fromJson(data!),
    method: HTTPMethod.post, // or put, delete
    body: data.toJson(),     // or inline map, or omit for delete
  );
  return response;
}
```

**Examples:** `ProjectsRepo.contactUs()`, `ProfileRepo.updateData()`, `ProfileRepo.changePassword()`, `ServiceRepo.request()`, `ServiceRepo.cancelService()`, `ServiceRepo.deleteCard()`

**Your conventions:**
- Returns `MessageModel` for action confirmation
- Parser uses `data!` directly (not `data!['data']`)
- Body via `model.toJson()` or inline `Map<String, dynamic>`
- Conditional body fields: `if ((value ?? "").isNotEmpty) "key": value`

---

## Summary Table

| Pattern | HTTP Method | Has Params | Has Body | Return Type |
|---------|-------------|------------|----------|-------------|
| Simple Fetch | GET | No | No | `Model` |
| Query Fetch | GET | Yes (query) | No | `Model` |
| Resource Fetch | GET | Yes (path) | No | `Model` |
| Action | POST/PUT/DELETE | Yes (path) | Yes/No | `MessageModel` |
