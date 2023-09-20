import 'package:aio/infrastructure/db/db_constants.dart';
import 'package:aio/infrastructure/db/schema/domain.dart';
import 'package:aio/infrastructure/db/schema/leadership_type.dart';
import 'package:aio/infrastructure/db/schema/technologies.dart';

import 'config/db_config.dart';
import 'config/schema_config.dart';

class DatabaseHelper with DbConfig, SchemaConfig {
  static const kDatabaseName = "aio.db";
  static const kDatabaseVersion = 1;

  /// Initialise db
  void initialiseDb() {
    init(
        databaseName: kDatabaseName,
        databaseVersion: kDatabaseVersion,
        onCreateDb: initialiseTables);
  }

  /// Add data to the domain.
  void addToDomain(Domain domain) {
    insert(domain.toJson(), DbConstants.tblDomain);
  }

  /// Add data to the leadership.
  void addToLeadershipTypes(LeadershipType leadershipType) {
    insert(leadershipType.toJson(), DbConstants.tblLeadership);
  }

  /// Add data to the technologies.
  void addToTechnologies(Technologies technologies) {
    insert(technologies.toJson(), DbConstants.tblTechnologies);
  }
}
