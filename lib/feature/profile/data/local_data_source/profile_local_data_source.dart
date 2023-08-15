import 'package:huylnt_flutter_component/reusable_core/extensions/logger.dart';
import 'package:isar/isar.dart';

import '../../../../core/model/profile_model.dart';
import '../../../../core/network/local/isar/isar_database.dart';

class ProfileLocalDataSource with IsarDatabase {
  late IsarCollection<Profile> profileCollection;
  ProfileLocalDataSource() {
    profileCollection = isarInstance!.collection<Profile>();
  }

  Future<Profile?> getProfileById(String guardianId) async {
    final profile = await profileCollection.getById(
      guardianId,
    );
    if (profile.isFresh) return profile;
    return null;
  }

  Future<int> putProfile(Profile profile) async {
    try {
      await isarInstance!.writeTxn(() async {
        final trackedProfile = profile.copyWith(
          localLastModifiedAt: DateTime.now(),
        );
        final key = await profileCollection.putById(trackedProfile);
        return key;
      });
    } on Exception catch (error) {
      Logger.e(error);
    }
    return -1;
  }

  Future<bool> deleteProfile(String guardianId) async {
    try {
      await isarInstance!.writeTxn(() async {
        final success = await profileCollection.deleteById(guardianId);
        return success;
      });
    } on Exception catch (error) {
      Logger.e(error);
    }
    return false;
  }
}
