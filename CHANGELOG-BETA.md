## [Beta 1.0.20]

### New Features

- **Refactored Parsing Methods**:
  - Renamed:
    - `toDoubleOrDefault` → `toDouble`
    - `toMapOrDefault` → `toMap`
    - `toListOrDefault` → `toList`
    - `toBoolOrDefault` → `toBool`
- **Safe Execution Utility**:
  - **`SafeCall.execute`**: Handles async operations safely with optional default values.
  - **New Void Execution**: Runs operations without returning a value.
- **Async State Management**:
  - **`AsyncValue.guard`**: A structured way to handle async operations.
  - **New Async States**:
    - `AsyncInitial`, `AsyncLoading`, `AsyncData`, `AsyncError`
  - **`AsyncBloc<T>`**: Streamlines async BLoC handling with built-in state management.
- **Navigation Enhancements**:
  - **`customCanPop`**: Customizable navigation pop behavior.
  - **`NotFoundConfig`**: Centralized handling for missing routes.

## [Beta 1.0.19]

### New Features

- **OptiKit CLI Integration:**
  - Introduced **OptiKit CLI** to enhance the interaction between the OptiCore package and its command-line interface.
  - The CLI now offers powerful commands to update version and build numbers, streamline builds, and automate common tasks, ensuring seamless integration with the package ecosystem.

### Improvements

- Optimized the overall workflow by synchronizing package updates with CLI operations, resulting in a more cohesive and efficient development experience.

## [Beta 1.0.18]

### New Features

- **Reusable Widget:**
  - Added `FlexibleCheckbox` widget for customizable checkbox functionality.
  - Introduced `DioLogger` for logging network requests and responses.
- **Enhanced analyzer warnings** to ensure better detection of potential issues, improving code maintainability.

## [Beta 1.0.17]

### New Features

- **Extended Context Utilities:**
  - Added `textScaleFactor` for retrieving the text scale factor.
  - Added `isLandscape` and `isPortrait` to determine screen orientation.
  - Added `screenSize` for getting the device screen size.
  - Added `devicePixelRatio` to access the screen's pixel density.
  - Added `safeAreaInsets` to get safe area padding values.
  - Added `isDarkMode` to check if the device is in dark mode.
- **Enhanced DateTime Utilities:**
  - Added `toDateTimeOrDefault` to safely parse a string into a `DateTime`, with a default fallback.
  - Added `toDateTimeOrNull` to convert a string to `DateTime?`, returning `null` if parsing fails.
- **Advanced Grouping Extensions:**
  - Introduced `groupBy`, `groupByCount`, and `groupByWithDefault` for flexible list grouping.
  - Added `groupBySum` and `groupByAverage` for numeric aggregations.
  - Implemented `groupByCustomAggregation` to allow custom aggregation logic.
  - Included `groupByAndMap`, `groupByMax`, and `groupByMin` for structured data grouping.
  - Added `groupByToSet`, `groupByToMap`, and `groupByToValue` for different map structures.
- **Hex Color Conversion:**
  - Added `toColorWithAlpha` to convert a hex string to a `Color` with a custom alpha value.
- **Enhanced JSON Parsing:**
  - Added `isValidJson` to check if a string is valid JSON.
  - Introduced `safeJsonDecodeWithDefault` for safely decoding JSON with a fallback.
  - Added `safeJsonDecodeAsMap` and `safeJsonDecodeAsList` for parsing JSON into structured types.
  - Implemented `prettyPrintJson` for formatted JSON output.
  - Introduced `safeJsonDecodeToObject` for parsing JSON directly into objects.
  - Added `safeJsonDecodeKey` and `safeJsonDecodeNested` for safely extracting specific values.
  - Added `safeJsonDecodeToListObjects` for parsing lists of objects.
- **Functional Programming Helpers:**
  - Introduced `letOrElse`, `also`, and `takeIf` for functional-style data transformations.
- **List Enhancements:**
  - Added `filterNonNull` to remove `null` values from a list.
  - Introduced `safeGet` to safely retrieve an item at a given index.
  - Added `firstNonNull` to get the first non-null element.
  - Implemented `mergeUnique` to merge lists while keeping only unique elements.
  - Improved deduplication with `clean` and `cleanBy`.
  - Added `sorted` for safely sorting lists without modifying the original.
  - Introduced `reversedList` for reversing a list without mutation.
