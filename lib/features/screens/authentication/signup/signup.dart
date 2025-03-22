import 'package:flutter/gestures.dart';
import 'package:fooddelivery/features/screens/authentication/login/login.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../controller/authControllerProvider/auth_controller_provider.dart';
import '/utils/exports.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final authenticationProvider = AuthenticationControllerProvider();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(WSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: WSizes.spaceBtwSections),
                Image(
                  height: 100,
                  image: AssetImage(
                    dark ? WImages.lightAppLogo : WImages.lightAppLogo,
                  ),
                ),
                const SizedBox(height: WSizes.spaceBtwSections),
                //title
                Text(
                  WTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Column(
                  children: [
                    const SizedBox(height: WSizes.spaceBtwSections),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            prefixIcon: Iconsax.user,
                            controller: _firstName,
                            hintText: WTexts.firstName,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return authenticationProvider.validateBlankField(
                                value!,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: WSizes.spaceBtwInputFields),
                        Expanded(
                          child: AppTextFormField(
                            prefixIcon: Iconsax.user,
                            controller: _lastName,
                            hintText: WTexts.lastName,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return authenticationProvider.validateBlankField(
                                value!,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: WSizes.spaceBtwInputFields),
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
                    AppTextFormField(
                      prefixIcon: Iconsax.mobile,
                      controller: _phone,
                      hintText: WTexts.phoneNo,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return authenticationProvider.mobileNumberValidator(
                          value!,
                        );
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
                          onChanged: (newPasswordValue) {
                            auth.passwordValue = newPasswordValue;
                          },

                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            } else {
                              //call function to check password
                              bool result = authenticationProvider
                                  .validatePasswordNew(value);

                              if (result) {
                                // create account event
                                return null;
                              } else {
                                return " Password should contain capital, small letter & number & symbol";
                              }
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: WSizes.spaceBtwInputFields),

                    Consumer<AuthenticationControllerProvider>(
                      builder: (context, auth, child) {
                        return AppTextFormField(
                          prefixIcon: Iconsax.password_check,
                          controller: _confirmPassword,
                          hintText: WTexts.confirmPassword,
                          suffixIcon:
                              auth.obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                          suffixIconOnPressed: () {
                            auth.obscureConfirmPassword =
                                !auth.obscureConfirmPassword;
                          },
                          obscureText: auth.obscureConfirmPassword,
                          validator: (value) {
                            return auth.validateConfirmPassword(value!);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: WSizes.spaceBtwSections),
                    //term and condition
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(value: true, onChanged: (value) {}),
                        ),
                        const SizedBox(height: WSizes.spaceBtwItems),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${WTexts.iAgreeTo} ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: WTexts.privacyPolicy,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.apply(
                                  color: dark ? WColors.white : WColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      dark ? WColors.white : WColors.primary,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () async {
                                        String websitelink =
                                            'https://webprologic.com/';
                                        if (await canLaunchUrlString(
                                          websitelink,
                                        )) {
                                          launchUrlString(
                                            websitelink,
                                            mode: LaunchMode.inAppWebView,
                                          );
                                        }
                                      },
                              ),
                              TextSpan(
                                text: ' ${WTexts.and} ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: WTexts.termsOfUse,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium!.apply(
                                  color: dark ? WColors.white : WColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      dark ? WColors.white : WColors.primary,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () async {
                                        String websitelink =
                                            'https://webprologic.com/contact';
                                        if (await canLaunchUrlString(
                                          websitelink,
                                        )) {
                                          launchUrlString(
                                            websitelink,
                                            mode: LaunchMode.inAppWebView,
                                          );
                                        }
                                      },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: WSizes.spaceBtwSections),
                    // Sign up Button
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
                          text: WTexts.createAccount,
                          ontap: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await auth.register(
                                  name:
                                      "${_firstName.text.trim()} ${_lastName.text.trim()}",
                                  email: _email.text.trim(),
                                  mobileNumber: _phone.text.trim(),
                                  password: _password.text.trim(),
                                  confirmPassword: _confirmPassword.text.trim(),
                                );

                                // Navigate to sign up
                                PageNavigator(
                                  // ignore: use_build_context_synchronously
                                  ctx: context,
                                ).nextPageOnly(page: const LoginScreen());
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

                    //social media button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          PageNavigator(
                            ctx: context,
                          ).nextPageOnly(page: const LoginScreen());
                        },
                        child: Text(WTexts.signIn),
                      ),
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
