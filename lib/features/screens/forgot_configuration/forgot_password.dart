import 'package:fooddelivery/features/screens/authentication/login/login.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../controller/authControllerProvider/auth_controller_provider.dart';
import '/utils/exports.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final authenticationProvider = AuthenticationControllerProvider();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(WSizes.defaultSpace),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //headings
              Text(
                WTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: WSizes.spaceBtwItems),
              Text(
                WTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: WSizes.spaceBtwSections * 2),
              //text field
              AppTextFormField(
                prefixIcon: Iconsax.direct_right,
                controller: _email,
                hintText: WTexts.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  return authenticationProvider.emailValidate(value!);
                },
              ),
              const SizedBox(height: WSizes.spaceBtwSections),
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
                    text: WTexts.submit,
                    ontap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await auth.forgotPassword(email: _email.text.trim());
                          // ignore: use_build_context_synchronously
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
            ],
          ),
        ),
      ),
    );
  }
}
