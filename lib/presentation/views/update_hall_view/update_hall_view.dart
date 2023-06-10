import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd/infrastructure/models/hall_model.dart';
import 'package:two_be_wedd/presentation/elements/loading_overlay.dart';
import 'package:two_be_wedd/utils/extensions.dart';

import '../../../configs/front_end_configs.dart';
import '../../../infrastructure/models/extra_service.dart';
import '../../../infrastructure/providers/hall_images_provider.dart';
import '../../../infrastructure/providers/loading_helper.dart';
import '../../../infrastructure/services/admin_services.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_image.dart';
import '../../elements/pick_images_sheet.dart';

class UpdateHallView extends StatefulWidget {
  const UpdateHallView({Key? key, required this.hall}) : super(key: key);
  final HallModel hall;

  @override
  State<UpdateHallView> createState() => _UpdateHallViewState();
}

class _UpdateHallViewState extends State<UpdateHallView> {
  final _key = GlobalKey<FormState>();

  TextEditingController _hallNameController = TextEditingController();
  TextEditingController _hallDescriptionController = TextEditingController();
  TextEditingController _hallBudgetController = TextEditingController();
  TextEditingController _hallCapacityController = TextEditingController();
  TextEditingController _hallAddressController = TextEditingController();
  TextEditingController _hallPhoneNumberController = TextEditingController();
  TextEditingController _dJBudgetController = TextEditingController();
  TextEditingController _photographyBudgetController = TextEditingController();
  TextEditingController _cateringBudgetController = TextEditingController();
  TextEditingController _decorationBudgetController = TextEditingController();

