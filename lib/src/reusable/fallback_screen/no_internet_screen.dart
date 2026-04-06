part of '../reusable_import.dart';

/// A screen widget that displays a "No Internet" page when there is no internet connection.
///
/// This screen is used to notify the user when there is no active internet connection. It shows a
/// custom animation (via Lottie) and provides a button to refresh the connection.
///
/// ## Key Features:
/// - Displays a "No Internet" screen with a custom Lottie animation and message.
//// - Includes a refresh button that attempts to reconnect to the internet when tapped.
/// - Prevents navigation pop using `PopScope` by setting `canPop` to `false`.
/// - The animation, message, and button text are customizable via `NoInternetConfig`.
///
/// ## Constructor Parameters:
/// - `refreshCallBack`: A callback function that is triggered when the user taps the refresh button.
/// - `withPop`: A boolean that determines whether the screen should pop after refreshing. Defaults to `true`.
///
/// ## How to Use:
/// You can use this screen when the app detects that there is no internet connection. It displays a message
/// and an animation with the option to refresh the connection. The refresh button will trigger the `refreshCallBack`
/// if provided, allowing for customized handling of the internet reconnection attempt.
///
/// Example usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => const NoInternetScreen()),
/// );
/// ```
///
/// ### Constructor:
/// - `key`: The optional `Key` used for widget identification.
/// - `refreshCallBack`: A function to handle the refresh logic when the refresh button is pressed.
/// - `withPop`: A boolean indicating whether the screen should pop after attempting to refresh the internet connection.
class NoInternetScreen extends StatefulWidget {
  final Function? refreshCallBack;
  final bool? withPop;
  final bool? isGoogleCheck;

  const NoInternetScreen({
    super.key,
    this.refreshCallBack,
    this.withPop,
    this.isGoogleCheck,
  });

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  void initState() {
    super.initState();
    // Mark that the "No Internet" scene is being shown (once, not on every rebuild).
    InternetConnectionHandler.isNoInternetSceneShown = true;
  }

  @override
  void dispose() {
    // Always reset the flag so that future no-internet events can navigate
    // again. This covers edge cases where the screen is removed without
    // going through the refresh button (e.g. app restart, programmatic pop).
    InternetConnectionHandler.isNoInternetSceneShown = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false, // Prevents the user from popping the current screen.
      child: Scaffold(
        backgroundColor: CoreColors.backgroundColor,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                110.ph, // Custom padding
                Lottie.asset(
                  NoInternetConfig.anim, // Custom animation path from config
                  width: 300,
                  height: 300,
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: width * 0.8,
                    child: Text(
                      NoInternetConfig.message, // Custom message from config
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                50.ph, // Custom padding
                CoreButton(
                  title: NoInternetConfig.messageButton,
                  // Custom button text from config
                  onTap: () async {
                    final isConnected =
                        await InternetConnectionHandler.checkInternetConnection(
                      widget.isGoogleCheck ?? false,
                    );

                    if (isConnected) {
                      InternetConnectionHandler.isNoInternetSceneShown = false;
                      widget.refreshCallBack?.call();
                      if ((widget.withPop ?? true) && context.mounted) {
                        context.pop();
                      }
                    } else {
                      // Show feedback so the user knows it's still offline
                      ToastHelper.showToast(
                        NoInternetConfig.message,
                        type: ToastType.error,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
