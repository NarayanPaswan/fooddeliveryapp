import 'package:flutter/foundation.dart';
import 'package:fooddelivery/widgets/wsocial_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../notificationservice/local_notification_service.dart';
import '../../forgot_configuration/forgot_password.dart';
import '../../home/admin_home.dart';
import '../../home/home.dart';
import '../signup/signup.dart';
import '/utils/exports.dart';
import '../../../../controller/authControllerProvider/auth_controller_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LocalNotificationService localNotificationService =
      LocalNotificationService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final authenticationProvider = AuthenticationControllerProvider();
  bool isCheckRememberMe = false;
  String deviceTokenToSendPushNotification = "";

  void rememberMe(bool? value) {
    isCheckRememberMe = value!;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("remember_me", value);
      prefs.setString("user_email", _email.text);
      prefs.setString("user_password", _password.text);
    });
    setState(() {
      isCheckRememberMe = value;
    });
  }

  @override
  void initState() {
    localNotificationService.getDeviceTokenToSendNotification().then((value) {
      deviceTokenToSendPushNotification = value.toString();
      if (kDebugMode) {
        print("Device Token Value $deviceTokenToSendPushNotification");
      }
    });
    super.initState();
  }

  // 👉 Google Sign-in Function integrated with your Provider
  Future<void> googleSignInFunction(
    AuthenticationControllerProvider auth,
  ) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var result = await googleSignIn.signIn();
      if (result != null) {
        // print("Name: ${result.displayName}");
        // print("Email: ${result.email}");
        // print("Google ID: ${result.id}");

        // 🔥 Call the Provider function with Google info
        await auth.googleLogin(
          name: result.displayName ?? '',
          email: result.email,
          googleId: result.id,
          deviceToken: deviceTokenToSendPushNotification,
          // ignore: use_build_context_synchronously
          context: context,
        );

        // Navigate based on role
        if (auth.newRoleId == '3') {
          // ignore: use_build_context_synchronously
          PageNavigator(ctx: context).nextPageOnly(page: const HomeScreen());
        } else {
          PageNavigator(
            // ignore: use_build_context_synchronously
            ctx: context,
          ).nextPageOnly(page: const AdminHomeScreen());
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Google login error: $error");
      }
      // ignore: use_build_context_synchronously
      AppErrorSnackBar(context).error(error);
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the saved values from SharedPreferences

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        isCheckRememberMe = prefs.getBool("remember_me") ?? false;
        if (isCheckRememberMe) {
          _email.text = prefs.getString("user_email") ?? "";
          _password.text = prefs.getString("user_password") ?? "";
        }
      });
    });

    final dark = WHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: WSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                //logo titie and sub title
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      height: 100,
                      image: AssetImage(
                        dark ? WImages.lightAppLogo : WImages.lightAppLogo,
                      ),
                    ),
                    const SizedBox(height: WSizes.spaceBtwSections),
                    Text(
                      WTexts.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: WSizes.sm),
                    Text(
                      WTexts.loginSubTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: WSizes.spaceBtwSections,
                  ),
                  child: Column(
                    children: [
                      Text(
                        WTexts.signIn,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: WSizes.spaceBtwSections),
                      AppTextFormField(
                        prefixIcon: Iconsax.direct_right,
                        controller: _email,
                        hintText: WTexts.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return authenticationProvider.emailValidate(value!);
                        },
                      ),
                      const SizedBox(height: WSizes.spaceBtwInputFields),

                      Consumer<AuthenticationControllerProvider>(
                        builder: (context, auth, child) {
                          return AppTextFormField(
                            prefixIcon: Iconsax.password_check,
                            controller: _password,
                            hintText: WTexts.password,
                            suffixIcon:
                                auth.obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                            suffixIconOnPressed: () {
                              auth.obscurePassword = !auth.obscurePassword;
                            },
                            obscureText: auth.obscurePassword,
                            validator: (value) {
                              return auth.validatePassword(value!);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: WSizes.spaceBtwInputFields / 2),
                      //remember me forget password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //remember me
                          Row(
                            children: [
                              Checkbox(
                                value: isCheckRememberMe,
                                onChanged: rememberMe,
                              ),

                              Text(WTexts.rememberMe),
                            ],
                          ),
                          //forget passowrd
                          TextButton(
                            onPressed: () {
                              PageNavigator(
                                // ignore: use_build_context_synchronously
                                ctx: context,
                              ).nextPage(page: ForgotPasswordScreen());
                            },
                            child: Text(WTexts.forgetPassword),
                          ),
                          SizedBox(height: WSizes.spaceBtwSections),
                        ],
                      ),

                      // const SizedBox(height: WSizes.spaceBtwSections),
                      Consumer<AuthenticationControllerProvider>(
                        builder: (context, auth, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (auth.responseMessage != '') {
                              showMessage(
                                message: auth.responseMessage,
                                context: context,
                              );

                              ///Clear the response message to avoid duplicate
                              auth.clear();
                            }
                          });

                          return customButton(
                            text: WTexts.signIn,
                            ontap: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await auth.login(
                                    email: _email.text.trim(),
                                    password: _password.text.trim(),
                                    deviceToken:
                                        deviceTokenToSendPushNotification,
                                  );
                                  // ignore: use_build_context_synchronously

                                  if (auth.newRoleId == '3') {
                                    // Navigate to AgentHomeView
                                    Future.delayed(
                                      const Duration(seconds: 1),
                                      () {
                                        PageNavigator(
                                          // ignore: use_build_context_synchronously
                                          ctx: context,
                                        ).nextPageOnly(page: HomeScreen());
                                      },
                                    );
                                  } else {
                                    // Navigate to HomeView
                                    // ignore: use_build_context_synchronously
                                    PageNavigator(ctx: context).nextPageOnly(
                                      page: const AdminHomeScreen(),
                                    );
                                  }
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  AppErrorSnackBar(context).error(e);
                                }
                              }
                            },
                            context: context,
                            status: auth.isLoading,
                          );
                        },
                      ),
                      //create account button
                      const SizedBox(height: WSizes.spaceBtwItems),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            PageNavigator(
                              ctx: context,
                            ).nextPageOnly(page: const SignUpScreen());
                          },
                          child: Text(WTexts.createAccount),
                        ),
                      ),
                    ],
                  ),
                ),
                WFormDivider(dividerText: WTexts.orSignInWith.toUpperCase()),
                //Footer
                const SizedBox(height: WSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<AuthenticationControllerProvider>(
                      builder: (context, auth, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (auth.responseMessage != '') {
                            showMessage(
                              message: auth.responseMessage,
                              context: context,
                            );

                            ///Clear the response message to avoid duplicate
                            auth.clear();
                          }
                        });

                        return WSocialButton(
                          image: WImages.google,
                          onPressed: () async {
                            await googleSignInFunction(auth);
                          },
                          context: context,
                          status: auth.isGoogleLoading,
                        );
                      },
                    ),

                    const SizedBox(width: WSizes.spaceBtwItems),
                    WSocialButton(onPressed: () {}, image: WImages.facebook),
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
