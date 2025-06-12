import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/constants/app_colors.dart';
import 'package:oonique/ui/widgets/primary_button.dart';
import 'package:oonique/utils/extensions/extended_context.dart';
import '../../../../../config/routes/nav_router.dart';
import '../../../../../ui/input/custom_input_field.dart';
import '../../../../../ui/widgets/custom_dropdown_widget.dart';
import '../../../../../ui/widgets/on_click.dart';
import '../cubits/update_ticket/update_ticket_cubit.dart';
import '../models/all_support_response.dart';
import '../pages/support_page_mobile.dart';

class AddResponseDialogue extends StatefulWidget {
  const AddResponseDialogue({super.key, required this.model});

  final SupportResponseModel model;
  @override
  State<AddResponseDialogue> createState() => _AddResponseDialogueState();
}

class _AddResponseDialogueState extends State<AddResponseDialogue> {
  String? status;
  final TextEditingController responseMessageController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      backgroundColor: AppColors.dialogBgColor,
      child: Container(
        width: 600,
        padding:
            const EdgeInsets.only(top: 23.0, left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.dialogBgColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: AppColors.borderColor, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Respond to Ticket",
                  style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.white),
                ),
                OnClick(
                  onTap: () {
                    NavRouter.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 16.0,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            CustomInputField(
              horizontalPadding: 8,
              hintColor: AppColors.titlaTextColor,
              textColor: AppColors.white,
              focusBorderColor: AppColors.borderColor,
              maxLines: 4,
              controller: responseMessageController,
              textInputAction: TextInputAction.done,
              label: 'Response Message',
              borderColor: AppColors.borderColor,
              borderRadius: 3,
              fillColor: AppColors.dialogBgColor,
              boxConstraints: 10,
            ),
            SizedBox(height: 8.0),
            CustomDropdownWidget(
              items: ["Pending", "In Progress", "Resolved"],
              initialValue: "Pending",
              onChanged: (v) {
                status = returnStatus(v);
              },
            ),
            // CustomDropDown(
            //   hint: "Select Status",
            //   items: ["Pending", "In Progress", "Resolved"],
            //   onSelect: (v) {
            //     status = returnStatus(v);
            //   },
            // ),
            SizedBox(height: 15.0),
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
                    if (responseMessageController.text.isNotEmpty) {
                      await context
                          .read<UpdateTicketCubit>()
                          .addTicketResponse(
                            supportId: widget.model.id,
                            message: responseMessageController.text,
                          )
                          .then((v) async {
                        await context
                            .read<UpdateTicketCubit>()
                            .updateTicket(
                              supportId: widget.model.id,
                              status: status!,
                            )
                            .then((v) async {
                          NavRouter.pop(context);
                        });
                      });
                    }
                  },
                  title: "Save changes",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
