# 🚀 OptiCore Reusability

This document provides a **detailed overview** of the **utilities, reusable components, and extensions** included in the **OptiCore** package. These features are designed to **boost productivity**, **reduce boilerplate code**, and **enhance UI/UX efficiency** in Flutter development.

## 🏗️ Reusable Components

### 🏛️ Structure

#### 🔹 Auto Scroll When Focused

- **`AutoScrollWhenFocused`**: Ensures a child widget becomes visible when it gains focus, such as when a `TextFormField` becomes focused and the keyboard appears.
  - **Features**:
    - Automatically scrolls the focused element into view when necessary.
    - Customizable scrolling animation with options for curve, duration, and alignment.
    - Ensures a seamless user experience by keeping the focused element visible in the viewport.

#### 🔙 Double Back Exit

- **`DoubleBackExit`**: Provides a user-friendly mechanism to exit the app by requiring a double back press.
  - **Features**:
    - Prevents accidental app exits by prompting users to confirm via a second back press.
    - Customizable exit message and duration between back presses.
    - Enhances user experience by reducing unintended closures.
    - Supports integration with `Scaffold` to ensure seamless functionality.

#### 🔹 Expandable Text

- **`ExpandableText`**: Displays text with an optional "Read more/Read less" button.
  - **Features**:
    - Limits the number of visible lines and provides a button to expand or collapse the text.
    - Customizable appearance and behavior, including text style, button style, and animation settings.
    - Supports expanding text on tap and collapsing text if allowed.
    - Provides a smooth animation for expanding and collapsing the text.

#### 🔹 Flexible GridView

- **`FlexibleGridView`**: A `GridView` that dynamically adjusts to the height of its children.
  - **Features**:
    - Allows for flexible row heights, determined by the height of the children.
    - Customizable with options for cross-axis count, cross-axis spacing, main-axis spacing, and alignment.
    - Supports `ScrollController` and scroll physics customization.
    - Optionally shrinks to occupy only as much space as needed by its children.

#### 🔹 Sliver Flexible GridView

- **`SliverFlexibleGridView`**: A sliver version of `FlexibleGridView` for use with `CustomScrollView`.
  - **Features**:
    - Provides the same dynamic grid layout as `FlexibleGridView`.
    - Optimized for use inside a `CustomScrollView` with other sliver widgets.

#### 🔹 Flexible ListView

- **`FlexibleListView`**: Displays a list of items with dynamic heights in a scrollable view.
  - **Features**:
    - Supports both horizontal and vertical scroll directions.
    - Customizable padding for the entire list and individual items.
    - Supports custom scroll physics and an optional `ScrollController`.
    - Dynamically adjusts to the height of its children.
    - Allows for flexible item building with a provided `itemBuilder` function.

#### 🔹 Hide On Scroll

- **`HideOnScroll`**: Animates the visibility of its child based on the user's scroll direction.
  - **Features**:
    - Hides the child when the user scrolls down and shows it again when the user scrolls up.
    - Supports both vertical and horizontal hiding behaviors.
    - Customizable animation duration.
    - Useful for hiding UI elements like a bottom navigation bar to provide more space for content.

#### 🔹 Index Scroller

- **`IndexScroller`**: Provides the ability to scroll to a specific index in a list.
  - **Features**:
    - Scrolls to a specific index in a list or `PageView`.
    - Supports highlighting an item at a specific index.
    - Customizable scroll animation duration and highlight duration.
    - Supports both vertical and horizontal scrolling.
    - Includes controllers for `ListView` and `PageView`.

#### 🔹 Lazy Indexed Stack

- **`LazyIndexedStack`**: Displays a stack of pages with lazy loading, fade transitions, and preloading support.
  - **Features**:
    - Lazy loading: Only the selected page and preloaded pages are built.
    - Fade transition: Smooth fade effect when switching between pages.
    - Preloading support: Specify indices to preload pages that are likely to be needed soon.
    - Efficient rebuilding: Non-visible pages are replaced with a placeholder widget to save resources.
    - Customizable animation duration and placeholder widget.

#### 🔹 Refresh View

- **`RefreshView`**: Wraps a child widget with a `RefreshIndicator` to provide pull-to-refresh functionality.
  - **Features**:
    - Implements pull-to-refresh behavior for scrollable content.
    - Supports any scrollable widget as the child (e.g., `ListView`, `GridView`).
    - Customizable refresh logic via the `onRefresh` callback.
    - Provides a seamless user experience for refreshing content.

#### 🔹 Top Scroller

- **`TopScroller`**: Listens for and handles scroll-to-top events.
  - **Features**:
    - Triggers a callback when a scroll-to-top event occurs.
    - Provides details about the scroll-to-top animation, including destination offset, duration, and curve.
    - Useful for implementing custom scroll-to-top behavior in scrollable widgets.

### 🔧 General Components

#### 🛠️ Core Sheet

