import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd/infrastructure/services/admin_services.dart';
import 'package:two_be_wedd/presentation/elements/loading_overlay.dart';
import 'package:two_be_wedd/utils/extensions.dart';

import '../../../configs/front_end_configs.dart';
import '../../../infrastructure/models/hall_booking_model.dart';
import '../../../infrastructure/models/hall_model.dart';
import '../../../infrastructure/models/user_model.dart';
import '../../../infrastructure/providers/loading_helper.dart';
import '../../../infrastructure/services/system_services.dart';
import '../../../utils/utils.dart';
import '../../elements/drawer.dart';

class HallBookingsView extends StatelessWidget {
  HallBookingsView({Key? key}) : super(key: key);
  final SystemServices _systemServices = SystemServices();

  @override
  Widget build(BuildContext context) {
    return CustomLoadingOverlay(
      child: Scaffold(
        appBar: AppBar(title: const Text("My Hall Bookings")),
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
                : StreamProvider.value(
                    value: _systemServices
                        .fetchCurrentAdminBookings(hallModel.hallId ?? ""),
                    initialData: [HallBookingModel()],
                    builder: (context, child) {
                      final List<HallBookingModel> bookings =
                          context.watch<List<HallBookingModel>>();

                      return bookings.isEmpty
                          ? Center(
                              child: Text(
                                "No Bookings yet",
                                style: context.textTheme.headlineSmall,
                              ),
                            )
                          : bookings[0].hallId == null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  padding: FrontEndConfigs.kAllSidePadding,
                                  itemCount: bookings.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          StreamProvider.value(
                                              value: _systemServices
                                                  .fetchSpecificUser(
                                                      bookings[index]
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
                                                  trailing: OutlinedButton.icon(
                                                      onPressed: () async {
                                                        await _confirmOrder(
                                                            context,
                                                            hallName:
                                                                hallModel.name ??
                                                                    "",
                                                            bookingId: bookings[
                                                                        index]
                                                                    .bookingId ??
                                                                "",
                                                            date: bookings[
                                                                    index]
                                                                .bookingDateTime!,
                                                            token:
                                                                user.notificationToken ??
                                                                    "");
                                                      },
                                                      label:
                                                          const Text("Confirm"),
                                                      icon: const FaIcon(
                                                        FontAwesomeIcons.check,
                                                        size: 18,
                                                      )),
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
                                                          .format(bookings[
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
                                                    children: bookings[index]
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
                                                  "Total Budget : ${bookings[index].totalBudget}",
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
        ),
      ),
    );
  }

  Future<void> _confirmOrder(BuildContext context,
      {required String bookingId,
      required String token,
      required String hallName,
      required Timestamp date}) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    loadingProvider.stateStatus(StateStatus.IsBusy);

    await AdminServices()
        .confirmOrder(bookingId: bookingId, context: context)
        .then((value) async {
      await SystemServices()
          .sendPushNotification(
        token: token,
        date: DateFormat.yMEd().add_jms().format(date.toDate()),
        hallName: hallName,
      )
          .then((value) {
        loadingProvider.stateStatus(StateStatus.IsFree);
        Utils.showSnackBar(
            context: context, message: "Order Confirmed Successfully");
      }).onError((error, stackTrace) {
        loadingProvider.stateStatus(StateStatus.IsError);
        Utils.showSnackBar(
            context: context,
            message: error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
            color: Theme.of(context).colorScheme.error);
      });
    }).onError((error, stackTrace) {
      loadingProvider.stateStatus(StateStatus.IsError);
      Utils.showSnackBar(
          context: context,
          message: error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
          color: Theme.of(context).colorScheme.error);
    });
  }
}
