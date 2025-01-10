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
class NoInternetScreen extends StatelessWidget {
  final Function? refreshCallBack;
  final bool? withPop;

  const NoInternetScreen({
    super.key,
    this.refreshCallBack,
    this.withPop,
  });

  @override
  Widget build(BuildContext context) {
    // Mark that the "No Internet" scene is being shown.
    InternetConnectionHandler.isNoInternetSceneShown = true;

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
                    // Attempt to reconnect to the internet
                    ToolsHelper.triggerWithInternet(
                      () {
                        if (refreshCallBack != null) {
                          InternetConnectionHandler.isNoInternetSceneShown =
                              false;
                          refreshCallBack
                              ?.call(); // Invoke the refresh callback
                          if ((withPop ?? true)) {
                            context
                                .pop(); // Optionally pop the screen after refreshing
                          }
                        }
                      },
                    );
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
