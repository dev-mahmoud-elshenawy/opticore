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
### Documentation
- **Updated Documentation**: Enhanced the documentation to cover the changes in `SvgWidget`, `CoreSheet`, and the new `ThemeExtension` feature, along with usage examples for seamless integration.

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
### Documentation
- **Expanded Documentation**: Enhanced the documentation to cover the new features and improvements, including detailed explanations for `LifecycleEventHelper`, `AfterLayoutMixin`, and the updated configuration flow in `CoreSetup`.

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