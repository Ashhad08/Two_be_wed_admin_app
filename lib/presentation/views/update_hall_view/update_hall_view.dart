import 'package:flutter/material.dart';
import 'package:two_be_wedd/utils/extensions.dart';

import '../../../configs/front_end_configs.dart';
import '../../elements/app_text_field.dart';
import '../../elements/pick_images_sheet.dart';

class UpdateHallView extends StatefulWidget {
  const UpdateHallView({Key? key}) : super(key: key);

  @override
  State<UpdateHallView> createState() => _UpdateHallViewState();
}

class _UpdateHallViewState extends State<UpdateHallView> {
  final _key = GlobalKey<FormState>();

  final TextEditingController _hallNameController =
      TextEditingController(text: "Deewan e Khas");
  final TextEditingController _hallDescriptionController =
      TextEditingController(
    text:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer",
  );
  final TextEditingController _hallBudgetController =
      TextEditingController(text: "5000");
  final TextEditingController _hallCapacityController =
      TextEditingController(text: "300");
  final TextEditingController _hallAddressController = TextEditingController();
  final TextEditingController _hallPhoneNumberController =
      TextEditingController();
  final TextEditingController _dJBudgetController = TextEditingController();
  final TextEditingController _photographyBudgetController =
      TextEditingController();
  final TextEditingController _cateringBudgetController =
      TextEditingController();
  final TextEditingController _decorationBudgetController =
      TextEditingController();

  bool _isDJOffered = false;
  bool _isPhotographyOffered = false;
  bool _isCateringOffered = false;
  bool _isDecorationOffered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Hall Information',
        ),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: FrontEndConfigs.kAllSidePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                    onPressed: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(18),
                            ),
                          ),
                          context: context,
                          builder: (context) => PickImageSheet(
                              onCamera: () {}, onGallery: () {}));
                    },
                    child: Image.asset("assets/images/hall_image_1.jpg"),
                  ),
                ),
                10.sH,
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(18),
                                  ),
                                ),
                                context: context,
                                builder: (context) => PickImageSheet(
                                    onCamera: () {}, onGallery: () {}));
                          },
                          child: Image.asset("assets/images/hall_image_2.jpg"),
                        ),
                      ),
                    ),
                    5.sW,
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        onPressed: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(18),
                                ),
                              ),
                              context: context,
                              builder: (context) => PickImageSheet(
                                  onCamera: () {}, onGallery: () {}));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: SizedBox(
                              height: 100,
                              child: Image.asset(
                                "assets/images/hall_image_3.jpg",
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                    5.sW,
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          onPressed: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(18),
                                  ),
                                ),
                                context: context,
                                builder: (context) => PickImageSheet(
                                    onCamera: () {}, onGallery: () {}));
                          },
                          child: Image.asset(
                            "assets/images/hall_image_4.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                20.sH,
                Text(
                  'Hall Name',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                5.sH,
                AppTextField(
                  hint: 'Enter Hall Name',
                  controller: _hallNameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter your hall name';
                    }
                    return null;
                  },
                ),
                10.sH,
                Text(
                  'Hall Budget',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                5.sH,
                AppTextField(
                  hint: 'Enter Hall Budget',
                  controller: _hallBudgetController,
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Hall Budget';
                    } else if (num.parse(val) <= 0) {
                      return 'Enter Hall Valid Budget';
                    }
                    return null;
                  },
                ),
                10.sH,
                Text(
                  'Hall Description',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                5.sH,
                AppTextField(
                  hint: 'Tell about your hall and its services',
                  controller: _hallDescriptionController,
                  maxLines: 6,
                ),
                10.sH,
                Text(
                  'Hall Capacity',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                5.sH,
                AppTextField(
                  hint: 'Enter Hall Capacity',
                  controller: _hallCapacityController,
                  textInputType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Hall Capacity';
                    } else if (num.parse(val) <= 0) {
                      return 'Enter Hall Valid Capacity';
                    }
                    return null;
                  },
                ),
                10.sH,
                Text(
                  'Hall Address',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                5.sH,
                AppTextField(
                  hint: 'Enter Hall Address',
                  controller: _hallAddressController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Hall Address';
                    }
                    return null;
                  },
                ),
                10.sH,
                Text(
                  'Hall WhatsApp Number',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                5.sH,
                AppTextField(
                  hint: 'Enter Hall WhatsApp number',
                  textInputType: TextInputType.phone,
                  controller: _hallPhoneNumberController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Hall WhatsApp number';
                    } else if (val.length < 11) {
                      return 'WhatsApp number must be 11 digits';
                    }
                    return null;
                  },
                ),
                20.sH,
                const Divider(),
                Text(
                  'Extra Services',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                CheckboxListTile(
                  value: _isDJOffered,
                  onChanged: (val) {
                    setState(() {
                      _isDJOffered = val!;
                    });
                  },
                  title: const Text("DJ"),
                ),
                _isDJOffered
                    ? ServiceBudgetField(
                        controller: _dJBudgetController,
                        validator: (val) {
                          if (val!.isEmpty && _isDJOffered) {
                            return 'Enter Dj Budget';
                          }
                          return null;
                        },
                        hint: "Budget of Dj",
                      )
                    : const SizedBox(),
                CheckboxListTile(
                  value: _isPhotographyOffered,
                  onChanged: (val) {
                    setState(() {
                      _isPhotographyOffered = val!;
                    });
                  },
                  title: const Text("Photography"),
                ),
                _isPhotographyOffered
                    ? ServiceBudgetField(
                        controller: _photographyBudgetController,
                        validator: (val) {
                          if (val!.isEmpty && _isPhotographyOffered) {
                            return 'Enter Photography Budget';
                          }
                          return null;
                        },
                        hint: "Budget of Photography",
                      )
                    : const SizedBox(),
                CheckboxListTile(
                  value: _isCateringOffered,
                  onChanged: (val) {
                    setState(() {
                      _isCateringOffered = val!;
                    });
                  },
                  title: const Text("Catering"),
                ),
                _isCateringOffered
                    ? ServiceBudgetField(
                        controller: _cateringBudgetController,
                        validator: (val) {
                          if (val!.isEmpty && _isCateringOffered) {
                            return 'Enter Catering Budget';
                          }
                          return null;
                        },
                        hint: "Budget of Catering",
                      )
                    : const SizedBox(),
                CheckboxListTile(
                  value: _isDecorationOffered,
                  onChanged: (val) {
                    setState(() {
                      _isDecorationOffered = val!;
                    });
                  },
                  title: const Text("Stage and Hall decoration"),
                ),
                _isDecorationOffered
                    ? ServiceBudgetField(
                        controller: _decorationBudgetController,
                        validator: (val) {
                          if (val!.isEmpty && _isDecorationOffered) {
                            return 'Enter Stage and Hall decoration Budget';
                          }
                          return null;
                        },
                        hint: "Budget of Stage and Hall decoration",
                      )
                    : const SizedBox(),
                30.sH,
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: context.screenWidth * 0.8,
                    height: 50,
                    child: ElevatedButton(
                      child: const Text(
                        'Update Hall Information',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          Navigator.pop(context);
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
    );
  }
}
