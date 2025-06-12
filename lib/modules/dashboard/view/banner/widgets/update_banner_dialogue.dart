import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:oonique/constants/api_endpoints.dart';
import 'package:oonique/modules/dashboard/view/banner/models/add_banner_input.dart';
import 'package:oonique/modules/dashboard/view/banner/models/get_banners_response.dart';
import 'package:oonique/ui/widgets/helper_function.dart';
import 'package:oonique/ui/widgets/picture_widget.dart';
import 'package:oonique/ui/widgets/primary_button.dart';
import 'package:oonique/utils/display/display_utils.dart';
import 'package:oonique/utils/extensions/extended_context.dart';
import '../../../../../config/routes/nav_router.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../generated/assets.dart';
import '../../../../../ui/input/custom_input_field.dart';
import '../../../../../ui/widgets/custom_dropdown_widget.dart';
import '../../../repo/repo.dart';
import '../cubit/add_update_banner_cubit/add_update_banner_cubit.dart';

class UpdateBannerDialogue extends StatefulWidget {
  const UpdateBannerDialogue({super.key, this.model, required this.onSave});
  final BannersModel? model;

  final Function(AddBannerInput) onSave;

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

  final _formKey = GlobalKey<FormState>();
  String? selectedCategory;
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
      selectedCategory = banner?.category ?? "";
      imageLink = "${Endpoints.imageBaseUrl}${banner!.image}";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      backgroundColor: AppColors.dialogBgColor,
      child: BlocProvider(
        create: (context) =>
            AddUpdateBannerCubit(bannersRepository: sl<BannersRepository>())
              ..getCategories(),
        child: Container(
          width: 515,
          padding:
              const EdgeInsets.only(top: 23.0, left: 20, right: 20, bottom: 20),
          decoration: BoxDecoration(
            color: AppColors.dialogBgColor,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColors.borderColor, width: 1.0),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: BlocBuilder<AddUpdateBannerCubit, AddUpdateBannerState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.model != null ? "Update Banner" : "Add Banner",
                          style: context.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
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
                        imageUrl: widget.model != null
                            ? imageLink!
                            : Assets.pngSaveImage,
                        imageBytes: fileBytes,
                        errorPath: Assets.pngImageNotFound,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Title",
                        style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
                      SizedBox(height: 6.0),
                      CustomInputField(
                        titleSize: 13,
                        horizontalPadding: 8,
                        hintColor: AppColors.titlaTextColor,
                        textColor: AppColors.white,
                        focusBorderColor: AppColors.borderColor,
                        controller: titleController,
                        textInputAction: TextInputAction.done,
                        label: 'Title',
                        borderColor: AppColors.borderColor,
                        borderRadius: 3,
                        fillColor: AppColors.dialogBgColor,
                        boxConstraints: 10,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Description",
                        style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
                      SizedBox(height: 6.0),
                      CustomInputField(
                        titleSize: 13,
                        horizontalPadding: 8,
                        hintColor: AppColors.titlaTextColor,
                        textColor: AppColors.white,
                        focusBorderColor: AppColors.borderColor,
                        controller: descriptionController,
                        textInputAction: TextInputAction.done,
                        label: 'Description',
                        borderColor: AppColors.borderColor,
                        borderRadius: 3,
                        fillColor: AppColors.dialogBgColor,
                        boxConstraints: 10,
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                                SizedBox(height: 6.0),
                                CustomInputField(
                                  titleSize: 13,
                                  horizontalPadding: 8,
                                  hintColor: AppColors.titlaTextColor,
                                  textColor: AppColors.white,
                                  focusBorderColor: AppColors.borderColor,
                                  controller: subTitleController,
                                  textInputAction: TextInputAction.done,
                                  label: 'Sub Title',
                                  borderColor: AppColors.borderColor,
                                  borderRadius: 3,
                                  fillColor: AppColors.dialogBgColor,
                                  boxConstraints: 10,
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                                SizedBox(height: 6.0),
                                CustomInputField(
                                  titleSize: 13,
                                  horizontalPadding: 8,
                                  hintColor: AppColors.titlaTextColor,
                                  textColor: AppColors.white,
                                  focusBorderColor: AppColors.borderColor,
                                  controller: bannerLinkController,
                                  textInputAction: TextInputAction.next,
                                  label: 'Banner Link',
                                  borderColor: AppColors.borderColor,
                                  borderRadius: 3,
                                  fillColor: AppColors.dialogBgColor,
                                  boxConstraints: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Category",
                            style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                          ),
                          SizedBox(height: 6.0),
                          CustomDropdownWidget(
                            items: state.categories?.uniqueValues ?? [],
                            onChanged: (v) {
                              selectedCategory = v;
                            },
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                                SizedBox(height: 6.0),
                                CustomDropdownWidget(
                                  items: ["Active", "InActive"],
                                  onChanged: (v) {
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                                SizedBox(height: 6.0),
                                CustomInputField(
                                  titleSize: 13,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  horizontalPadding: 8,
                                  hintColor: AppColors.titlaTextColor,
                                  textColor: AppColors.white,
                                  focusBorderColor: AppColors.borderColor,
                                  controller: displayNumberController,
                                  textInputAction: TextInputAction.done,
                                  label: 'Display OrderTitle',
                                  borderColor: AppColors.borderColor,
                                  borderRadius: 3,
                                  fillColor: AppColors.dialogBgColor,
                                  boxConstraints: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PrimaryButton(
                            onPressed: () {
                              NavRouter.pop(context);
                            },
                            hMargin: 0,
                            vMargin: 0,
                            title: 'Cancel',
                            backgroundColor: AppColors.dialogBgColor,
                            bborderColor: AppColors.borderColor,
                            titleColor: AppColors.white,
                            height: 38,
                            width: 120,
                            fontSize: 12,
                          ),
                          SizedBox(width: 12.0),
                          PrimaryButton(
                            fontSize: 12,
                            hMargin: 0,
                            vMargin: 0,
                            height: 38,
                            width: 120,
                            backgroundColor: AppColors.primaryColor,
                            titleColor: AppColors.white,
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  selectedCategory != null) {
                                AddBannerInput input = AddBannerInput(
                                  title: titleController.text,
                                  subTitle: subTitleController.text,
                                  description: descriptionController.text,
                                  bannerLink: bannerLinkController.text,
                                  displayOrder: displayNumberController.text,
                                  status: status.toString(),
                                  category: selectedCategory!,
                                );
                                if (fileBytes != null) {
                                  input.file = MultipartFile.fromBytes(
                                    fileBytes!,
                                    filename: "image.png",
                                    contentType: MediaType(
                                      "image",
                                      "png",
                                    ), // <-- correct way to specify contentType
                                  );
                                }
                                if (bannerId != null) {
                                  input.id = bannerId;
                                }

                                widget.onSave(input);
                              } else {
                                DisplayUtils.showSnackBar(
                                  context,
                                  "All Fields are required",
                                );
                              }
                            },
                            title: "Save changes",
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
