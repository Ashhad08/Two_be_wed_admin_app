import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:two_be_wedd/presentation/elements/loading_overlay.dart';
import 'package:two_be_wedd/utils/extensions.dart';

import 'widgets/login_view/login_view.dart';
import 'widgets/sign_up_view/sign_up_view.dart';

class AdminAuthView extends StatelessWidget {
  const AdminAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: CustomLoadingOverlay(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: context.colorScheme.primary,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    expandedHeight: context.orientation == Orientation.landscape
                        ? context.screenWidth * 0.2
                        : context.screenHeight * 0.25,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.zero,
                      centerTitle: true,
                      expandedTitleScale: 1.1,
                      title: TabBar(
                        unselectedLabelStyle: context.textTheme.titleMedium,
                        labelStyle: context.textTheme.titleLarge,
                        labelColor: context.theme.cardColor,
                        unselectedLabelColor:
                            context.theme.cardColor.withOpacity(0.7),
                        indicatorColor: context.theme.scaffoldBackgroundColor,
                        indicatorWeight: 3,
                        tabs: const [
                          Tab(
                            text: 'Login',
                          ),
                          Tab(
                            text: 'SignUp',
                          ),
                        ],
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
                          ? context.screenWidth * 0.85
                          : context.screenHeight * 0.9,
                      width: double.infinity,
                      child: const TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          LoginView(),
                          SignUpView(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
