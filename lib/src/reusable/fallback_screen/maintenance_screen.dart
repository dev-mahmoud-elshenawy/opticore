part of '../reusable_import.dart';

/// A screen widget used to display a "Maintenance Mode" page when the system is under maintenance.
///
/// This screen informs the user that the application or service is currently under maintenance.
/// It shows a custom message, a Lottie animation, and provides a button to retry the action or refresh the system.
///
/// ## Key Features:
/// - Displays a "Maintenance Mode" screen with a custom Lottie animation and message.
/// - Includes a refresh button that triggers the provided `refreshCallBack` when tapped.
/// - Prevents navigation pop using `PopScope` by setting `canPop` to `false`.
/// - Customizable message, button text, toast message, and animation via configuration (via `MaintenanceConfig`).
/// - Includes a retry mechanism that prevents retries too frequently, showing a toast notification when retrying too quickly.
///
/// ## Constructor Parameters:
/// - `refreshCallBack`: A callback function that is triggered when the user taps the refresh button.
///
/// If no customization is needed, the default constructor provides default values using the `MaintenanceConfig` class.
///
/// ## How to Use:
/// Use this screen to notify users that the application is currently under maintenance. You can customize
/// the message, animation, and button text via the `MaintenanceConfig` class, or use the default configuration.
///
/// Example usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => const MaintenanceScreen()),
/// );
/// ```
///
/// ### Constructor:
/// - `key`: The optional `Key` used for widget identification.
/// - `refreshCallBack`: A function to handle the refresh logic when the refresh button is pressed.
class MaintenanceScreen extends StatefulWidget {
  final Function? refreshCallBack;

  /// Default constructor using `MaintenanceConfig` values for message, button text, animation, and retry toast.
  const MaintenanceScreen({
    super.key,
    this.refreshCallBack,
  });

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  DateTime _currentTime = DateTime.now();

  /// Prevents the retry action from being repeated too frequently.
  /// If the retry action is attempted within a short time frame, a toast message is shown.
  bool stopRepeating({
    Function()? action,
    Duration? duration,
  }) {
    DateTime now = DateTime.now();
    if (now.difference(_currentTime) > const Duration(seconds: 15)) {
      _currentTime = now;
      if (action != null) {
        action(); // Executes the provided action
      }
      return true;
    }
    ToastHelper.instance.showToast(
      MaintenanceConfig.messageRetryToast, // Custom message toast
      type: ToastType.WARNING,
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false, // Prevents the user from popping the screen
      child: Scaffold(
        backgroundColor: CoreColors.backgroundColor,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    10.ph, // Custom padding
                    Center(
                      child: SizedBox(
                        width: width * 0.75,
                        child: Text(
                          MaintenanceConfig.message, // Custom message
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    50.ph, // Custom padding
                    Lottie.asset(
                      MaintenanceConfig.anim, // Custom Lottie animation
                      width: 300,
                      height: 300,
                    ),
                    40.ph, // Custom padding
                    CoreButton(
                      title: MaintenanceConfig.messageButton, // Custom message button
                      onTap: () async {
                        ToolsHelper.triggerWithInternet(() {
                          // Trigger refresh action
                          stopRepeating(action: () {
                            widget.refreshCallBack!(); // Calls the refresh callback
                            Navigator.pop(context); // Pops the screen
                          });
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}