// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DownloadVideosTable extends DownloadVideos
    with TableInfo<$DownloadVideosTable, DownloadVideoInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadVideosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bvidMeta = const VerificationMeta('bvid');
  @override
  late final GeneratedColumn<String> bvid = GeneratedColumn<String>(
    'bvid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aidMeta = const VerificationMeta('aid');
  @override
  late final GeneratedColumn<int> aid = GeneratedColumn<int>(
    'aid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _picMeta = const VerificationMeta('pic');
  @override
  late final GeneratedColumn<String> pic = GeneratedColumn<String>(
    'pic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cidMeta = const VerificationMeta('cid');
  @override
  late final GeneratedColumn<int> cid = GeneratedColumn<int>(
    'cid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _videoTitleMeta = const VerificationMeta(
    'videoTitle',
  );
  @override
  late final GeneratedColumn<String> videoTitle = GeneratedColumn<String>(
    'video_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uriMeta = const VerificationMeta('uri');
  @override
  late final GeneratedColumn<String> uri = GeneratedColumn<String>(
    'uri',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 16),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('wait'),
  );
  static const VerificationMeta _errorMsgMeta = const VerificationMeta(
    'errorMsg',
  );
  @override
  late final GeneratedColumn<String> errorMsg = GeneratedColumn<String>(
    'error_msg',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 256),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bvid,
    aid,
    pic,
    cid,
    title,
    videoTitle,
    uri,
    progress,
    status,
    errorMsg,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'download_videos';
  @override
  VerificationContext validateIntegrity(
    Insertable<DownloadVideoInfo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bvid')) {
      context.handle(
        _bvidMeta,
        bvid.isAcceptableOrUnknown(data['bvid']!, _bvidMeta),
      );
    } else if (isInserting) {
      context.missing(_bvidMeta);
    }
    if (data.containsKey('aid')) {
      context.handle(
        _aidMeta,
        aid.isAcceptableOrUnknown(data['aid']!, _aidMeta),
      );
    } else if (isInserting) {
      context.missing(_aidMeta);
    }
    if (data.containsKey('pic')) {
      context.handle(
        _picMeta,
        pic.isAcceptableOrUnknown(data['pic']!, _picMeta),
      );
    } else if (isInserting) {
      context.missing(_picMeta);
    }
    if (data.containsKey('cid')) {
      context.handle(
        _cidMeta,
        cid.isAcceptableOrUnknown(data['cid']!, _cidMeta),
      );
    } else if (isInserting) {
      context.missing(_cidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('video_title')) {
      context.handle(
        _videoTitleMeta,
        videoTitle.isAcceptableOrUnknown(data['video_title']!, _videoTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_videoTitleMeta);
    }
    if (data.containsKey('uri')) {
      context.handle(
        _uriMeta,
        uri.isAcceptableOrUnknown(data['uri']!, _uriMeta),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('error_msg')) {
      context.handle(
        _errorMsgMeta,
        errorMsg.isAcceptableOrUnknown(data['error_msg']!, _errorMsgMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DownloadVideoInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadVideoInfo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bvid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bvid'],
      )!,
      aid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}aid'],
      )!,
      pic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pic'],
      )!,
      cid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cid'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      videoTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}video_title'],
      )!,
      uri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uri'],
      ),
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorMsg: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_msg'],
      ),
    );
  }

  @override
  $DownloadVideosTable createAlias(String alias) {
    return $DownloadVideosTable(attachedDatabase, alias);
  }
}

