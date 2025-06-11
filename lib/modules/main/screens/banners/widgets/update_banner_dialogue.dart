import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:oonique/constants/api_endpoints.dart';
import 'package:oonique/modules/main/screens/banners/cubit/add_update_banner_cubit/add_update_banner_cubit.dart';
import 'package:oonique/modules/main/screens/banners/models/add_banner_input.dart';
import 'package:oonique/modules/main/screens/banners/models/get_banners_response.dart';
import 'package:oonique/ui/input/input_field.dart';
import 'package:oonique/ui/widgets/custom_dropdown.dart';
import 'package:oonique/ui/widgets/helper_function.dart';
import 'package:oonique/ui/widgets/picture_widget.dart';
import 'package:oonique/ui/widgets/primary_button.dart';
import 'package:oonique/utils/display/display_utils.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../../../../config/routes/nav_router.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../generated/assets.dart';
import '../repositories/repo.dart';

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: BlocProvider(
        create:
            (context) =>
                AddUpdateBannerCubit(bannersRepository: sl<BannersRepository>())
                  ..getCategories(),
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
          child: Form(
            key: _formKey,
            child: BlocBuilder<AddUpdateBannerCubit, AddUpdateBannerState>(
              builder: (context, state) {
                return Column(
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
                      imageUrl:
                          widget.model != null
                              ? imageLink!
                              : Assets.pngSaveImage,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        CustomDropDown(
                          height: 60.0,
                          hint: "Select Category",
                          items: state.categories?.uniqueValues ?? [],
                          onSelect: (v) {
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
