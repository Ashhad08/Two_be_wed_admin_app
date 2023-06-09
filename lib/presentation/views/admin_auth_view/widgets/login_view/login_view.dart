import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd/infrastructure/services/admin_services.dart';
import 'package:two_be_wedd/utils/extensions.dart';

import '../../../../../configs/front_end_configs.dart';
import '../../../../../infrastructure/providers/loading_helper.dart';
import '../../../../../infrastructure/services/auth_services.dart';
import '../../../../../infrastructure/services/splash_services.dart';
import '../../../../../utils/navigation_helper.dart';
import '../../../../../utils/utils.dart';
import '../../../../elements/app_text_field.dart';
import '../../../add_hall_view/add_hall_view.dart';
import '../../../dashboard_view/dashboard_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Padding(
        padding: FrontEndConfigs.kAllSidePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.sH,
            Text('Welcome Back', style: context.textTheme.titleLarge),
            25.sH,
            Text(
              'Enter Your Email',
              style: context.textTheme.titleMedium,
            ),
            8.sH,
            AppTextField(
              hint: 'Email Here',
              controller: _emailController,
              textInputType: TextInputType.emailAddress,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter Your Email';
                }
                return null;
              },
            ),
            15.sH,
            Text(
              'Enter Your Password',
              style: context.textTheme.titleMedium,
            ),
            8.sH,
            AppTextField(
              hint: 'Password Here',
              isPasswordField: true,
              controller: _passwordController,
              maxLines: 1,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter Your Password';
                }
                return null;
              },
            ),
            30.sH,
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: context.screenWidth * 0.5,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    foregroundColor: context.colorScheme.onPrimary,
                    backgroundColor: context.colorScheme.primary,
                  ),
                  child: const Text(
                    'Login',
                  ),
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      await _login(context: context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login({
    required BuildContext context,
  }) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    loadingProvider.stateStatus(StateStatus.IsBusy);
    AuthServices()
        .login(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            context: context)
        .then((user) async {
      String? userToken;
      await FirebaseMessaging.instance.getToken().then((token) {
        debugPrint('Current Device Token is : $token');
        userToken = token;
      }).then((value) {
        AdminServices()
            .updateAdminNotificationToken(
                context: context, token: userToken, uid: user!.user!.uid)
            .then((value) async {
          bool isHallCreated = await SplashServices.isAdminCreatedHall();
          loadingProvider.stateStatus(StateStatus.IsFree);
          if (isHallCreated) {
            // ignore: use_build_context_synchronously
            NavigationHelper.pushReplacement(
              context,
              const DashboardView(),
            );
          } else {
            // ignore: use_build_context_synchronously
            NavigationHelper.pushReplacement(
              context,
              const AddHallView(),
            );
          }
        }).onError((error, stackTrace) {
          loadingProvider.stateStatus(StateStatus.IsFree);
          Utils.showSnackBar(
              context: context,
              message:
                  error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
              color: Theme.of(context).colorScheme.error);
        });
      }).onError((error, stackTrace) {
        loadingProvider.stateStatus(StateStatus.IsFree);
        Utils.showSnackBar(
            context: context,
            message: error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
            color: Theme.of(context).colorScheme.error);
      });
    }).onError((error, stackTrace) {
      Utils.showSnackBar(
          context: context,
          message: error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
          color: Theme.of(context).colorScheme.error);
    });
  }
}
