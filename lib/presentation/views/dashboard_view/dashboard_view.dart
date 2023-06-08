import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:two_be_wedd/configs/front_end_configs.dart';
import 'package:two_be_wedd/utils/extensions.dart';
import 'package:two_be_wedd/utils/navigation_helper.dart';

import '../../elements/drawer.dart';
import '../update_hall_view/update_hall_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          title: const Text("Dashboard"),
        ),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: FrontEndConfigs.kAllSidePadding,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    NavigationHelper.push(context, const UpdateHallView());
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: List.generate(
                                4,
                                (index) =>
                                    "assets/images/hall_image_${index + 1}.jpg")
                            .map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Card(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.asset(i, fit: BoxFit.cover)),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Deewan e Khas",
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
                                          onPressed: () {
                                            Navigator.pop(context);
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
                                "5000/Rs",
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
                                "300",
                                style: context.textTheme.bodyLarge,
                              ),
                            ],
                          )
                        ],
                      ),
                      10.sH,
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                20.sH,
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total\nBookings",
                                    style: context.textTheme.bodyLarge,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.utensils,
                                    color: context.colorScheme.primary,
                                  ),
                                ],
                              ),
                              30.sH,
                              Text(
                                "30",
                                style: context.textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    10.sW,
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Confirmed\nOrders",
                                      style: context.textTheme.bodyLarge,
                                    ),
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.calendarCheck,
                                    color: context.colorScheme.primary,
                                  ),
                                ],
                              ),
                              30.sH,
                              Text(
                                "20",
                                style: context.textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