- **Advanced Map Parsing:**
  - Introduced `safeObject`, `safeList`, `safeInt`, `safeDouble`, `safeBool`, and `safeString` for structured JSON parsing.
  - Improved `addIfNotNull` to conditionally add values to a map.
  - Added `safeGetNested` for deep key lookups.
  - Introduced `safeGet` for retrieving values with safety checks.
  - Implemented `deepMerge` to merge two maps deeply.
  - Added `toMap` for transforming objects into map structures.
- **Navigation Enhancements:**
  - Fully restructured the navigation extension for better usability.
  - Renamed `route` to `routeBuilder` for clarity.
- **Parsing Extensions:**
  - Added `toIntOrNull` and `toIntOrDefault` for integer conversion.
  - Introduced `toDoubleOrNull` and `toDoubleOrDefault` for safe double conversion.
  - Added `toMapOrNull` and `toMapOrDefault` for structured map parsing.
  - Implemented `toListOrNull` and `toListOrDefault` for safely handling lists.
  - Added `toBoolOrNull` and `toBoolOrDefault` for boolean conversion.
  - Included `isNumeric` to validate if a string contains numeric data.
  - Added `capitalizeFirstOnly` and `capitalizeFirst` for text transformations.
- **Precache Optimizations:**
  - Added `precacheAsset` and `precacheNetwork` for caching assets and network images.
  - Renamed `precacheSvgAsset` to `precacheSvg` for consistency.
- **Safe Handling Utilities:**
  - Introduced `orDefault` to provide default values for nullable types.
  - Added `nullIfEquals` to replace specific values with `null`.
  - Implemented `toSafeInt`, `toSafeBool`, and `toSafeDouble` for enhanced safety.
- **String Manipulation:**
  - Added `toCamelCase` for converting strings to camel case.
  - Introduced `maskSensitiveInfo` for masking sensitive data.
  - Added `truncate` for shortening text with ellipsis.
  - Implemented `removeWhitespace` for trimming excessive spaces.
- **Theme Enhancements:**
  - Introduced `toggleTheme` to programmatically switch themes.
  - Added `secondaryColor` to easily access secondary theme colors.

### New Reusable Widgets

- **TruncatedText**: A widget that dynamically truncates overflowing text.
- **DoubleBackExit**: A widget that handles double-tap to exit functionality.

## [Beta 1.0.16]

### New Features

- **TextInputHelper**:
  - Introduced `handleEgyptPhoneInput` to automatically remove the leading `0` when the country code is `+20`.
- **New Text Formatters**:
  - **EgyptPhoneNumberInputFormatter**: Provides the same functionality as `handleEgyptPhoneInput` but operates independently of controller listeners as a formatter.
  - **ForceLTRInputFormatter**: Ensures input text is forced to display in a left-to-right (LTR) direction.
- **Internet Connectivity Enhancements**:
  - Added `Stream<InternetStatus>` as `internetConnectionStream` for real-time internet connection monitoring.
  - Introduced `isConnected` variable that updates dynamically based on stream listening.
  - Implemented `startListeningToConnectivity` for initializing global internet connectivity monitoring in the app's top-level widget.
- **App Bar Configuration**:
  - Added `onBack` callback to customize the behavior of the back button navigation.

### Improvements

- **FlexibleListView**:
  - Default scroll direction updated to **vertical** for a more intuitive user experience.

- **String Extensions**:
  - Added `forceLTR` extension to handle foreign language strings when used alongside Arabic versions.

- **Code Refactoring**:
  - Separated text formatters into individual files for improved clarity and organization.

## [Beta 1.0.15]

### New Features

- **RequestBodyType Enum**:
  - Added a new `RequestBodyType` enum to handle API request body types.
  - Supports `formData` and `rawData` (JSON) formats.
  - Default body type is set to `rawData` (JSON).
- **Static ToastHelper**:
  - Replaced the singleton instance of `ToastHelper` with a static implementation for better performance and global accessibility.

### Improvements

- **Unauthorized Handling**:
  - Updated the mechanism for handling unauthorized scenarios.
  - Ensures consistent behavior and improved error messaging.
  - Dependency Updates and Code Refactoring for enhanced performance and stability.