class DownloadVideoInfo extends DataClass
    implements Insertable<DownloadVideoInfo> {
  final int id;
  final String bvid;
  final int aid;
  final String pic;
  final int cid;
  final String title;
  final String videoTitle;
  final String? uri;
  final double progress;
  final String status;
  final String? errorMsg;
  const DownloadVideoInfo({
    required this.id,
    required this.bvid,
    required this.aid,
    required this.pic,
    required this.cid,
    required this.title,
    required this.videoTitle,
    this.uri,
    required this.progress,
    required this.status,
    this.errorMsg,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bvid'] = Variable<String>(bvid);
    map['aid'] = Variable<int>(aid);
    map['pic'] = Variable<String>(pic);
    map['cid'] = Variable<int>(cid);
    map['title'] = Variable<String>(title);
    map['video_title'] = Variable<String>(videoTitle);
    if (!nullToAbsent || uri != null) {
      map['uri'] = Variable<String>(uri);
    }
    map['progress'] = Variable<double>(progress);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMsg != null) {
      map['error_msg'] = Variable<String>(errorMsg);
    }
    return map;
  }

  DownloadVideosCompanion toCompanion(bool nullToAbsent) {
    return DownloadVideosCompanion(
      id: Value(id),
      bvid: Value(bvid),
      aid: Value(aid),
      pic: Value(pic),
      cid: Value(cid),
      title: Value(title),
      videoTitle: Value(videoTitle),
      uri: uri == null && nullToAbsent ? const Value.absent() : Value(uri),
      progress: Value(progress),
      status: Value(status),
      errorMsg: errorMsg == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMsg),
    );
  }

  factory DownloadVideoInfo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadVideoInfo(
      id: serializer.fromJson<int>(json['id']),
      bvid: serializer.fromJson<String>(json['bvid']),
      aid: serializer.fromJson<int>(json['aid']),
      pic: serializer.fromJson<String>(json['pic']),
      cid: serializer.fromJson<int>(json['cid']),
      title: serializer.fromJson<String>(json['title']),
      videoTitle: serializer.fromJson<String>(json['videoTitle']),
      uri: serializer.fromJson<String?>(json['uri']),
      progress: serializer.fromJson<double>(json['progress']),
      status: serializer.fromJson<String>(json['status']),
      errorMsg: serializer.fromJson<String?>(json['errorMsg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bvid': serializer.toJson<String>(bvid),
      'aid': serializer.toJson<int>(aid),
      'pic': serializer.toJson<String>(pic),
      'cid': serializer.toJson<int>(cid),
      'title': serializer.toJson<String>(title),
      'videoTitle': serializer.toJson<String>(videoTitle),
      'uri': serializer.toJson<String?>(uri),
      'progress': serializer.toJson<double>(progress),
      'status': serializer.toJson<String>(status),
      'errorMsg': serializer.toJson<String?>(errorMsg),
    };
  }

  DownloadVideoInfo copyWith({
    int? id,
    String? bvid,
    int? aid,
    String? pic,
    int? cid,
    String? title,
    String? videoTitle,
    Value<String?> uri = const Value.absent(),
    double? progress,
    String? status,
    Value<String?> errorMsg = const Value.absent(),
  }) => DownloadVideoInfo(
    id: id ?? this.id,
    bvid: bvid ?? this.bvid,
    aid: aid ?? this.aid,
    pic: pic ?? this.pic,
    cid: cid ?? this.cid,
    title: title ?? this.title,
    videoTitle: videoTitle ?? this.videoTitle,
    uri: uri.present ? uri.value : this.uri,
    progress: progress ?? this.progress,
    status: status ?? this.status,
    errorMsg: errorMsg.present ? errorMsg.value : this.errorMsg,
  );
  DownloadVideoInfo copyWithCompanion(DownloadVideosCompanion data) {
    return DownloadVideoInfo(
      id: data.id.present ? data.id.value : this.id,
      bvid: data.bvid.present ? data.bvid.value : this.bvid,
      aid: data.aid.present ? data.aid.value : this.aid,
      pic: data.pic.present ? data.pic.value : this.pic,
      cid: data.cid.present ? data.cid.value : this.cid,
      title: data.title.present ? data.title.value : this.title,
      videoTitle: data.videoTitle.present
          ? data.videoTitle.value
          : this.videoTitle,
      uri: data.uri.present ? data.uri.value : this.uri,
      progress: data.progress.present ? data.progress.value : this.progress,
      status: data.status.present ? data.status.value : this.status,
      errorMsg: data.errorMsg.present ? data.errorMsg.value : this.errorMsg,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DownloadVideoInfo(')
          ..write('id: $id, ')
          ..write('bvid: $bvid, ')
          ..write('aid: $aid, ')
          ..write('pic: $pic, ')
          ..write('cid: $cid, ')
          ..write('title: $title, ')
          ..write('videoTitle: $videoTitle, ')
          ..write('uri: $uri, ')
          ..write('progress: $progress, ')
          ..write('status: $status, ')
          ..write('errorMsg: $errorMsg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bvid,
    aid,
    pic,
    cid,
    title,
    videoTitle,
    uri,
    progress,
    status,
    errorMsg,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadVideoInfo &&
          other.id == this.id &&
          other.bvid == this.bvid &&
          other.aid == this.aid &&
          other.pic == this.pic &&
          other.cid == this.cid &&
          other.title == this.title &&
          other.videoTitle == this.videoTitle &&
          other.uri == this.uri &&
          other.progress == this.progress &&
          other.status == this.status &&
          other.errorMsg == this.errorMsg);
}

class DownloadVideosCompanion extends UpdateCompanion<DownloadVideoInfo> {
  final Value<int> id;
  final Value<String> bvid;
  final Value<int> aid;
  final Value<String> pic;
  final Value<int> cid;
  final Value<String> title;
  final Value<String> videoTitle;
  final Value<String?> uri;
  final Value<double> progress;
  final Value<String> status;
  final Value<String?> errorMsg;
  const DownloadVideosCompanion({
    this.id = const Value.absent(),
    this.bvid = const Value.absent(),
    this.aid = const Value.absent(),
    this.pic = const Value.absent(),
    this.cid = const Value.absent(),
    this.title = const Value.absent(),
    this.videoTitle = const Value.absent(),
    this.uri = const Value.absent(),
    this.progress = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMsg = const Value.absent(),
  });
  DownloadVideosCompanion.insert({
    this.id = const Value.absent(),
    required String bvid,
    required int aid,
    required String pic,
    required int cid,
    required String title,
    required String videoTitle,
    this.uri = const Value.absent(),
    this.progress = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMsg = const Value.absent(),
  }) : bvid = Value(bvid),
       aid = Value(aid),
       pic = Value(pic),
       cid = Value(cid),
       title = Value(title),
       videoTitle = Value(videoTitle);
  static Insertable<DownloadVideoInfo> custom({
    Expression<int>? id,
    Expression<String>? bvid,
    Expression<int>? aid,
    Expression<String>? pic,
    Expression<int>? cid,
    Expression<String>? title,
    Expression<String>? videoTitle,
    Expression<String>? uri,
    Expression<double>? progress,
    Expression<String>? status,
    Expression<String>? errorMsg,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bvid != null) 'bvid': bvid,
      if (aid != null) 'aid': aid,
      if (pic != null) 'pic': pic,
      if (cid != null) 'cid': cid,
      if (title != null) 'title': title,
      if (videoTitle != null) 'video_title': videoTitle,
      if (uri != null) 'uri': uri,
      if (progress != null) 'progress': progress,
      if (status != null) 'status': status,
      if (errorMsg != null) 'error_msg': errorMsg,
    });
  }

  DownloadVideosCompanion copyWith({
    Value<int>? id,
    Value<String>? bvid,
    Value<int>? aid,
    Value<String>? pic,
    Value<int>? cid,
    Value<String>? title,
    Value<String>? videoTitle,
    Value<String?>? uri,
    Value<double>? progress,
    Value<String>? status,
    Value<String?>? errorMsg,
  }) {
    return DownloadVideosCompanion(
      id: id ?? this.id,
      bvid: bvid ?? this.bvid,
      aid: aid ?? this.aid,
      pic: pic ?? this.pic,
      cid: cid ?? this.cid,
      title: title ?? this.title,
      videoTitle: videoTitle ?? this.videoTitle,
      uri: uri ?? this.uri,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bvid.present) {
      map['bvid'] = Variable<String>(bvid.value);
    }
    if (aid.present) {
      map['aid'] = Variable<int>(aid.value);
    }
    if (pic.present) {
      map['pic'] = Variable<String>(pic.value);
    }
    if (cid.present) {
      map['cid'] = Variable<int>(cid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (videoTitle.present) {
      map['video_title'] = Variable<String>(videoTitle.value);
    }
    if (uri.present) {
      map['uri'] = Variable<String>(uri.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMsg.present) {
      map['error_msg'] = Variable<String>(errorMsg.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadVideosCompanion(')
          ..write('id: $id, ')
          ..write('bvid: $bvid, ')
          ..write('aid: $aid, ')
          ..write('pic: $pic, ')
          ..write('cid: $cid, ')
          ..write('title: $title, ')
          ..write('videoTitle: $videoTitle, ')
          ..write('uri: $uri, ')
          ..write('progress: $progress, ')
          ..write('status: $status, ')
          ..write('errorMsg: $errorMsg')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, Settings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _downloadDirMeta = const VerificationMeta(
    'downloadDir',
  );
  @override
  late final GeneratedColumn<String> downloadDir = GeneratedColumn<String>(
    'download_dir',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _maxDownloadCountMeta = const VerificationMeta(
    'maxDownloadCount',
  );
  @override
  late final GeneratedColumn<int> maxDownloadCount = GeneratedColumn<int>(
    'max_download_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(defaultMaxDownloadCount),
  );
  static const VerificationMeta _splitCountMeta = const VerificationMeta(
    'splitCount',
  );
  @override
  late final GeneratedColumn<int> splitCount = GeneratedColumn<int>(
    'split_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4),
  );
  static const VerificationMeta _deleteWithFileMeta = const VerificationMeta(
    'deleteWithFile',
  );
  @override
  late final GeneratedColumn<bool> deleteWithFile = GeneratedColumn<bool>(
    'delete_with_file',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("delete_with_file" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _skipDeleteConfirmMeta = const VerificationMeta(
    'skipDeleteConfirm',
  );
  @override
  late final GeneratedColumn<bool> skipDeleteConfirm = GeneratedColumn<bool>(
    'skip_delete_confirm',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("skip_delete_confirm" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<int> quality = GeneratedColumn<int>(
    'quality',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(defaultQuality),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    downloadDir,
    maxDownloadCount,
    splitCount,
    deleteWithFile,
    skipDeleteConfirm,
    quality,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Settings> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('download_dir')) {
      context.handle(
        _downloadDirMeta,
        downloadDir.isAcceptableOrUnknown(
          data['download_dir']!,
          _downloadDirMeta,
        ),
      );
    }
    if (data.containsKey('max_download_count')) {
      context.handle(
        _maxDownloadCountMeta,
        maxDownloadCount.isAcceptableOrUnknown(
          data['max_download_count']!,
          _maxDownloadCountMeta,
        ),
      );
    }
    if (data.containsKey('split_count')) {
      context.handle(
        _splitCountMeta,
        splitCount.isAcceptableOrUnknown(data['split_count']!, _splitCountMeta),
      );
    }
    if (data.containsKey('delete_with_file')) {
      context.handle(
        _deleteWithFileMeta,
        deleteWithFile.isAcceptableOrUnknown(
          data['delete_with_file']!,
          _deleteWithFileMeta,
        ),
      );
    }
    if (data.containsKey('skip_delete_confirm')) {
      context.handle(
        _skipDeleteConfirmMeta,
        skipDeleteConfirm.isAcceptableOrUnknown(
          data['skip_delete_confirm']!,
          _skipDeleteConfirmMeta,
        ),
      );
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Settings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Settings(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      downloadDir: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}download_dir'],
      )!,
      maxDownloadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_download_count'],
      )!,
      splitCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}split_count'],
      )!,
      deleteWithFile: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}delete_with_file'],
      )!,
      skipDeleteConfirm: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}skip_delete_confirm'],
      )!,
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quality'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class Settings extends DataClass implements Insertable<Settings> {
  final int id;
  final String downloadDir;
  final int maxDownloadCount;
  final int splitCount;
  final bool deleteWithFile;
  final bool skipDeleteConfirm;
  final int quality;
  const Settings({
    required this.id,
    required this.downloadDir,
    required this.maxDownloadCount,
    required this.splitCount,
    required this.deleteWithFile,
    required this.skipDeleteConfirm,
    required this.quality,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['download_dir'] = Variable<String>(downloadDir);
    map['max_download_count'] = Variable<int>(maxDownloadCount);
    map['split_count'] = Variable<int>(splitCount);
    map['delete_with_file'] = Variable<bool>(deleteWithFile);
    map['skip_delete_confirm'] = Variable<bool>(skipDeleteConfirm);
    map['quality'] = Variable<int>(quality);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      downloadDir: Value(downloadDir),
      maxDownloadCount: Value(maxDownloadCount),
      splitCount: Value(splitCount),
      deleteWithFile: Value(deleteWithFile),
      skipDeleteConfirm: Value(skipDeleteConfirm),
      quality: Value(quality),
    );
  }

  factory Settings.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Settings(
      id: serializer.fromJson<int>(json['id']),
      downloadDir: serializer.fromJson<String>(json['downloadDir']),
      maxDownloadCount: serializer.fromJson<int>(json['maxDownloadCount']),
      splitCount: serializer.fromJson<int>(json['splitCount']),
      deleteWithFile: serializer.fromJson<bool>(json['deleteWithFile']),
      skipDeleteConfirm: serializer.fromJson<bool>(json['skipDeleteConfirm']),
      quality: serializer.fromJson<int>(json['quality']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'downloadDir': serializer.toJson<String>(downloadDir),
      'maxDownloadCount': serializer.toJson<int>(maxDownloadCount),
      'splitCount': serializer.toJson<int>(splitCount),
      'deleteWithFile': serializer.toJson<bool>(deleteWithFile),
      'skipDeleteConfirm': serializer.toJson<bool>(skipDeleteConfirm),
      'quality': serializer.toJson<int>(quality),
    };
  }

  Settings copyWith({
    int? id,
    String? downloadDir,
    int? maxDownloadCount,
    int? splitCount,
    bool? deleteWithFile,
    bool? skipDeleteConfirm,
    int? quality,
  }) => Settings(
    id: id ?? this.id,
    downloadDir: downloadDir ?? this.downloadDir,
    maxDownloadCount: maxDownloadCount ?? this.maxDownloadCount,
    splitCount: splitCount ?? this.splitCount,
    deleteWithFile: deleteWithFile ?? this.deleteWithFile,
    skipDeleteConfirm: skipDeleteConfirm ?? this.skipDeleteConfirm,
    quality: quality ?? this.quality,
  );
  Settings copyWithCompanion(AppSettingsCompanion data) {
    return Settings(
      id: data.id.present ? data.id.value : this.id,
      downloadDir: data.downloadDir.present
          ? data.downloadDir.value
          : this.downloadDir,
      maxDownloadCount: data.maxDownloadCount.present
          ? data.maxDownloadCount.value
          : this.maxDownloadCount,
      splitCount: data.splitCount.present
          ? data.splitCount.value
          : this.splitCount,
      deleteWithFile: data.deleteWithFile.present
          ? data.deleteWithFile.value
          : this.deleteWithFile,
      skipDeleteConfirm: data.skipDeleteConfirm.present
          ? data.skipDeleteConfirm.value
          : this.skipDeleteConfirm,
      quality: data.quality.present ? data.quality.value : this.quality,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Settings(')
          ..write('id: $id, ')
          ..write('downloadDir: $downloadDir, ')
          ..write('maxDownloadCount: $maxDownloadCount, ')
          ..write('splitCount: $splitCount, ')
          ..write('deleteWithFile: $deleteWithFile, ')
          ..write('skipDeleteConfirm: $skipDeleteConfirm, ')
          ..write('quality: $quality')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    downloadDir,
    maxDownloadCount,
    splitCount,
    deleteWithFile,
    skipDeleteConfirm,
    quality,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Settings &&
          other.id == this.id &&
          other.downloadDir == this.downloadDir &&
          other.maxDownloadCount == this.maxDownloadCount &&
          other.splitCount == this.splitCount &&
          other.deleteWithFile == this.deleteWithFile &&
          other.skipDeleteConfirm == this.skipDeleteConfirm &&
          other.quality == this.quality);
}

class AppSettingsCompanion extends UpdateCompanion<Settings> {
  final Value<int> id;
  final Value<String> downloadDir;
  final Value<int> maxDownloadCount;
  final Value<int> splitCount;
  final Value<bool> deleteWithFile;
  final Value<bool> skipDeleteConfirm;
  final Value<int> quality;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.downloadDir = const Value.absent(),
    this.maxDownloadCount = const Value.absent(),
    this.splitCount = const Value.absent(),
    this.deleteWithFile = const Value.absent(),
    this.skipDeleteConfirm = const Value.absent(),
    this.quality = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required int id,
    this.downloadDir = const Value.absent(),
    this.maxDownloadCount = const Value.absent(),
    this.splitCount = const Value.absent(),
    this.deleteWithFile = const Value.absent(),
    this.skipDeleteConfirm = const Value.absent(),
    this.quality = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Settings> custom({
    Expression<int>? id,
    Expression<String>? downloadDir,
    Expression<int>? maxDownloadCount,
    Expression<int>? splitCount,
    Expression<bool>? deleteWithFile,
    Expression<bool>? skipDeleteConfirm,
    Expression<int>? quality,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (downloadDir != null) 'download_dir': downloadDir,
      if (maxDownloadCount != null) 'max_download_count': maxDownloadCount,
      if (splitCount != null) 'split_count': splitCount,
      if (deleteWithFile != null) 'delete_with_file': deleteWithFile,
      if (skipDeleteConfirm != null) 'skip_delete_confirm': skipDeleteConfirm,
      if (quality != null) 'quality': quality,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? downloadDir,
    Value<int>? maxDownloadCount,
    Value<int>? splitCount,
    Value<bool>? deleteWithFile,
    Value<bool>? skipDeleteConfirm,
    Value<int>? quality,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      downloadDir: downloadDir ?? this.downloadDir,
      maxDownloadCount: maxDownloadCount ?? this.maxDownloadCount,
      splitCount: splitCount ?? this.splitCount,
      deleteWithFile: deleteWithFile ?? this.deleteWithFile,
      skipDeleteConfirm: skipDeleteConfirm ?? this.skipDeleteConfirm,
      quality: quality ?? this.quality,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (downloadDir.present) {
      map['download_dir'] = Variable<String>(downloadDir.value);
    }
    if (maxDownloadCount.present) {
      map['max_download_count'] = Variable<int>(maxDownloadCount.value);
    }
    if (splitCount.present) {
      map['split_count'] = Variable<int>(splitCount.value);
    }
    if (deleteWithFile.present) {
      map['delete_with_file'] = Variable<bool>(deleteWithFile.value);
    }
    if (skipDeleteConfirm.present) {
      map['skip_delete_confirm'] = Variable<bool>(skipDeleteConfirm.value);
    }
    if (quality.present) {
      map['quality'] = Variable<int>(quality.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('downloadDir: $downloadDir, ')
          ..write('maxDownloadCount: $maxDownloadCount, ')
          ..write('splitCount: $splitCount, ')
          ..write('deleteWithFile: $deleteWithFile, ')
          ..write('skipDeleteConfirm: $skipDeleteConfirm, ')
          ..write('quality: $quality, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SearchHistoriesTable extends SearchHistories
    with TableInfo<$SearchHistoriesTable, SearchHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _picMeta = const VerificationMeta('pic');
  @override
  late final GeneratedColumn<String> pic = GeneratedColumn<String>(
    'pic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, url, title, pic, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('pic')) {
      context.handle(
        _picMeta,
        pic.isAcceptableOrUnknown(data['pic']!, _picMeta),
      );
    } else if (isInserting) {
      context.missing(_picMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      pic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pic'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SearchHistoriesTable createAlias(String alias) {
    return $SearchHistoriesTable(attachedDatabase, alias);
  }
}

class SearchHistory extends DataClass implements Insertable<SearchHistory> {
  final int id;
  final String url;
  final String title;
  final String pic;
  final DateTime createdAt;
  const SearchHistory({
    required this.id,
    required this.url,
    required this.title,
    required this.pic,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['url'] = Variable<String>(url);
    map['title'] = Variable<String>(title);
    map['pic'] = Variable<String>(pic);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SearchHistoriesCompanion toCompanion(bool nullToAbsent) {
    return SearchHistoriesCompanion(
      id: Value(id),
      url: Value(url),
      title: Value(title),
      pic: Value(pic),
      createdAt: Value(createdAt),
    );
  }

  factory SearchHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistory(
      id: serializer.fromJson<int>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      title: serializer.fromJson<String>(json['title']),
      pic: serializer.fromJson<String>(json['pic']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'url': serializer.toJson<String>(url),
      'title': serializer.toJson<String>(title),
      'pic': serializer.toJson<String>(pic),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SearchHistory copyWith({
    int? id,
    String? url,
    String? title,
    String? pic,
    DateTime? createdAt,
  }) => SearchHistory(
    id: id ?? this.id,
    url: url ?? this.url,
    title: title ?? this.title,
    pic: pic ?? this.pic,
    createdAt: createdAt ?? this.createdAt,
  );
  SearchHistory copyWithCompanion(SearchHistoriesCompanion data) {
    return SearchHistory(
      id: data.id.present ? data.id.value : this.id,
      url: data.url.present ? data.url.value : this.url,
      title: data.title.present ? data.title.value : this.title,
      pic: data.pic.present ? data.pic.value : this.pic,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistory(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('title: $title, ')
          ..write('pic: $pic, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, url, title, pic, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistory &&
          other.id == this.id &&
          other.url == this.url &&
          other.title == this.title &&
          other.pic == this.pic &&
          other.createdAt == this.createdAt);
}

class SearchHistoriesCompanion extends UpdateCompanion<SearchHistory> {
  final Value<int> id;
  final Value<String> url;
  final Value<String> title;
  final Value<String> pic;
  final Value<DateTime> createdAt;
  const SearchHistoriesCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.title = const Value.absent(),
    this.pic = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SearchHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required String url,
    required String title,
    required String pic,
    this.createdAt = const Value.absent(),
  }) : url = Value(url),
       title = Value(title),
       pic = Value(pic);
  static Insertable<SearchHistory> custom({
    Expression<int>? id,
    Expression<String>? url,
    Expression<String>? title,
    Expression<String>? pic,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (title != null) 'title': title,
      if (pic != null) 'pic': pic,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SearchHistoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? url,
    Value<String>? title,
    Value<String>? pic,
    Value<DateTime>? createdAt,
  }) {
    return SearchHistoriesCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title ?? this.title,
      pic: pic ?? this.pic,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (pic.present) {
      map['pic'] = Variable<String>(pic.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('title: $title, ')
          ..write('pic: $pic, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DownloadVideosTable downloadVideos = $DownloadVideosTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $SearchHistoriesTable searchHistories = $SearchHistoriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    downloadVideos,
    appSettings,
    searchHistories,
  ];
}

typedef $$DownloadVideosTableCreateCompanionBuilder =
    DownloadVideosCompanion Function({
      Value<int> id,
      required String bvid,
      required int aid,
      required String pic,
      required int cid,
      required String title,
      required String videoTitle,
      Value<String?> uri,
      Value<double> progress,
      Value<String> status,
      Value<String?> errorMsg,
    });
typedef $$DownloadVideosTableUpdateCompanionBuilder =
    DownloadVideosCompanion Function({
      Value<int> id,
      Value<String> bvid,
      Value<int> aid,
      Value<String> pic,
      Value<int> cid,
      Value<String> title,
      Value<String> videoTitle,
      Value<String?> uri,
      Value<double> progress,
      Value<String> status,
      Value<String?> errorMsg,
    });

class $$DownloadVideosTableFilterComposer
    extends Composer<_$AppDatabase, $DownloadVideosTable> {
  $$DownloadVideosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bvid => $composableBuilder(
    column: $table.bvid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get aid => $composableBuilder(
    column: $table.aid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pic => $composableBuilder(
    column: $table.pic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cid => $composableBuilder(
    column: $table.cid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get videoTitle => $composableBuilder(
    column: $table.videoTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uri => $composableBuilder(
    column: $table.uri,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMsg => $composableBuilder(
    column: $table.errorMsg,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DownloadVideosTableOrderingComposer
    extends Composer<_$AppDatabase, $DownloadVideosTable> {
  $$DownloadVideosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bvid => $composableBuilder(
    column: $table.bvid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get aid => $composableBuilder(
    column: $table.aid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pic => $composableBuilder(
    column: $table.pic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cid => $composableBuilder(
    column: $table.cid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get videoTitle => $composableBuilder(
    column: $table.videoTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uri => $composableBuilder(
    column: $table.uri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMsg => $composableBuilder(
    column: $table.errorMsg,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DownloadVideosTableAnnotationComposer
    extends Composer<_$AppDatabase, $DownloadVideosTable> {
  $$DownloadVideosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bvid =>
      $composableBuilder(column: $table.bvid, builder: (column) => column);

  GeneratedColumn<int> get aid =>
      $composableBuilder(column: $table.aid, builder: (column) => column);

  GeneratedColumn<String> get pic =>
      $composableBuilder(column: $table.pic, builder: (column) => column);

  GeneratedColumn<int> get cid =>
      $composableBuilder(column: $table.cid, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get videoTitle => $composableBuilder(
    column: $table.videoTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get uri =>
      $composableBuilder(column: $table.uri, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMsg =>
      $composableBuilder(column: $table.errorMsg, builder: (column) => column);
}

class $$DownloadVideosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DownloadVideosTable,
          DownloadVideoInfo,
          $$DownloadVideosTableFilterComposer,
          $$DownloadVideosTableOrderingComposer,
          $$DownloadVideosTableAnnotationComposer,
          $$DownloadVideosTableCreateCompanionBuilder,
          $$DownloadVideosTableUpdateCompanionBuilder,
          (
            DownloadVideoInfo,
            BaseReferences<
              _$AppDatabase,
              $DownloadVideosTable,
              DownloadVideoInfo
            >,
          ),
          DownloadVideoInfo,
          PrefetchHooks Function()
        > {
  $$DownloadVideosTableTableManager(
    _$AppDatabase db,
    $DownloadVideosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DownloadVideosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DownloadVideosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DownloadVideosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> bvid = const Value.absent(),
                Value<int> aid = const Value.absent(),
                Value<String> pic = const Value.absent(),
                Value<int> cid = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> videoTitle = const Value.absent(),
                Value<String?> uri = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMsg = const Value.absent(),
              }) => DownloadVideosCompanion(
                id: id,
                bvid: bvid,
                aid: aid,
                pic: pic,
                cid: cid,
                title: title,
                videoTitle: videoTitle,
                uri: uri,
                progress: progress,
                status: status,
                errorMsg: errorMsg,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String bvid,
                required int aid,
                required String pic,
                required int cid,
                required String title,
                required String videoTitle,
                Value<String?> uri = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMsg = const Value.absent(),
              }) => DownloadVideosCompanion.insert(
                id: id,
                bvid: bvid,
                aid: aid,
                pic: pic,
                cid: cid,
                title: title,
                videoTitle: videoTitle,
                uri: uri,
                progress: progress,
                status: status,
                errorMsg: errorMsg,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DownloadVideosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DownloadVideosTable,
      DownloadVideoInfo,
      $$DownloadVideosTableFilterComposer,
      $$DownloadVideosTableOrderingComposer,
      $$DownloadVideosTableAnnotationComposer,
      $$DownloadVideosTableCreateCompanionBuilder,
      $$DownloadVideosTableUpdateCompanionBuilder,
      (
        DownloadVideoInfo,
        BaseReferences<_$AppDatabase, $DownloadVideosTable, DownloadVideoInfo>,
      ),
      DownloadVideoInfo,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required int id,
      Value<String> downloadDir,
      Value<int> maxDownloadCount,
      Value<int> splitCount,
      Value<bool> deleteWithFile,
      Value<bool> skipDeleteConfirm,
      Value<int> quality,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<String> downloadDir,
      Value<int> maxDownloadCount,
      Value<int> splitCount,
      Value<bool> deleteWithFile,
      Value<bool> skipDeleteConfirm,
      Value<int> quality,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get downloadDir => $composableBuilder(
    column: $table.downloadDir,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxDownloadCount => $composableBuilder(
    column: $table.maxDownloadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get splitCount => $composableBuilder(
    column: $table.splitCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleteWithFile => $composableBuilder(
    column: $table.deleteWithFile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get skipDeleteConfirm => $composableBuilder(
    column: $table.skipDeleteConfirm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get downloadDir => $composableBuilder(
    column: $table.downloadDir,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxDownloadCount => $composableBuilder(
    column: $table.maxDownloadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get splitCount => $composableBuilder(
    column: $table.splitCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleteWithFile => $composableBuilder(
    column: $table.deleteWithFile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get skipDeleteConfirm => $composableBuilder(
    column: $table.skipDeleteConfirm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get downloadDir => $composableBuilder(
    column: $table.downloadDir,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxDownloadCount => $composableBuilder(
    column: $table.maxDownloadCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get splitCount => $composableBuilder(
    column: $table.splitCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get deleteWithFile => $composableBuilder(
    column: $table.deleteWithFile,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get skipDeleteConfirm => $composableBuilder(
    column: $table.skipDeleteConfirm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          Settings,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            Settings,
            BaseReferences<_$AppDatabase, $AppSettingsTable, Settings>,
          ),
          Settings,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> downloadDir = const Value.absent(),
                Value<int> maxDownloadCount = const Value.absent(),
                Value<int> splitCount = const Value.absent(),
                Value<bool> deleteWithFile = const Value.absent(),
                Value<bool> skipDeleteConfirm = const Value.absent(),
                Value<int> quality = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                downloadDir: downloadDir,
                maxDownloadCount: maxDownloadCount,
                splitCount: splitCount,
                deleteWithFile: deleteWithFile,
                skipDeleteConfirm: skipDeleteConfirm,
                quality: quality,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                Value<String> downloadDir = const Value.absent(),
                Value<int> maxDownloadCount = const Value.absent(),
                Value<int> splitCount = const Value.absent(),
                Value<bool> deleteWithFile = const Value.absent(),
                Value<bool> skipDeleteConfirm = const Value.absent(),
                Value<int> quality = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                downloadDir: downloadDir,
                maxDownloadCount: maxDownloadCount,
                splitCount: splitCount,
                deleteWithFile: deleteWithFile,
                skipDeleteConfirm: skipDeleteConfirm,
                quality: quality,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      Settings,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (Settings, BaseReferences<_$AppDatabase, $AppSettingsTable, Settings>),
      Settings,
      PrefetchHooks Function()
    >;
typedef $$SearchHistoriesTableCreateCompanionBuilder =
    SearchHistoriesCompanion Function({
      Value<int> id,
      required String url,
      required String title,
      required String pic,
      Value<DateTime> createdAt,
    });
typedef $$SearchHistoriesTableUpdateCompanionBuilder =
    SearchHistoriesCompanion Function({
      Value<int> id,
      Value<String> url,
      Value<String> title,
      Value<String> pic,
      Value<DateTime> createdAt,
    });

class $$SearchHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $SearchHistoriesTable> {
  $$SearchHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pic => $composableBuilder(
    column: $table.pic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SearchHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchHistoriesTable> {
  $$SearchHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pic => $composableBuilder(
    column: $table.pic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SearchHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchHistoriesTable> {
  $$SearchHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get pic =>
      $composableBuilder(column: $table.pic, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SearchHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SearchHistoriesTable,
          SearchHistory,
          $$SearchHistoriesTableFilterComposer,
          $$SearchHistoriesTableOrderingComposer,
          $$SearchHistoriesTableAnnotationComposer,
          $$SearchHistoriesTableCreateCompanionBuilder,
          $$SearchHistoriesTableUpdateCompanionBuilder,
          (
            SearchHistory,
            BaseReferences<_$AppDatabase, $SearchHistoriesTable, SearchHistory>,
          ),
          SearchHistory,
          PrefetchHooks Function()
        > {
  $$SearchHistoriesTableTableManager(
    _$AppDatabase db,
    $SearchHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchHistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> pic = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SearchHistoriesCompanion(
                id: id,
                url: url,
                title: title,
                pic: pic,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String url,
                required String title,
                required String pic,
                Value<DateTime> createdAt = const Value.absent(),
              }) => SearchHistoriesCompanion.insert(
                id: id,
                url: url,
                title: title,
                pic: pic,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SearchHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SearchHistoriesTable,
      SearchHistory,
      $$SearchHistoriesTableFilterComposer,
      $$SearchHistoriesTableOrderingComposer,
      $$SearchHistoriesTableAnnotationComposer,
      $$SearchHistoriesTableCreateCompanionBuilder,
      $$SearchHistoriesTableUpdateCompanionBuilder,
      (
        SearchHistory,
        BaseReferences<_$AppDatabase, $SearchHistoriesTable, SearchHistory>,
      ),
      SearchHistory,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DownloadVideosTableTableManager get downloadVideos =>
      $$DownloadVideosTableTableManager(_db, _db.downloadVideos);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$SearchHistoriesTableTableManager get searchHistories =>
      $$SearchHistoriesTableTableManager(_db, _db.searchHistories);
}
