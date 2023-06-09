import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd/utils/extensions.dart';

import '../../../../../configs/front_end_configs.dart';
import '../../../../../infrastructure/models/admin_model.dart';
import '../../../../../infrastructure/providers/loading_helper.dart';
import '../../../../../infrastructure/services/admin_services.dart';
import '../../../../../infrastructure/services/auth_services.dart';
import '../../../../../utils/navigation_helper.dart';
import '../../../../../utils/utils.dart';
import '../../../../elements/app_text_field.dart';
import '../../../add_hall_view/add_hall_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
            Text(
              'New\nAccount',
              style: context.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            30.sH,
            Text(
              'Enter your Name',
              style: context.textTheme.titleMedium,
            ),
            8.sH,
            AppTextField(
              hint: 'Name Here',
              controller: _nameController,
              textInputType: TextInputType.name,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter Your Name';
                }
                return null;
              },
            ),
            15.sH,
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
                    'SignUp',
                  ),
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      await _registerAdmin(context: context);
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

  Future<void> _registerAdmin({
    required BuildContext context,
  }) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    loadingProvider.stateStatus(StateStatus.IsBusy);
    AuthServices()
        .register(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            context: context)
        .then((user) async {
      String? userToken;
      await FirebaseMessaging.instance.getToken().then((token) {
        debugPrint('Current Device Token is : $token');
        userToken = token;
      }).then((value) async {
        await AdminServices()
            .registerAdmin(
                adminModel: AdminModel(
                  id: user!.user!.uid,
                  name: _nameController.text.trim(),
                  notificationToken: userToken ?? "",
                  email: _emailController.text.trim(),
                ),
                context: context)
            .then((value) {
          loadingProvider.stateStatus(StateStatus.IsFree);
          NavigationHelper.pushReplacement(context, const AddHallView());
        }).onError((error, stackTrace) {
          loadingProvider.stateStatus(StateStatus.IsError);
          Utils.showSnackBar(
              context: context,
              message:
                  error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
              color: Theme.of(context).colorScheme.error);
        });
      });
    });
  }
}
