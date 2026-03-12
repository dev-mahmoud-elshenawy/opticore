# 🔌 OptiCore Extensions

This document provides a comprehensive overview of the powerful extensions included in **OptiCore**. These extensions enhance Flutter’s built-in classes by adding useful utilities, simplifying common operations, and improving code readability.

## 📌 Extensions Overview

### 🔤 String Extensions

- 🏷 **`notNull`** – Returns an empty string if `null`.
- 🔄 **`orSet`** – Provides a fallback value if the string is empty or `null`.
- ✅ **`notNullOrEmpty`** – Checks if a string is neither `null` nor empty.
- 🔠 **`toCamelCase`** – Converts a string to camelCase format.
- 🔒 **`maskSensitiveInfo`** – Masks sensitive data like email and phone numbers.
- ✂️ **`truncate`** – Shortens a string and appends an ellipsis if it exceeds a given length.
- 🚫 **`removeWhitespace`** – Removes all whitespace from a string.

### 📅 DateTime Extensions

- ⏳ **`toDateTimeOrDefault`** – Converts a value to `DateTime` or returns a default.
- ❓ **`toDateTimeOrNull`** – Converts a value to `DateTime` or returns `null`.

### 🔢 Numeric Parsing Extensions

- 🔢 **`toInt`** – Safely converts a value to an integer.
- 🔠 **`toDouble`** – Converts a value to a double without throwing errors.
- 🔄 **`toBool`** – Converts a value to a boolean (`true` or `false`).

### 🎨 Color Extensions

- 🎨 **`toColorWithAlpha`** – Converts a HEX color string into a `Color` object with alpha transparency.

### 📄 JSON Extensions

- ✅ **`isValidJson`** – Checks if a string is a valid JSON format.
- 🔍 **`safeJsonDecodeWithDefault`** – Parses JSON safely with a default value.
- 🗺 **`safeJsonDecodeAsMap`** – Converts JSON into a `Map<String, dynamic>`.
- 📄 **`safeJsonDecodeAsList`** – Parses a JSON array into a `List<dynamic>`.
- 🖋 **`prettyPrintJson`** – Formats JSON data for better readability.
- 🎯 **`safeJsonDecodeToObject`** – Converts JSON into a strongly typed object.
- 🔑 **`safeJsonDecodeKey`** – Extracts a specific key from a JSON object safely.
- 🏗 **`safeJsonDecodeNested`** – Retrieves nested values from a JSON object.
- 📜 **`safeJsonDecodeToListObjects`** – Parses a JSON array into a list of objects.

### 🎛 Map Extensions

- 🔍 **`safeObject`** – Retrieves a value as an object safely.
- 📜 **`safeList`** – Retrieves a list from a map.
- 🔢 **`safeInt`** – Extracts an integer value safely.
- 🎭 **`safeDouble`** – Retrieves a double value from a map.
- ✅ **`safeBool`** – Extracts a boolean value.
- 🔠 **`safeString`** – Retrieves a string representation of a value.
- ➕ **`addIfNotNull`** – Adds a key-value pair only if the value is non-null.
- 🏗 **`safeGetNested`** – Fetches deeply nested keys safely.
- 🔄 **`safeGet`** – Retrieves a value with a fallback default.
- 🔀 **`deepMerge`** – Merges two maps deeply.
- 🔄 **`toMap`** – Converts an object to a `Map<String, dynamic>`.

### 📜 List Extensions

- 🚮 **`filterNonNull`** – Removes `null` values from a list.
- 🔍 **`safeGet`** – Retrieves an element at an index safely.
- 🔄 **`firstNonNull`** – Returns the first non-null element in a list.
- 🔀 **`mergeUnique`** – Merges two lists and removes duplicates.
- 🏗 **`clean`** – Removes duplicate elements.
- 🏗 **`cleanBy`** – Removes duplicates based on a custom key selector.
- 🔄 **`sorted`** – Sorts the list based on custom criteria.
- 🔁 **`reversedList`** – Returns a reversed copy of the list.

### 🔢 Grouping Extensions

- 📌 **`groupBy`** – Groups list elements by a specified key.
- 🔢 **`groupByCount`** – Groups elements and counts occurrences.
- 🎯 **`groupByWithDefault`** – Groups elements with a default value.
- ➕ **`groupBySum`** – Groups elements and calculates the sum.
- 📊 **`groupByAverage`** – Groups elements and calculates the average.
- 🏗 **`groupByCustomAggregation`** – Custom grouping logic.
- 🔄 **`groupByAndMap`** – Groups and applies a transformation.
- 🔝 **`groupByMax`** – Finds the max element in each group.
- 🔽 **`groupByMin`** – Finds the min element in each group.
- 📌 **`groupByToSet`** – Groups elements into a `Set`.
- 🏗 **`groupByToMap`** – Groups elements into a `Map<K, Map<K2, V>>`.
- 🔄 **`groupByToValue`** – Groups elements and keeps only the first value.

### 📍 Navigation Extensions

- 🔀 **`push`** – Navigates to a new screen.
- 🚀 **`pushNamed`** – Navigates using a named route.
- 🔄 **`pushReplacement`** – Replaces the current screen.
- 🛑 **`pop`** – Pops the current route.
- 🔄 **`pushAndRemoveUntil`** – Clears navigation history up to a certain point.
- 🏠 **`routeBuilder`** – Handles route generation dynamically.

