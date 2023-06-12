import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd/infrastructure/models/extra_service.dart';
import 'package:two_be_wedd/infrastructure/models/hall_model.dart';
import 'package:two_be_wedd/infrastructure/services/admin_services.dart';
import 'package:two_be_wedd/presentation/elements/custom_image.dart';
import 'package:two_be_wedd/presentation/views/dashboard_view/dashboard_view.dart';
import 'package:two_be_wedd/utils/extensions.dart';
import 'package:two_be_wedd/utils/utils.dart';

import '../../../configs/front_end_configs.dart';
import '../../../infrastructure/providers/hall_images_provider.dart';
import '../../../infrastructure/providers/loading_helper.dart';
import '../../../utils/navigation_helper.dart';
import '../../elements/app_text_field.dart';
import '../../elements/loading_overlay.dart';
import '../../elements/pick_images_sheet.dart';

class AddHallView extends StatefulWidget {
  const AddHallView({Key? key}) : super(key: key);

  @override
  State<AddHallView> createState() => _AddHallViewState();
}

class _AddHallViewState extends State<AddHallView> {
  final _key = GlobalKey<FormState>();

  final TextEditingController _hallNameController = TextEditingController();
  final TextEditingController _hallDescriptionController =
      TextEditingController();
  final TextEditingController _hallBudgetController = TextEditingController();
  final TextEditingController _hallCapacityController = TextEditingController();
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
  void dispose() {
    _hallNameController.dispose();
    _hallDescriptionController.dispose();
    _hallBudgetController.dispose();
    _hallCapacityController.dispose();
    _hallAddressController.dispose();
    _hallPhoneNumberController.dispose();
    _dJBudgetController.dispose();
    _photographyBudgetController.dispose();
    _cateringBudgetController.dispose();
    _decorationBudgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hallImages = context.watch<HallImagesProvider>();
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: CustomLoadingOverlay(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Add Hall',
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
                                          await hallImages.hallThirdImage(
                                              context,
                                              source: ImageSource.camera);
                                        }, onGallery: () async {
                                          Navigator.pop(context);
                                          await hallImages.hallThirdImage(
                                              context,
                                              source: ImageSource.gallery);
                                        }));
                              },
                              child: hallImages.thirdImageLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : hallImages.thirdImage != null
                                      ? CustomImage(
                                          image: hallImages.thirdImage!)
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
                        width: context.screenWidth * 0.5,
                        height: 50,
                        child: ElevatedButton(
                          child: const Text(
                            'Add Hall',
                          ),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              await _addHall(context);
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
      ),
    );
  }

  Future<void> _addHall(BuildContext context) async {
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
          .addHall(
              hallModel: HallModel(
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
        NavigationHelper.pushReplacement(context,const DashboardView());
        Utils.showSnackBar(context: context, message: "Welcome");
      }).onError((error, stackTrace) {
        loadingProvider.stateStatus(StateStatus.IsError);
        Utils.showSnackBar(
            context: context,
            message: error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
            color: Theme.of(context).colorScheme.error);
      });
    }
  }
}
