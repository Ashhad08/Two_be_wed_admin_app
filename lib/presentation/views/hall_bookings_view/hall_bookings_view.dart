import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:two_be_wedd/utils/extensions.dart';

import '../../../configs/front_end_configs.dart';
import '../../elements/drawer.dart';

class HallBookingsView extends StatelessWidget {
  const HallBookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Hall Bookings")),
      drawer: const MyDrawer(),
      body: ListView.builder(
          padding: FrontEndConfigs.kAllSidePadding,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const CircleAvatar(),
                    title: const Text("Ashhad"),
                    subtitle: const Text("0225382992"),
                    trailing: OutlinedButton.icon(
                        onPressed: () {},
                        label: const Text("Confirm"),
                        icon: const FaIcon(
                          FontAwesomeIcons.check,
                          size: 18,
                        )),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Booking on: ",
                              style: context.textTheme.bodyLarge,
                            ),
                            Text(
                              "20 july 2023 10:30 AM",
                              style: context.textTheme.bodySmall!
                                  .copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                        5.sH,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 8,
                            children: [
                              ChoiceChip(
                                padding: EdgeInsets.zero,
                                label: const Text("DJ"),
                                onSelected: (val) {},
                                selected: index / 2 == 0,
                              ),
                              ChoiceChip(
                                padding: EdgeInsets.zero,
                                label: const Text("Photography"),
                                onSelected: (val) {},
                                selected: index / 3 == 0,
                              ),
                              ChoiceChip(
                                padding: EdgeInsets.zero,
                                label: const Text("Catering"),
                                onSelected: (val) {},
                                selected: true,
                              ),
                              ChoiceChip(
                                label: const Text("Stage and Hall decoration"),
                                padding: EdgeInsets.zero,
                                onSelected: (val) {},
                                selected: index / 2 == 0,
                              ),
                            ],
                          ),
                        ),
                        10.sH,
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
