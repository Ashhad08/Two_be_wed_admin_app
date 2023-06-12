import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd/utils/extensions.dart';

import '../../../configs/front_end_configs.dart';
import '../../../infrastructure/models/hall_booking_model.dart';
import '../../../infrastructure/models/hall_model.dart';
import '../../../infrastructure/models/user_model.dart';
import '../../../infrastructure/services/system_services.dart';
import '../../elements/drawer.dart';

class ConfirmedOrdersView extends StatelessWidget {
  ConfirmedOrdersView({Key? key}) : super(key: key);
  final SystemServices _systemServices = SystemServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Confirmed Orders")),
        drawer: const MyDrawer(),
        // body: StreamProvider.value(
        //     value: _systemServices.fetchCurrentAdminHall(),
        //     initialData: HallModel(),
        //     builder: (context, snapshot) {
        //       final hallModel = context.watch<HallModel>();
        //       return hallModel.hallId == null || hallModel.hallId!.isEmpty
        //           ? const Center(
        //               child: CircularProgressIndicator(),
        //             )
        //           : StreamProvider.value(
        //               value: _systemServices
        //                   .fetchCurrentAdminConfirmOrders(hallModel.hallId ?? ""),
        //               initialData: [HallBookingModel()],
        //               builder: (context, snapshot) {
        //                 final List<HallBookingModel> confirmedBookings =
        //                     context.watch<List<HallBookingModel>>();
        //                 return confirmedBookings.isEmpty
        //                     ? const Center(
        //                         child: Text("No Confirmed orders"),
        //                       )
        //                     : confirmedBookings[0].hallId == null
        //                         ? const Center(
        //                             child: CircularProgressIndicator(),
        //                           )
        //                         : ListView.builder(
        //                             padding: FrontEndConfigs.kAllSidePadding,
        //                             itemCount: 3,
        //                             itemBuilder: (context, index) {
        //                               return Card(
        //                                 child: Column(
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: [
        //                                     ListTile(
        //                                       leading: const CircleAvatar(),
        //                                       title: const Text("Ashhad"),
        //                                       subtitle: const Text("0225382992"),
        //
        //                                       /// If the Event time/ booking time is passed show event as done/completed else pending
        //                                       /// also show this list in decending order
        //                                       trailing: index / 2 == 0
        //                                           ? FaIcon(
        //                                               FontAwesomeIcons.clock,
        //                                               color: context
        //                                                   .colorScheme.primary,
        //                                             )
        //                                           : FaIcon(
        //                                               FontAwesomeIcons
        //                                                   .checkDouble,
        //                                               color: context
        //                                                   .colorScheme.primary,
        //                                             ),
        //                                     ),
        //                                     const Divider(),
        //                                     Padding(
        //                                       padding: const EdgeInsets.symmetric(
        //                                           horizontal: 18),
        //                                       child: Column(
        //                                         children: [
        //                                           Row(
        //                                             children: [
        //                                               Text(
        //                                                 "Booking on: ",
        //                                                 style: context
        //                                                     .textTheme.bodyLarge,
        //                                               ),
        //                                               Text(
        //                                                 "20 july 2023 10:30 AM",
        //                                                 style: context
        //                                                     .textTheme.bodySmall!
        //                                                     .copyWith(
        //                                                         fontSize: 13),
        //                                               ),
        //                                             ],
        //                                           ),
        //                                           5.sH,
        //                                           Align(
        //                                             alignment:
        //                                                 Alignment.centerLeft,
        //                                             child: Wrap(
        //                                               spacing: 8,
        //                                               children: [
        //                                                 ChoiceChip(
        //                                                   padding:
        //                                                       EdgeInsets.zero,
        //                                                   label: const Text("DJ"),
        //                                                   onSelected: (val) {},
        //                                                   selected:
        //                                                       index / 2 == 0,
        //                                                 ),
        //                                                 ChoiceChip(
        //                                                   padding:
        //                                                       EdgeInsets.zero,
        //                                                   label: const Text(
        //                                                       "Photography"),
        //                                                   onSelected: (val) {},
        //                                                   selected:
        //                                                       index / 3 == 0,
        //                                                 ),
        //                                                 ChoiceChip(
        //                                                   padding:
        //                                                       EdgeInsets.zero,
        //                                                   label: const Text(
        //                                                       "Catering"),
        //                                                   onSelected: (val) {},
        //                                                   selected: true,
        //                                                 ),
        //                                                 ChoiceChip(
        //                                                   label: const Text(
        //                                                       "Stage and Hall decoration"),
        //                                                   padding:
        //                                                       EdgeInsets.zero,
        //                                                   onSelected: (val) {},
        //                                                   selected:
        //                                                       index / 2 == 0,
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                           ),
        //                                           10.sH,
        //                                         ],
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               );
        //                             });
        //               });
        //     }),
        body: StreamProvider.value(
          value: _systemServices.fetchCurrentAdminHall(),
          initialData: HallModel(),
          builder: (context, child) {
            final hallModel = context.watch<HallModel>();
            return hallModel.hallId == null || hallModel.hallId!.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : StreamProvider.value(
                    value: _systemServices
                        .fetchCurrentAdminConfirmOrders(hallModel.hallId ?? ""),
                    initialData: [HallBookingModel()],
                    builder: (context, child) {
                      final List<HallBookingModel> confirmedOrders =
                          context.watch<List<HallBookingModel>>();

                      return confirmedOrders.isEmpty
                          ? Center(
                              child: Text(
                                "No Orders Confirmed yet",
                                style: context.textTheme.headlineSmall,
                              ),
                            )
                          : confirmedOrders[0].hallId == null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  padding: FrontEndConfigs.kAllSidePadding,
                                  itemCount: confirmedOrders.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          StreamProvider.value(
                                              value: _systemServices
                                                  .fetchSpecificUser(
                                                      confirmedOrders[index]
                                                              .bookedBy ??
                                                          ""),
                                              initialData: UserModel(),
                                              builder: (context, snapshot) {
                                                final user =
                                                    context.watch<UserModel>();
                                                return ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            user.profileImage ??
                                                                ""),
                                                  ),
                                                  title: Text(user.name ?? ''),
                                                  subtitle: Text(
                                                      user.phoneNumber ?? ""),
                                                  trailing: confirmedOrders[
                                                              index]
                                                          .bookingDateTime!
                                                          .toDate()
                                                          .isAfter(
                                                              DateTime.now())
                                                      ? FaIcon(
                                                          FontAwesomeIcons
                                                              .clock,
                                                          color: context
                                                              .colorScheme
                                                              .primary,
                                                        )
                                                      : FaIcon(
                                                          FontAwesomeIcons
                                                              .checkDouble,
                                                          color: context
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                );
                                              }),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Booking on: ",
                                                      style: context
                                                          .textTheme.bodyLarge,
                                                    ),
                                                    Text(
                                                      DateFormat.yMEd()
                                                          .add_jms()
                                                          .format(confirmedOrders[
                                                                  index]
                                                              .bookingDateTime!
                                                              .toDate()),
                                                      style: context
                                                          .textTheme.bodySmall!
                                                          .copyWith(
                                                              fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                                5.sH,
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Wrap(
                                                    spacing: 8,
                                                    children: confirmedOrders[
                                                            index]
                                                        .bookedExtraServices!
                                                        .map(
                                                          (e) => ChoiceChip(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            label: Text(e.name),
                                                            onSelected:
                                                                (val) {},
                                                            selected: true,
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                ),
                                                5.sH,
                                                Text(
                                                  "Total Budget : ${confirmedOrders[index].totalBudget}",
                                                  style: context
                                                      .textTheme.bodyLarge,
                                                ),
                                                10.sH,
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                    },
                  );
          },
        ));
  }
}
