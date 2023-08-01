import 'package:huylnt_flutter_component/reusable_core/extensions/logger.dart';

import '../../../../core/model/profile_model.dart';
import '../../../../core/network/local/isar/isar_database.dart';

class ProfileLocalDataSource with IsarDatabase {
  Future<Profile?> getProfileById(String guardianId) async {
    final profileCollection = isarInstance!.collection<Profile>();
    final profile = await profileCollection.getById(
      guardianId,
    );
    return profile;
  }

  Future<int> putProfile(Profile profile) async {
    final profileCollection = isarInstance!.collection<Profile>();
    try {
      await isarInstance!.writeTxn(() async {
        final key = await profileCollection.putById(profile);
        return key;
      });
    } on Exception catch (error) {
      Logger.e(error);
    }
    return -1;
  }
}
