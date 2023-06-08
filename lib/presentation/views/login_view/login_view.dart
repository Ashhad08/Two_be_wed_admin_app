import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:two_be_wedd/configs/front_end_configs.dart';
import 'package:two_be_wedd/utils/extensions.dart';

import '../../../utils/navigation_helper.dart';
import '../../elements/app_text_field.dart';
import '../add_hall_view/add_hall_view.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: context.colorScheme.primary,
                pinned: context.orientation == Orientation.portrait,
                expandedHeight: context.orientation == Orientation.landscape
                    ? context.screenWidth * 0.2
                    : context.screenHeight * 0.25,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  expandedTitleScale: 1.1,
                  title: Text(
                    "Login to your account",
                    style: context.textTheme.headlineSmall!
                        .copyWith(color: Colors.white),
                  ),
                  background: Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        bottom: context.orientation == Orientation.landscape
                            ? context.screenWidth * 0.04
                            : context.screenHeight * 0.1,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            "assets/images/app_logo.png",
                          ),
                          backgroundColor: Colors.white,
                        ),
                      )),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: context.orientation == Orientation.landscape
                      ? context.screenWidth * 0.65
                      : context.screenHeight * 0.9,
                  width: double.infinity,
                  child: Form(
                    key: _key,
                    child: Padding(
                      padding: FrontEndConfigs.kAllSidePadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.sH,
                          Text('Welcome Back',
                              style: context.textTheme.titleLarge),
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
                                  foregroundColor:
                                      context.colorScheme.onPrimary,
                                  backgroundColor: context.colorScheme.primary,
                                ),
                                child: const Text(
                                  'Login',
                                ),
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    NavigationHelper.pushReplacement(
                                        context, const AddHallView());
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