## [Beta 1.0.14]

### New Features

- **UnAuthenticatedConfig**: Added a new configuration class to handle unauthenticated scenarios more effectively.
- **ApiResponseConfig**: Introduced a new configuration class for handling custom API response messages, such as request timeout, network issues, and generic errors.
- **New Extensions**:
  - `safeJsonEncode`: A safer way to encode JSON, ensuring exceptions are handled gracefully.
  - `safeJsonDecode`: A safer way to decode JSON, preventing errors with malformed or empty JSON strings.
  - `let`: An extension for executing a block of code on non-null values, improving code readability.

### Improvements

- **Configuration Setup**: Simplified configuration setup:
  - Removed any config setup except for app config related to unloaded data when using remote localization.
  - Use the `instantiate` method for managing each configuration separately.
- **NetworkConfig**: Added a new `removeHeaders` method for enhanced control over network headers.
- **Functions Converted to Getters**:
  - `toColor`: Converts a string to a color value.
  - `precacheSvgAsset`: Handles precaching of SVG assets.
  - `precacheNetwork`: Handles precaching of network images.
  - `precacheAsset`: Handles precaching of asset images.

### Bug Fixes

- Resolved an issue with states not rendering correctly in specific scenarios.

## [Beta 1.0.13]

### New Features and Enhancements

#### **Extensions**

- **Align Extensions**:
  - Added `alignBottomEnd` and `alignBottomStart` for quick alignment to bottom corners.
- **Positioned Extension Enhancements**:
  - Updated `PositionedExtension` to utilize `PositionedDirectional` instead of `Positioned`, ensuring better support for `TextDirection` in layouts.

#### **Reusable Widgets**

- **AutoScrollWhenFocused**:
  - Ensures a child widget scrolls into view when it gains focus.
- **ExpandableText**:
  - Displays text with a "Read more/Read less" toggle for better readability in constrained layouts.
- **FlexibleGridView**:
  - A dynamic `GridView` that adjusts to the height of its children.
- **FlexibleListView**:
  - Displays a scrollable list of items with dynamically varying heights.
- **HideOnScroll**:
  - Animates visibility of a child widget based on scroll direction, perfect for headers or floating action buttons.
- **IndexScroller**:
  - Provides functionality to scroll to a specific index in a list effortlessly.
- **LazyIndexedStack**:
  - Enhanced with transition duration customization for smoother animations.
- **TopScroller**:
  - Listens for and responds to scroll-to-top gestures, improving navigation flow.

#### **Helper Classes**

- **AsyncHelper**:
  - Added utilities for managing asynchronous tasks:
    - `executeSequentially`: Ensures tasks execute in sequence without overlap.
    - `catchAnimationCancel`: Gracefully handles `TickerCanceled` exceptions in animations.
- **ClipboardHelper**:
  - Simplified interaction with the system clipboard:
    - `copyText`: Copies a string to the clipboard, with error handling for empty strings.
    - `pasteText`: Retrieves plain text from the clipboard.
    - `copyWithResult`: Provides a boolean result indicating success or failure of the copy operation.
    - `getClipboardData`: Fetches raw `ClipboardData` for advanced use cases.
- **SnapScrollSize**:
  - Introduced a custom `ScrollPhysics` for snapping scroll positions to a fixed interval.
  - Features include:
    - Smooth snapping animations.
    - Support for velocity-based adjustments.
    - Seamless integration with existing scrolling mechanisms.

### **General Improvements**

- **Code Refactoring**:
  - Optimized logic in reusable components to improve maintainability and performance.
- **Enhanced Documentation**:
  - Comprehensive examples and usage guides for new additions, ensuring easier adoption.

## [Beta 1.0.12]

### New Features and Enhancements

- **New Extension**: Added the `PositionedExtension` for improved widget positioning.
  - Provides utility methods:
    - `positioned`: Wraps a widget with `PositionedDirectional` for precise positioning.
    - `positionedFill`: Wraps a widget with `Positioned.fill` for edge-to-edge placement.
    - `positionedDirectional`: Wraps a widget with `Positioned.directional` to support text direction for `start` and `end` positions.
  - Includes detailed documentation and examples for easy usage.
