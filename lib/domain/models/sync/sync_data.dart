enum DataSource {
  local,
  remote;

  String get locKey => switch (this) {
    .local => 'dataSource.local',
    .remote => 'dataSource.remote',
  };
}

class SyncData<T> {
  final T data;
  final DataSource source;

  SyncData({required this.data, required this.source});
}