  bool _isDJOffered = false;
  bool _isPhotographyOffered = false;
  bool _isCateringOffered = false;
  bool _isDecorationOffered = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final hallImages =
          Provider.of<HallImagesProvider>(context, listen: false);
      hallImages.firstImage = widget.hall.firstImage!;
      hallImages.secondImage = widget.hall.secondImage!;
      hallImages.thirdImage = widget.hall.thirdImage!;
      hallImages.fourthImage = widget.hall.fourthImage!;
      _hallNameController = TextEditingController(text: widget.hall.name);
      _hallDescriptionController =
          TextEditingController(text: widget.hall.description);
      _hallBudgetController =
          TextEditingController(text: widget.hall.budget.toString());
      _hallCapacityController =
          TextEditingController(text: widget.hall.capacity.toString());
      _hallAddressController = TextEditingController(text: widget.hall.address);
      _hallPhoneNumberController =
          TextEditingController(text: widget.hall.phoneNumber.toString());
      if (widget.hall.extraServices!
          .where((element) => element.name == "DJ")
          .isNotEmpty) {
        _isDJOffered = true;
        _dJBudgetController = TextEditingController(
            text: widget.hall.extraServices!
                .where((element) => element.name == "DJ")
                .first
                .budget
                .toString());
      }
      if (widget.hall.extraServices!
          .where((element) => element.name == "Photography")
          .isNotEmpty) {
        _isPhotographyOffered = true;
        _photographyBudgetController = TextEditingController(
            text: widget.hall.extraServices!
                .where((element) => element.name == "Photography")
                .first
                .budget
                .toString());
      }
      if (widget.hall.extraServices!
          .where((element) => element.name == "Catering")
          .isNotEmpty) {
        _isCateringOffered = true;
        _cateringBudgetController = TextEditingController(
            text: widget.hall.extraServices!
                .where((element) => element.name == "Catering")
                .first
                .budget
                .toString());
      }
      if (widget.hall.extraServices!
          .where((element) => element.name == "Stage and Hall decoration")
          .isNotEmpty) {
        _isDecorationOffered = true;
        _decorationBudgetController = TextEditingController(
            text: widget.hall.extraServices!
                .where((element) => element.name == "Stage and Hall decoration")
                .first
                .budget
                .toString());
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final hallImages = context.watch<HallImagesProvider>();
    return CustomLoadingOverlay(
      child: Scaffold(
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
                            builder: (context) =>
                                PickImageSheet(onCamera: () async {
                                  Navigator.pop(context);
                                  await hallImages.hallFirstImage(context,
                                      source: ImageSource.camera);
                                }, onGallery: () async {
                                  Navigator.pop(context);
                                  await hallImages.hallFirstImage(context,
                                      source: ImageSource.gallery);
                                }));
                      },
                      child: hallImages.firstImageLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : hallImages.firstImage != null
                              ? CustomImage(image: hallImages.firstImage!)
                              : const FaIcon(FontAwesomeIcons.fileImage),
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
                                  builder: (context) =>
                                      PickImageSheet(onCamera: () async {
                                        Navigator.pop(context);
                                        await hallImages.hallSecondImage(
                                            context,
                                            source: ImageSource.camera);
                                      }, onGallery: () async {
                                        Navigator.pop(context);
                                        await hallImages.hallSecondImage(
                                            context,
                                            source: ImageSource.gallery);
                                      }));
                            },
                            child: hallImages.secondImageLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : hallImages.secondImage != null
                                    ? CustomImage(
                                        image: hallImages.secondImage!)
                                    : const FaIcon(FontAwesomeIcons.plus),
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
                                  builder: (context) =>
                                      PickImageSheet(onCamera: () async {
                                        Navigator.pop(context);
                                        await hallImages.hallThirdImage(context,
                                            source: ImageSource.camera);
                                      }, onGallery: () async {
                                        Navigator.pop(context);
                                        await hallImages.hallThirdImage(context,
                                            source: ImageSource.gallery);
                                      }));
                            },
                            child: hallImages.thirdImageLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : hallImages.thirdImage != null
                                    ? CustomImage(image: hallImages.thirdImage!)
                                    : const FaIcon(FontAwesomeIcons.plus),
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
                                  builder: (context) =>
                                      PickImageSheet(onCamera: () async {
                                        Navigator.pop(context);
                                        await hallImages.hallFourthImage(
                                            context,
                                            source: ImageSource.camera);
                                      }, onGallery: () async {
                                        Navigator.pop(context);
                                        await hallImages.hallFourthImage(
                                            context,
                                            source: ImageSource.gallery);
                                      }));
                            },
                            child: hallImages.fourthImageLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : hallImages.fourthImage != null
                                    ? CustomImage(
                                        image: hallImages.fourthImage!)
                                    : const FaIcon(FontAwesomeIcons.plus),
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
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            await _updateHall(context);
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
    );
  }

  Future<void> _updateHall(BuildContext context) async {
    final hallImages = Provider.of<HallImagesProvider>(context, listen: false);
    if (hallImages.firstImage == null ||
        hallImages.secondImage == null ||
        hallImages.thirdImage == null ||
        hallImages.fourthImage == null) {
      Utils.showSnackBar(
          context: context,
          message: "Kindly Select all images",
          color: context.colorScheme.error);
    } else {
      final loadingProvider =
          Provider.of<LoadingHelper>(context, listen: false);

      loadingProvider.stateStatus(StateStatus.IsBusy);
      List<ExtraService> extraServices = [];
      if (_isDecorationOffered) {
        extraServices.add(ExtraService(
            name: "Stage and Hall decoration",
            budget: num.parse(_decorationBudgetController.text.trim())));
      }
      if (_isCateringOffered) {
        extraServices.add(ExtraService(
            name: "Catering",
            budget: num.parse(_cateringBudgetController.text.trim())));
      }
      if (_isDJOffered) {
        extraServices.add(ExtraService(
            name: "DJ", budget: num.parse(_dJBudgetController.text.trim())));
      }
      if (_isPhotographyOffered) {
        extraServices.add(ExtraService(
            name: "Photography",
            budget: num.parse(_photographyBudgetController.text.trim())));
      }
      await AdminServices()
          .updateHall(
              hallModel: HallModel(
                  hallId: widget.hall.hallId!,
                  name: _hallNameController.text.trim(),
                  description: _hallDescriptionController.text.trim(),
                  budget: num.parse(_hallBudgetController.text.trim()),
                  capacity: num.parse(_hallCapacityController.text.trim()),
                  address: _hallAddressController.text.trim(),
                  phoneNumber: _hallPhoneNumberController.text.trim(),
                  firstImage: hallImages.firstImage!,
                  secondImage: hallImages.secondImage!,
                  thirdImage: hallImages.thirdImage!,
                  fourthImage: hallImages.fourthImage!,
                  extraServices: extraServices,
                  adminId: FirebaseAuth.instance.currentUser!.uid),
              context: context)
          .then((value) {
        loadingProvider.stateStatus(StateStatus.IsFree);
        Navigator.pop(context);
        Utils.showSnackBar(
            context: context, message: "Hall Information Changed Successfully");
      }).onError((error, stackTrace) {
        loadingProvider.stateStatus(StateStatus.IsError);
        debugPrint(stackTrace.toString());
        Utils.showSnackBar(
            context: context,
            message: error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
            color: Theme.of(context).colorScheme.error);
      });
    }
  }
}
