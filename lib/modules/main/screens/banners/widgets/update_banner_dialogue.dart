import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oonique/constants/api_endpoints.dart';
import 'package:oonique/modules/main/screens/banners/models/add_banner_input.dart';
import 'package:oonique/modules/main/screens/banners/models/get_banners_response.dart';
import 'package:oonique/modules/main/screens/banners/repositories/repo.dart';
import 'package:oonique/ui/input/input_field.dart';
import 'package:oonique/ui/widgets/custom_dropdown.dart';
import 'package:oonique/ui/widgets/helper_function.dart';
import 'package:oonique/ui/widgets/picture_widget.dart';
import 'package:oonique/ui/widgets/primary_button.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../../../../config/routes/nav_router.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../generated/assets.dart';

class UpdateBannerDialogue extends StatefulWidget {
  const UpdateBannerDialogue({super.key, this.model});
  final BannersModel? model;

  @override
  State<UpdateBannerDialogue> createState() => _UpdateBannerDialogueState();
}

class _UpdateBannerDialogueState extends State<UpdateBannerDialogue> {
  int? bannerId;
  bool? status;
  Uint8List? fileBytes;
  String? imageLink;
  String? fileName;
  final TextEditingController titleController = TextEditingController(),
      subTitleController = TextEditingController(),
      descriptionController = TextEditingController(),
      bannerLinkController = TextEditingController(),
      displayNumberController = TextEditingController();

  @override
  void initState() {
    if (widget.model != null) {
      final banner = widget.model;
      bannerId = banner?.id ?? -1;
      titleController.text = banner?.title ?? "";
      subTitleController.text = banner?.subTitle ?? "";
      descriptionController.text = banner?.description ?? "";
      displayNumberController.text = banner?.displayOrder.toString() ?? "";
      bannerLinkController.text = banner?.bannerLink ?? "";
      imageLink = "${Endpoints.imageBaseUrl}${banner!.image}";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Container(
        padding: EdgeInsets.all(14.0),
        width:
            MediaQuery.of(context).size.width >= 1100
                ? MediaQuery.of(context).size.width * 0.4
                : MediaQuery.of(context).size.width >= 850
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width >= 650
                ? MediaQuery.of(context).size.width * 0.6
                : MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.model != null ? "Update Banner" : "Add Banner",
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            PictureWidget(
              height: 150,
              width: 180,
              isEditable: true,
              radius: 12.0,
              onTap: () async {
                var result = await pickImageFileWeb();
                setState(() {
                  fileBytes = result!["bytes"];
                  fileName = result["fileName"];
                });
              },
              imageUrl: widget.model != null ? imageLink! : Assets.pngSaveImage,
              imageBytes: fileBytes,
              errorPath: Assets.pngImageNotFound,
            ),
            SizedBox(height: 8.0),
            Text(
              "Title",
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6.0),
            InputField(
              controller: titleController,
              label: "Title",
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 8.0),
            Text(
              "Description",
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6.0),
            InputField(
              controller: descriptionController,
              label: "Description",
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 8.0),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Sub Title",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      InputField(
                        controller: subTitleController,
                        label: "Sub Title",
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Banner Link",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      InputField(
                        controller: bannerLinkController,
                        label: "Banner Link",
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      CustomDropDown(
                        height: 60.0,
                        hint: "Select Status",
                        items: ["Active", "InActive"],
                        onSelect: (v) {
                          if (v == "Active") {
                            status = true;
                          } else {
                            status = false;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Display Order",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      InputField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: displayNumberController,
                        label: "Display OrderTitle",
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    height: 40.0,
                    hMargin: 0,
                    onPressed: () async {
                      AddBannerInput input = AddBannerInput(
                        title: titleController.text,
                        subTitle: subTitleController.text,
                        description: descriptionController.text,
                        bannerLink: bannerLinkController.text,
                        displayOrder: displayNumberController.text,
                        status: status.toString(),
                      );
                      if (fileBytes != null) {
                        input.file = MultipartFile.fromBytes(
                          fileBytes!,
                          filename: "image.png",
                        );
                        print(input.file!.filename);
                      }
                      if (bannerId != null) {
                        input.id = bannerId;
                      }
                      print(input.toJson());

                      BannersRepository _repo = sl<BannersRepository>();

                      await _repo.addUpdateBanner(input);
                    },
                    title: widget.model != null ? "Update" : "Save",
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: PrimaryOutlineButton(
                    onPressed: () {
                      NavRouter.pop(context);
                    },
                    backgroundColor: Colors.transparent,
                    height: 40.0,
                    borderColor: Color(0xffEA6055),
                    width: 2.0,
                    titleColor: Color(0xffEA6055),
                    title: "Cancel",
                    hMargin: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