### 🎭 Context Extensions

- 🔡 **`textScaleFactor`** – Retrieves the text scale factor.
- 📏 **`screenSize`** – Gets the device screen size.
- 📐 **`isPortrait`** – Checks if the screen is in portrait mode.
- 📺 **`isLandscape`** – Checks if the screen is in landscape mode.
- 🔎 **`devicePixelRatio`** – Retrieves the pixel density of the screen.
- 📍 **`safeAreaInsets`** – Gets the safe area insets.
- 🌙 **`isDarkMode`** – Checks if the theme is in dark mode.

### 🔄 Safe Execution Extensions

- 🔄 **`orDefault`** – Returns a fallback value if the original is `null`.
- ❌ **`nullIfEquals`** – Returns `null` if the value matches a specific condition.
- 🔢 **`toSafeInt`** – Converts a value to an integer safely.
- 🔄 **`toSafeBool`** – Converts a value to a boolean safely.
- 🎭 **`toSafeDouble`** – Converts a value to a double safely.

### 📸 Precache Extensions

- 🎨 **`precacheAsset`** – Preloads an asset image into memory.
- 🌐 **`precacheNetwork`** – Preloads a network image.
- 🖼 **`precacheSvg`** – Preloads an SVG image.

### 🔀 Utility Extensions

- 🔍 **`letOrElse`** – Executes a block if the value is non-null.
- 🔄 **`also`** – Runs a function on an object and returns the object.
- ❓ **`takeIf`** – Returns the value if it matches a condition.

### 🎨 Theme Extensions

- 🌗 **`toggleTheme`** – Toggles between light and dark mode.
- 🎨 **`secondaryColor`** – Retrieves the secondary theme color.

# 🎨 UI Extensions

## 🖼 Image Extensions

- 🔄 **`toCachedNetworkImage`** – Converts a URL to a cached network image.
- 🎨 **`applyImageFilter`** – Applies a filter effect to an image.
- 🖼 **`resizeImage`** – Resizes an image to a specific dimension.
- 🌐 **`toNetworkImage`** – Converts a URL into a standard network image.
- 📂 **`toAssetImage`** – Loads an image from local assets.

## 📏 SizedBox Extensions

- ↔️ **`horizontalSpacing`** – Creates a `SizedBox` with horizontal width.
- ↕️ **`verticalSpacing`** – Creates a `SizedBox` with vertical height.
- 🔲 **`spacer`** – Creates a flexible spacer widget.

## 🔠 Text Extensions

- 🏗 **`withFontSize`** – Dynamically sets the font size.
- 🎨 **`withColor`** – Changes the text color inline.
- 🔤 **`bold`** – Applies bold styling to text.
- 🖋 **`italic`** – Converts text to italic.
- 🔲 **`underlined`** – Adds an underline to the text.
- 🔤 **`capitalize`** – Capitalizes the first letter of each word.
- ✍️ **`truncateText`** – Truncates text with an ellipsis if it exceeds a length.

## 🏗 Padding Extensions

- 🔲 **`applyPadding`** – Applies custom padding to any widget.
- 🔄 **`addPaddingHorizontal`** – Adds horizontal padding dynamically.
- ↕️ **`addPaddingVertical`** – Adds vertical padding dynamically.
- 🔳 **`removePadding`** – Removes padding from a widget.

## 🎨 Border Extensions

- 🔲 **`withRoundedCorners`** – Adds rounded corners to a widget.
- 🚀 **`withBorder`** – Applies a border with customizable properties.
- 🔳 **`dashedBorder`** – Adds a dashed border effect.
- 🔄 **`gradientBorder`** – Applies a gradient effect to a border.

## 🎭 Opacity Extensions

- 🌫 **`fadeIn`** – Adds a fade-in effect to a widget.
- 🌫 **`fadeOut`** – Adds a fade-out effect to a widget.
- 🔄 **`changeOpacity`** – Adjusts the widget’s opacity dynamically.

## 🎯 Button Extensions

- 🔘 **`elevatedButtonStyle`** – Returns a default elevated button style.
- 🔘 **`textButtonStyle`** – Returns a custom text button style.
- 🔘 **`outlinedButtonStyle`** – Returns a custom outlined button style.

## 🎛 Widget Extensions

- 🔄 **`rotate`** – Rotates a widget by a given angle.
- 📏 **`scale`** – Scales a widget up or down.
- 🎭 **`addShadow`** – Adds a shadow effect to a widget.
- 🖼 **`clipRounded`** – Clips a widget with rounded corners.
- 🔄 **`animateOnTap`** – Adds a slight bounce effect when tapped.

## 🏗 Layout Extensions

- 🔳 **`expandedView`** – Wraps a widget in an `Expanded` widget.
- 🔳 **`flexibleView`** – Wraps a widget in a `Flexible` widget.
- 🔳 **`alignCenter`** – Aligns a widget to the center.

---

**📌 OptiCore Functionality is designed to reduce development time, minimize errors, and enhance performance.** 🚀

📌 For further details, refer to the **full documentation**:

- **[Readme](../README.md)** – Comprehensive documentation covering utilities and features in detail.

🚀 **Start building smarter with OptiCore today!**
