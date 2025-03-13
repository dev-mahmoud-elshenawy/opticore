# 🚀 OptiCore Infrastructure

This document provides an in-depth overview of the core infrastructure components of **OptiCore**.

## CoreSetup ⚙️

### Features ✨

- 🎨 **Global Theme & Localization Management** – Handles app-wide themes, locales, and translations.
- 🚀 **Pre-Configuration Hook** – Supports preloading tasks like Firebase initialization.
- 🔀 **Advanced Navigation & Observers** – Integrates `RouteHelper`, `BotToastNavigatorObserver`, and `LoggerRouterObserver` for seamless navigation control.
- ⚡ **Centralized Error Handling** – Provides built-in screens for **Maintenance Mode**, **No Internet**, and **Not Found** errors.
- 🔔 **Automated Toast Notifications** – Initializes `BotToast` for smooth in-app messaging.
- ⌨️ **Intelligent Keyboard Management** – Dismisses the keyboard automatically when tapping outside text fields.
- 🛠 **Debugging & Performance Tools** – Enables overlays for performance monitoring and accessibility testing.

## ApiResponseConfig 📡

### Features ✨

- ⚙️ **Global API Response Management** – Configures default and custom messages for API interactions.
- ⏳ **Request Timeout Handling** – Defines customizable error messages when API requests exceed allowed duration.
- 🌍 **Network Issue Detection** – Provides global messaging for network connectivity problems.
- ❌ **Unified Error Messaging** – Allows fallback error messages for unhandled API failures.
- 🔄 **Dynamic Configuration Updates** – Modify API messages at runtime without restarting the app.
- 🛠 **Reset to Defaults** – Restores API configurations to default values.
- 🏗 **Equatable Support** – Ensures efficient state management and comparisons.

## AppConfig 📲

### Features ✨

- 🎨 **Global Theme Customization** – Define a global theme for the entire app.
- 🏷 **App Title Configuration** – Sets the title displayed in `MaterialApp`.
- 🌍 **Multilingual Support** – Manage translations via `localizationsDelegates` and `supportedLocales`.
- 🚀 **Initial Route Setup** – Defines the app's entry point on launch.
- 🔀 **Dynamic Routing** – Implements `onGenerateRoute` and `onUnknownRoute` for flexible navigation.
- 📡 **Navigator Observers** – Tracks navigation for logging, analytics, or debugging.
- 🎨 **Primary Color Management** – Configure branding colors dynamically.
- 🏗 **Performance Debugging** – Enables overlays for performance analysis and accessibility.
- 🔍 **Scroll Behavior Customization** – Controls scrolling interactions within the app.
- 📩 **Global Snackbar Management** – Uses `ScaffoldMessenger` for centralized notification handling.
- 🌐 **Locale Switching** – Dynamically adjust language and region settings.

## MaintenanceConfig 🛠️

### Features ✨

- ⚙️ **Custom Maintenance Messages** – Display personalized messages during maintenance mode.
- 🔄 **Retry Button Customization** – Modify retry button text and functionality.
- 🔔 **Configurable Retry Toast** – Set a custom toast message for retry attempts.
- 🎭 **Custom Animation Support** – Replace the default maintenance animation with a custom asset.
- 🔧 **Global Config Management** – Initialize or modify settings dynamically.
- 🔄 **Instance Factory** – Easily create new configurations using factory constructors.
- 🔍 **Public Getters** – Access latest maintenance settings globally.
- 🗑️ **Restore Defaults** – Reset all settings to default values.

## NetworkConfig 🌐

### Features ✨

- 🔄 **Global Header Management** – Manage and update HTTP headers dynamically.
- ✏️ **Modify Headers** – Add or update headers globally.
- ❌ **Remove Headers** – Selectively remove headers while keeping others.
- 🔃 **Reset to Defaults** – Clear headers and restore default configurations.
- 🔍 **Immutable Header Access** – Ensure headers remain read-only where necessary.
- ⚡ **Efficient Updates** – Merge new headers seamlessly without overwriting existing ones.
- 🛠️ **Centralized Network Settings** – Keep configurations organized for maintainability.

## NoInternetConfig 📶

### Features ✨

- ⚙️ **Centralized No-Internet Screen Handling** – Configure offline UI globally.
- 📝 **Customizable Messages** – Display custom alerts when no internet is detected.
- 🔘 **Custom Retry Button** – Modify retry button text and behavior.
- 🎞️ **Custom Animation Support** – Replace default animation assets.
- 🔄 **Runtime Config Updates** – Modify settings dynamically without restarting the app.
- 🛠️ **Reset to Defaults** – Restore no-internet screen configurations.
- 📌 **Global Access** – Retrieve and modify settings from anywhere in the app.
- 🔄 **Factory Instantiation** – Create reusable configuration instances.
- 🔧 **Equatable Support** – Optimize comparisons and performance.

## NotFoundConfig 🚫🔍

### Features ✨

- ⚙️ **Global 404 Page Configuration** – Manage settings for the "Page Not Found" screen.
- 🎞️ **Custom Animation Support** – Define animations for missing pages.
- 🔄 **Dynamic Updates** – Modify settings at runtime without app restarts.
- 🔙 **Navigation Control** – Determine if users can dismiss the "Not Found" screen.
- 🛠️ **Reset Defaults** – Restore default navigation settings and animations.
- 📌 **Global Access** – Retrieve current settings globally.
- 🔧 **Factory Instantiation** – Easily create new instances with custom values.
- 🔄 **Equatable Support** – Optimize state management and performance.

## UnAuthenticatedConfig 🔒🚫

### Features ✨

- 🔄 **Custom Unauthenticated Handling** – Define dynamic authentication fallback logic.
- 🌍 **Global Config Support** – Manage unauthenticated scenarios centrally.
- 🔀 **Instance-Specific Customization** – Override global behavior for specific cases.
- 🚀 **Seamless Integration** – Link with external authentication handlers effortlessly.
- 🛠️ **Reset Defaults** – Restore unauthenticated logic to default settings.
- 🔧 **Factory Instantiation** – Create flexible configurations on demand.
- 📌 **Global Getter Access** – Retrieve settings from anywhere within the app.

---

**📌 OptiCore Functionality is designed to reduce development time, minimize errors, and enhance performance.** 🚀

📌 For further details, refer to the **full documentation**:

- **[Readme](./README.md)** – Comprehensive documentation covering utilities and features in detail.

🚀 **Start building smarter with OptiCore today!**
