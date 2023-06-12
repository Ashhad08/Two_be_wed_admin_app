import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd/configs/front_end_configs.dart';
import 'package:two_be_wedd/infrastructure/models/hall_model.dart';
import 'package:two_be_wedd/infrastructure/services/system_services.dart';
import 'package:two_be_wedd/presentation/elements/custom_image.dart';
import 'package:two_be_wedd/presentation/elements/loading_overlay.dart';
import 'package:two_be_wedd/presentation/views/admin_auth_view/admin_auth_view.dart';
import 'package:two_be_wedd/utils/extensions.dart';
import 'package:two_be_wedd/utils/navigation_helper.dart';

import '../../../infrastructure/services/admin_services.dart';
import '../../../infrastructure/services/notifications_service.dart';
import '../../../utils/utils.dart';
import '../../elements/drawer.dart';
import '../update_hall_view/update_hall_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final SystemServices _systemServices = SystemServices();

  @override
  void initState() {
    NotificationsService().notificationsClick(context);
    NotificationsService().notificationsClickTerminated(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: CustomLoadingOverlay(
        child: Scaffold(
          appBar: AppBar(
            elevation: 3,
            title: const Text("Dashboard"),
          ),
          drawer: const MyDrawer(),
          body: StreamProvider.value(
            value: _systemServices.fetchCurrentAdminHall(),
            initialData: HallModel(),
            builder: (context, child) {
              final hallModel = context.watch<HallModel>();
              return hallModel.hallId == null || hallModel.hallId!.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: FrontEndConfigs.kAllSidePadding,
                        child: Column(
                          children: [
                            HallCard(
                              hall: hallModel,
                            ),
                            20.sH,
                            Row(
                              children: [
                                StreamProvider.value(
                                    value:
                                        _systemServices.fetchNumberOfBookings(
                                            hallModel.hallId ?? ""),
                                    initialData: 0,
                                    builder: (context, child) {
                                      return Expanded(
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Total\nBookings",
                                                      style: context
                                                          .textTheme.bodyLarge,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.utensils,
                                                      color: context
                                                          .colorScheme.primary,
                                                    ),
                                                  ],
                                                ),
                                                30.sH,
                                                Text(
                                                  "${context.watch<int>()}",
                                                  style: context
                                                      .textTheme.titleLarge,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                10.sW,
                                StreamProvider.value(
                                    value: _systemServices
                                        .fetchNumberOfConfirmOrders(
                                            hallModel.hallId ?? ""),
                                    initialData: 0,
                                    builder: (context, child) {
                                      return Expanded(
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Confirmed\nOrders",
                                                        style: context.textTheme
                                                            .bodyLarge,
                                                      ),
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .calendarCheck,
                                                      color: context
                                                          .colorScheme.primary,
                                                    ),
                                                  ],
                                                ),
                                                30.sH,
                                                Text(
                                                  "${context.watch<int>()}",
                                                  style: context
                                                      .textTheme.titleLarge,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class HallCard extends StatelessWidget {
  const HallCard({
    super.key,
    required this.hall,
  });

  final HallModel hall;

  @override
  Widget build(BuildContext context) {
    final List<String> hallImages = [
      hall.firstImage ?? "",
      hall.secondImage ?? "",
      hall.thirdImage ?? "",
      hall.fourthImage ?? "",
    ];
    return ElevatedButton(
      onPressed: () {
        NavigationHelper.push(
          context,
          UpdateHallView(
            hall: hall,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
            items: hallImages.map((i) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CustomImage(image: i, fit: BoxFit.cover)),
              );
            }).toList(),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  hall.name ?? "",
                  style: context.textTheme.headlineSmall,
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Are you sure?"),
                        content: const Text(
                            "This action cannot be undone, proceed with caution.\nConfirm your decision to proceed with the deletion."),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No")),
                          TextButton(
                              onPressed: () async {
                                await _deleteHall(context);
                              },
                              child: const Text("Yes, Delete"))
                        ],
                      ),
                    );
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.trash,
                    color: context.colorScheme.error,
                    size: 18,
                  ))
            ],
          ),
          // 5.sH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Budget: ",
                    style: context.textTheme.labelLarge,
                  ),
                  Text(
                    "${hall.budget ?? 0}",
                    style: context.textTheme.bodyLarge,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Capacity: ",
                    style: context.textTheme.labelLarge,
                  ),
                  Text(
                    "${hall.capacity ?? 0}",
                    style: context.textTheme.bodyLarge,
                  ),
                ],
              )
            ],
          ),
          10.sH,
          Text(
            hall.description ?? "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Future<void> _deleteHall(BuildContext context) async {
    await AdminServices()
        .deleteHall(context: context, hallId: hall.hallId!)
        .then((value) {
      Navigator.pop(context);
      NavigationHelper.pushReplacement(context, const AdminAuthView());
    }).onError((error, stackTrace) {
      Utils.showSnackBar(
          context: context,
          message: error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
          color: Theme.of(context).colorScheme.error);
    });
  }
}
