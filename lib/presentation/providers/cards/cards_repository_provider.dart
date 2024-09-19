import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yu_gi_oh_app/infrastructure/datasources/yugioh_db_datasource_impl.dart';
import 'package:yu_gi_oh_app/infrastructure/repositories/yugioh_db_repository_impl.dart';

/// Provider for the cards repository. It will be used to provide the repository to the UI layer.
final cardsRepositoryProvider = Provider((ref) {
  return YuGiOhDbRepositoryImpl(YugiOhDbDatasourceImpl());
});