- **`CoreSheet`**: Displays a customizable Cupertino-style modal bottom sheet.
  - **Features**:
    - Customizable appearance with background color and border radius.
    - Optional drag support and dismiss handling.
    - Expandable to full screen.

#### 🛠️ Core Button

- **`CoreButton`**: A customizable button widget for Flutter.
  - **Features**:
    - Customizable appearance with options for background color, border color, text color, border radius, and text style.
    - Supports an `onTap` callback function for handling button presses.
    - Dimming functionality to disable interactions when needed.
    - Optional border with customizable color and thickness.
    - Supports custom margin and padding values for better layout control.
    - Optionally includes a gradient background.

### ⚠️ Fallback Screens

#### 🏗️ Maintenance Screen

- **`MaintenanceScreen`**: Displays a "Maintenance Mode" page when the system is under maintenance.
  - **Features**:
    - Customizable message, button text, toast message, and animation.
    - Includes a refresh button that triggers a provided callback.
    - Prevents navigation pop using `PopScope`.
    - Retry mechanism to prevent frequent retries, showing a toast notification when retrying too quickly.

#### 📡 No Internet Screen

- **`NoInternetScreen`**: Displays a "No Internet" page when there is no internet connection.
  - **Features**:
    - Customizable message, button text, and animation.
    - Includes a refresh button that attempts to reconnect to the internet.
    - Prevents navigation pop using `PopScope`.
    - Optionally pops the screen after attempting to refresh the internet connection.

#### ❌ Not Found Screen

- **`NotFoundScreen`**: Displays a "Not Found" page when a requested route or resource is not found.
  - **Features**:
    - Customizable animation.
    - Prevents navigation pop using `PopScope`.
    - Typically used for 404 pages or error handling flows.

#### 🔄 Restart Widget

- **`RestartWidget`**: Allows restarting a part of the widget tree by resetting its key.
  - **Features**:
    - Generates a new unique key for the subtree to force a rebuild.
    - Can be triggered programmatically via the `restartApp()` method.
    - Useful for scenarios like login state reset, refreshing UI components, or handling dynamic state changes.

### 🎨 UI Elements

#### 🔘 Flexible CheckBox

- **`FlexibleCheckBox`**: A customizable checkbox widget.
  - **Features**:
    - Customizable appearance with options for checked and unchecked states.
    - Supports custom widgets and colors for checked, unchecked, and disabled states.
    - Optional border with customizable color.
    - Supports round or square shapes.
    - Includes an `onTap` callback function for handling checkbox state changes.
    - Animation support for state transitions.

#### 🖼️ Svg Widget

- **`SvgWidget`**: Renders SVG images from multiple sources, including assets, network, memory, file, and strings.
  - **Features**:
    - Supports multiple types of SVG sources: asset, network, string, file, and memory.
    - Easy-to-use interface for rendering SVG images with just a few parameters.
    - Supports both local and remote SVG images, as well as in-memory SVG data.
    - Customizable with options for color, placeholder, error widget, width, height, and fit.

#### ✂️ Truncated Text

- **`TruncatedText`**: Displays a string of text with a limited number of lines, truncating with an ellipsis if necessary.
  - **Features**:
    - Limits the number of lines displayed, truncating with an ellipsis if the text exceeds the limit.
    - Customizable appearance with options for text style, alignment, direction, and more.
    - Supports replacing the last break-line character with an ellipsis.
    - Useful for displaying long text that may exceed the available space.

### 🔄 Mixins & State Management

#### 🕒 After Layout Mixin

- **`AfterLayoutMixin`**: A mixin that triggers a callback after the first layout of a `StatefulWidget`.
  - **Features**:
    - Executes the `afterFirstLayout` method after the widget's first layout.
    - Useful for performing actions that depend on the widget's initial layout.
    - Ensures the callback is only called once after the initial layout.

### 🎨 Custom Painting

#### ➖ Advanced Line

- **`AdvancedLine`**: Renders a customizable line, which can be solid or dotted, in either horizontal or vertical orientation.
  - **Features**:
    - Supports solid and dotted line types.
    - Customizable appearance with options for color, stroke width, and gap size.
    - Can be rendered in horizontal or vertical orientation.
    - Uses `CustomPainter` for efficient drawing.

#### 🎨 Gradient Outlined Button

- **`GradientOutlinedButton`**: A customizable button with a gradient outline.
  - **Features**:
    - Customizable gradient for the button outline.
    - Adjustable stroke width for the outline.
    - Adjustable corner radius for rounded edges.
    - Supports a wide range of child widgets inside the button.
    - Reacts to tap gestures and invokes the provided callback on tap.

---

**📌 OptiCore Functionality is designed to reduce development time, minimize errors, and enhance performance.** 🚀

📌 For further details, refer to the **full documentation**:

- **[Readme](./README.md)** – Detailed utilities and feature documentation.

🚀 **Start building smarter with OptiCore today!**