- **Enhancements to Existing Extensions**:
  - Updated and refined older extensions for better consistency and usability.
- **Code Refactor**:
  - Improved `LazyIndexedStack` to stop unnecessary rebuilding of child widgets, optimizing performance.

## [Beta 1.0.11]

### Code Optimizations and Documentation Updates

- **Documentation Update**: Enhanced documentation with clearer examples and more detailed explanations for new widgets and extensions.

## [Beta 1.0.10]

### Enhancements and New Features

- **LazyIndexedStack Widget**: Introduced `LazyIndexedStack` for optimized performance by deferring the loading of non-visible children.
- **SizedBox Extension**: Added extensions for more flexible `SizedBox` creation with methods like `width`, `height`, `box`, `expand`, `alignedBox`, `paddedBox`, and `flexible`.
- **SVG Widget Customization**: Enhanced the customization options for `SvgWidget`, allowing for more flexible and efficient use in applications.

## [Beta 1.0.9]

### Enhancements and New Features

- **App Bar Logic**: Handle app bar selection based on `scaffoldConfig` and `appBarData`.
- **ScaffoldConfig**: Added `copyWith` method for easier object modification.
- **BlocProvider Fix**: Corrected baseContext issue.
- **Widget Extensions**: Added `expanded` and `flexible` extensions for better layout handling.
- **Content Builder**: Enhanced functionality.
- **NullNonRenderState**: Added `NullNonRenderState` class.

## [Beta 1.0.8]

### Minor Updates

- **Code Refinement**: Improved internal code structure for better maintainability and readability.

## [Beta 1.0.7]

### Enhancements and New Features

- **`AlignmentExtension`**: Added alignment methods like `alignTopStart`, `alignCenter`, etc., to easily align widgets using the `Align` widget.
- **`CenterExtension`**: Introduced the `center` getter to simplify centering widgets within their parent using the `Center` widget.
- **`EmptyPadding`**: Added shorthand methods `ph` for vertical and `pw` for horizontal padding, making it easier to add padding to widgets.
- **`PaddingExtension`**: Enhanced with methods for custom directional padding (`paddingOnly`), uniform padding (`paddingAll`), and symmetric padding (`paddingSymmetric`).
- **`VisibilityExtension`**: Added the `animatedOpacity` method to toggle visibility with animation, allowing widgets to fade in/out.

### Improvements

- **AppBarConfig**: Enhanced the `AppBarConfig` with additional properties to customize app bars further.
- **Leading Widget**: Improved handling of the `LeadingWidget` in `CoreAppBar` for better consistency.
- **CoreAppBar**: Polished and refined the `CoreAppBar` for a more consistent and efficient experience.

## [Beta 1.0.6]

### Improvements

- Enhanced code formatting for better readability.
- Fixed all warnings and analysis issues for a cleaner codebase.

## [Beta 1.0.5]

### Enhancements and New Features

- **Updated Dependencies**: Upgraded the package dependencies to ensure compatibility, security, and performance improvements.
- **`SvgWidget` Enhancements**: Made the `type` parameter required, ensuring more robust and predictable behavior when using the `SvgWidget`.
- **`CoreSheet` Improvements**: Added a `SafeArea` to the child of `CoreSheet`, enhancing the user interface by preventing content from being obscured by system UI elements.
- **Theme Extension**: Introduced a new `ThemeExtension` to provide developers with an extended theming capability, enabling more customized and consistent styling across the application.

### Fixes

- **`CoreAssets` Issue Resolved**: Fixed an issue with `CoreAssets` paths to ensure proper resolution and loading of assets when the package is used in other projects.

## [Beta 1.0.4]

### Enhancements and New Features

