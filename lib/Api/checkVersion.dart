import 'package:flutter/cupertino.dart';
import 'package:new_version_plus/new_version_plus.dart';

import '../Constants/Localization/Translations.dart';

Future<void> advancedStatusCheck(BuildContext context, NewVersionPlus newVersion) async {
  try {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      // debugPrint(status.releaseNotes);
      // debugPrint(status.appStoreLink);
      // debugPrint(status.localVersion);
      // debugPrint(status.storeVersion);
      // debugPrint(status.canUpdate.toString());
      if (status.canUpdate) {
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: Translations.of(context)!.please,
          dialogText: Translations.of(context)!.LastVersion + " (" +
              status.localVersion + " - " + status.storeVersion + " ) ",
          updateButtonText: Translations.of(context)!.okey,
          launchModeVersion: LaunchModeVersion.external,
          allowDismissal: false,
        );
      }
    }
  }
  catch(e)
  {
    print("advancedStatusCheck"+e.toString());
  }
}
