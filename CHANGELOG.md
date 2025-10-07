# 📌 Changelog

All notable changes to this project are documented here. Each release includes details about new features, improvements, bug fixes, and any breaking changes, helping users and developers track the evolution of **OptiCore**.

## 🔄 Versioning Strategy

We follow **Semantic Versioning (SemVer)** to indicate the nature of changes:

- 🚀 **MAJOR**: Breaking changes that may affect compatibility.
- 🌟 **MINOR**: New features or improvements that are backward compatible.
- 🛠 **PATCH**: Bug fixes and minor improvements that are backward compatible.

Each section lists the changes in **chronological order**, with the **most recent release at the top**. Where applicable, links to relevant discussions or issues are provided.

### 🛠 [2.1.7] - Status Bar Navigation Fix

- 🐛 **Bug Fixes**:
  - Fixed status bar icon color not updating when navigating back to previous screen
  - Implemented `RouteAware` mixin in `BaseScreen` to properly track navigation lifecycle
  - Added global `RouteObserver` to `RouteHelper` for navigation event monitoring
  - Status bar icons now correctly switch between dark/light when popping back from another screen
  - Added `sized: true` to `AnnotatedRegion` for better status bar overlay coverage

- ⚡ **Performance Improvements**:
  - Optimized `_refreshStatusBar()` calls to only fire on actual navigation events (push/pop)
  - Removed redundant status bar updates from `initState`, `didChangeDependencies`, and `didUpdateWidget`
  - Reduced unnecessary rebuilds and system UI overlay updates

- 🏗 **Infrastructure**:
  - Enhanced `CoreSetup` to include `RouteObserver` in navigator observers
  - Improved navigation lifecycle handling across all screens using `BaseScreen`

### 🚀 [2.1.6] - Event Transformers & UI Enhancements

- 🎯 **New Features**:
  - Added **Event Transformers** for BLoC pattern with debounce and sequential processing
  - Introduced `debounce()` transformer with customizable duration for delayed event processing
  - Added predefined transformers: `fastDebounce()`, `standardDebounce()`, `slowDebounce()`, `verySlowDebounce()`
  - Implemented `sequential()` transformer for one-by-one event processing

- 🎨 **UI Improvements**:
  - Enhanced `CoreButton` with additional tap gesture support
  - Added `barrierColor` property to `CoreSheet` for better customization

- 🐛 **Bug Fixes**:
  - Fixed status bar icon color issues across different themes
  - Resolved type compatibility issues in theme extensions (`AppBarThemeData`, `InputDecorationThemeData`)

### 🆕 [2.1.5] - Scroll Overlay & Usability Improvements

- 🧩 **New Widget**:
  - `ScrollStatusBarOverlay`: Wraps a scrollable and paints an overlay behind the status bar to improve visual experience in scrollable UIs.

- 🎨 **UI Enhancements**:
  - Added `PlaceholderAlignment` support to `withUnderline` inside `WidgetSpan` for more control over inline widget alignment.
  - Introduced zero `itemPadding` default to `FlexibleGridView` for tighter and more compact grid spacing.

- 🔐 **Extensions**:
  - Enhanced `safeInt` extension for better default handling and fallback precision.

- 📦 **Dependency Updates**:
  - Updated internal dependencies for performance, compatibility, and future-proofing.

### ✨ [2.1.4] - UI & String Extension Enhancements

- 📝 **ExpandableText**:
  - Added `underline` support for enhanced text styling.

- 🌐 **String Extension**:
  - Introduced `.arabicNumbers` getter to convert English digits into Arabic numerals.

### 🔧 [2.1.3] - Validation Toolkit & Dependency Updates

- 📦 **Dependency Updates**:
  - Upgraded internal packages to ensure stability and compatibility

- ✅ **Validation Improvements**:
  - Integrated [`auto_validate`](https://pub.dev/packages/auto_validate) package
  - Centralized and enhanced validation capabilities across the micro-framework

### 🛠 [2.1.2] - API Enhancements

- 🧰 **Improved Map Extensions**:
  - Made `key` parameter optional in `safeList<T>()` for more flexible API usage
  - Enhanced return behavior to provide empty list when key is not provided

### 🛠 [2.1.1] - Static Analysis Improvements

- 📊 **Enhanced pub score** with improved static analysis compliance
- 📝 **Documentation refinements** for better DartDoc generation
- 🔍 **Type safety enhancements** across all components
- 🧹 **Code cleanup** with removal of unused imports and dependencies

### 🌟 [2.1.0] - Core Improvements & New Components

#### 🆕 New Features
- 🧩 **Added `StateBuilder` widget** for selective UI updates based on specific component states
- 🏗️ **Added `ComponentDataState`** in `RenderState` for better state management
- 🧰 **New Extensions**:
  - `DoubleFormatter` for smart number formatting (`formatSmart`)
  - `IterableExtension` with `firstWhereOrNull` method for safer collection operations
- 🎛️ **Enhanced CoreButton** with new properties (`dimmedBackgroundColor`, `dimmedTextColor`)

#### 🔄 Improvements
- 🖼️ **SvgWidget Enhancements**:
  - Auto-detection of SVG type
  - More flexible property requirements (path, bytes, or file)
- 🌐 **API & Network improvements**:
  - Better error handling
  - Fixed issues with status code parsing
  - Improved connection timeout handling with proper loading states
  - Fixed `updateHeaders` issues in `BaseRepo`
- 📱 **UI Components**:
  - Enhanced click behavior in `ExpandableText`
  - Added `enableScroll` property to `CoreSheet`
  - Set `itemPadding` default to zero in `FlexibleListView`
- 📊 **Code Quality**:
  - Improved `BaseBloc` implementation
  - Updated dependencies to latest versions

#### 🛑 Breaking Changes
- 🔄 Renamed `builder` to `itemBuilder` in `FlexibleGridView` for API consistency

### 📝 [2.0.1] - Documentation Update

- 📖 **Enhanced README.md**: Improved clarity, structure, and formatting for better readability.

### 🔹 [2.0.0] - Initial Stable Release

- 🎉 **First official stable release of OptiCore**.

For a complete history of updates during the **beta phase**, refer to **[Beta History](https://github.com/dev-mahmoud-elshenawy/opticore/blob/main/CHANGELOG-BETA.md)**.

---
Stay updated with the latest enhancements and fixes! 🚀