- **`ArabicToEnglishNumberFormatter`**: Added a utility for converting Arabic numerals to English numerals for consistent number formatting across locales.
- **`ScrollBehaviorHelper`**: Introduced a custom implementation of `MaterialScrollBehavior` to provide platform-specific scroll physics. This improves the scrolling experience on iOS, Android, macOS, and other platforms.
- **`LifecycleEventHelper`**: A new class that observes app lifecycle changes, enabling developers to run custom actions when the app is resumed or suspended. It provides optional `resumeCallBack` and `suspendingCallBack` parameters for handling specific lifecycle states.
- **Download Method Enhancement**: Fixed an issue with the `HTTPMethod.download` case in the Dio integration, including improved handling of download progress through the `onReceiveProgress` callback.
- **Fixed `onSendProgress` Issue**: Resolved issues with tracking upload progress in the Dio `onSendProgress` callback.
- **`AfterLayoutMixin`**: Introduced a mixin to trigger actions after the first layout of a widget has been rendered. This ensures that layout-dependent logic is executed after the widget tree has been fully built.
- **Safe List Value Fix**: Corrected issues with safe access to list values, ensuring null safety and preventing runtime errors.
- **Enhanced `ContentBuilder` and `BaseScreen`**: Improved handling of content rendering and base screen management to optimize app flow and usability.
- **Enhanced `CoreSetup`**: Refined the `CoreSetup` class by incorporating the `AfterLayoutMixin` to manage the configuration initialization process more effectively. The `_initializeConfigurations` method now allows the use of `onBeforeConfigApply` for handling actions before configuration is applied.

### Improvements

- **Default Scroll Behavior**: The `ScrollBehaviorHelper` is now the default class for scroll behavior, enhancing scrolling performance with platform-specific optimizations.
- **Configuration Handling**: Added `checkerboardRasterCacheImages`, `checkerboardOffscreenLayers`, `showPerformanceOverlay`, `locale`, `scaffoldMessengerKey`, and `scrollBehavior` as configurable options in `CoreSetup` to allow fine-grained control over app behavior and performance.
- **Improved Config Initialization**: The `CoreSetup` class now supports more flexible configuration management by providing hooks like `onBeforeConfigApply`, ensuring that configurations are applied in a structured, sequence-sensitive manner.

### Fixes

- **Improved Error Handling**: Addressed minor issues in the error-handling logic, ensuring more robust behavior when handling edge cases and null values.
- **Resolved Layout Timing Issues**: Fixed issues with the timing of layout-dependent operations using `AfterLayoutMixin`, ensuring smoother UI rendering.

## [Beta 1.0.3]

### Enhancements and New Features

- **Integrated dependencies into the package export** to simplify usage. These dependencies can now be accessed directly through the package, eliminating the need for separate installations:
  - `flutter_bloc`
  - `talker`
  - `talker_dio_logger`
  - `dio`
  - `bot_toast`
  - `font_awesome_flutter`
  - `lottie`
  - `equatable`
  - `flutter_svg`
  - `internet_connection_checker_plus`
  - `connectivity_plus`
  - `cached_network_image`
  - `modal_bottom_sheet`

### Improvements

- Simplified the developer experience by bundling common dependencies into the package, making it easier to set up and use.

### Fixes

- Minor adjustments to the package structure to improve compatibility with bundled dependencies.

## [Beta 1.0.2]

### Enhancements and New Features

- **Added comprehensive documentation** for all string-related extensions, improving clarity and ease of use.
- **Enhanced error handling** in string formatting extensions to ensure robust and fail-safe operations.
- **Improved Arabic to English number conversion logic** ensuring better handling of edge cases.
- **Refactored formatPrice method** for better performance and readability.
- **Streamlined the formatDate method** to handle malformed date strings gracefully.

### Fixes

- Fixed minor inconsistencies in null-checking logic for nullable strings.
- Resolved an issue where invalid date strings would not default to the current date properly.

## [Beta 1.0.1]

### Enhancements and Optimizations

- **Improved code quality** by addressing warnings and enhancing linting rules to comply with best practices.
- **Optimized the code** for better performance, including refactoring certain components and reducing redundant logic.
- **Enhanced analyzer warnings** to ensure better detection of potential issues, improving code maintainability.
- **Added Example** to demonstrate the package’s structure and usage, making it easier for developers to understand and integrate the package into their projects.
- Made minor **UI adjustments** to enhance the user experience in various components.
- Improved **documentation** for better understanding of the package's architecture and future extensibility.

## [Beta 1.0.0]

### Initial Release (Beta)

- **Initial version** of the package, laying the foundation for future development.
- Introduced core functionality for **OptiCore**, including essential components for UI state management, error handling, and animations.
- Released a structured, scalable architecture designed to accommodate future feature enhancements and optimizations, with placeholders for upcoming improvements.
