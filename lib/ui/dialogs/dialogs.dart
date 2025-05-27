import 'package:flutter/material.dart';

import '../../config/routes/nav_router.dart';
import '../../constants/routes.dart';
import '../input/input_field.dart';
import '../widgets/toast_loader.dart';
import 'confirmation_dialog.dart';

sealed class Dialogs {
  Dialogs_();

  static Future<void> showLogOutConfirmationDialog(BuildContext context) async {
    final confirmed = await _showConfirmationDialog(
      context,
      title: "Sign Out",
      message: "Are you sure to signout",
    );

    if (confirmed && context.mounted) {
      ToastLoader.show();
      // await context.read<UserCubit>().logout();
      ToastLoader.remove();
      NavRouter.pushAndRemoveUntil(context, '/${Routes.login}');
    }
  }

  static Future<bool> blockUserConfirmation(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    final confirmed = await _showConfirmationDialog(
      context,
      title: title,
      message: message,
    );
    return confirmed;
  }

  static Future<bool> _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    bool? res = await showAdaptiveDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(title: title, message: message),
    );
    return res ?? false;
  }

  static Future<String?> showAddServiceDialogBox(BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    return await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24,
          ),
          title: const Text('Add Service'),
          content: Row(
            children: <Widget>[
              Expanded(
                child: InputField.name(
                  controller: controller,
                  label: 'eg. Cleaning',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
            ),
          ],
        );
      },
    );
  }
}
