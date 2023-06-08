import 'package:flutter/material.dart';
import 'package:two_be_wedd/configs/front_end_configs.dart';
import 'package:two_be_wedd/utils/extensions.dart';

class PickImageSheet extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  const PickImageSheet(
      {super.key, required this.onCamera, required this.onGallery});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FrontEndConfigs.kAllSidePadding,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 130,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: onCamera,
                child: const Icon(
                  Icons.camera_alt,
                  size: 30,
                ),
              ),
            ),
          ),
          10.sW,
          Expanded(
            child: SizedBox(
              height: 130,
              child: ElevatedButton(
                onPressed: onGallery,
                style: ElevatedButton.styleFrom(
                    foregroundColor: context.colorScheme.onPrimary,
                    backgroundColor: context.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Icon(
                  Icons.photo_rounded,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
