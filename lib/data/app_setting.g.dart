// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_setting.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppSettingCollection on Isar {
  IsarCollection<AppSetting> get appSettings => this.collection();
}

const AppSettingSchema = CollectionSchema(
  name: r'AppSetting',
  id: -948817443998796339,
  properties: {
    r'notifyNightlyForecast': PropertySchema(
      id: 0,
      name: r'notifyNightlyForecast',
      type: IsarType.bool,
    ),
    r'notifyRainfall': PropertySchema(
      id: 1,
      name: r'notifyRainfall',
      type: IsarType.bool,
    ),
    r'tempUnit': PropertySchema(
      id: 2,
      name: r'tempUnit',
      type: IsarType.byte,
      enumMap: _AppSettingtempUnitEnumValueMap,
    ),
    r'theme': PropertySchema(
      id: 3,
      name: r'theme',
      type: IsarType.byte,
      enumMap: _AppSettingthemeEnumValueMap,
    ),
    r'weatherUnits': PropertySchema(
      id: 4,
      name: r'weatherUnits',
      type: IsarType.object,
      target: r'WeatherUnits',
    ),
  },
  estimateSize: _appSettingEstimateSize,
  serialize: _appSettingSerialize,
  deserialize: _appSettingDeserialize,
  deserializeProp: _appSettingDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'WeatherUnits': WeatherUnitsSchema},
  getId: _appSettingGetId,
  getLinks: _appSettingGetLinks,
  attach: _appSettingAttach,
  version: '3.1.0+1',
);

int _appSettingEstimateSize(
  AppSetting object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount +=
      3 +
      WeatherUnitsSchema.estimateSize(
        object.weatherUnits,
        allOffsets[WeatherUnits]!,
        allOffsets,
      );
  return bytesCount;
}

void _appSettingSerialize(
  AppSetting object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.notifyNightlyForecast);
  writer.writeBool(offsets[1], object.notifyRainfall);
  writer.writeByte(offsets[2], object.tempUnit.index);
  writer.writeByte(offsets[3], object.theme.index);
  writer.writeObject<WeatherUnits>(
    offsets[4],
    allOffsets,
    WeatherUnitsSchema.serialize,
    object.weatherUnits,
  );
}

AppSetting _appSettingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppSetting();
  object.id = id;
  object.notifyNightlyForecast = reader.readBool(offsets[0]);
  object.notifyRainfall = reader.readBool(offsets[1]);
  object.tempUnit =
      _AppSettingtempUnitValueEnumMap[reader.readByteOrNull(offsets[2])] ??
      TemperatureUnit.celsius;
  object.theme =
      _AppSettingthemeValueEnumMap[reader.readByteOrNull(offsets[3])] ??
      ThemeColor.light;
  object.weatherUnits =
      reader.readObjectOrNull<WeatherUnits>(
        offsets[4],
        WeatherUnitsSchema.deserialize,
        allOffsets,
      ) ??
      WeatherUnits();
  return object;
}

P _appSettingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (_AppSettingtempUnitValueEnumMap[reader.readByteOrNull(offset)] ??
              TemperatureUnit.celsius)
          as P;
    case 3:
      return (_AppSettingthemeValueEnumMap[reader.readByteOrNull(offset)] ??
              ThemeColor.light)
          as P;
    case 4:
      return (reader.readObjectOrNull<WeatherUnits>(
                offset,
                WeatherUnitsSchema.deserialize,
                allOffsets,
              ) ??
              WeatherUnits())
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AppSettingtempUnitEnumValueMap = {'celsius': 0, 'fahrenheit': 1};
const _AppSettingtempUnitValueEnumMap = {
  0: TemperatureUnit.celsius,
  1: TemperatureUnit.fahrenheit,
};
const _AppSettingthemeEnumValueMap = {'light': 0, 'dark': 1, 'auto': 2};
const _AppSettingthemeValueEnumMap = {
  0: ThemeColor.light,
  1: ThemeColor.dark,
  2: ThemeColor.auto,
};

Id _appSettingGetId(AppSetting object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appSettingGetLinks(AppSetting object) {
  return [];
}

void _appSettingAttach(IsarCollection<dynamic> col, Id id, AppSetting object) {
  object.id = id;
}

extension AppSettingQueryWhereSort
    on QueryBuilder<AppSetting, AppSetting, QWhere> {
  QueryBuilder<AppSetting, AppSetting, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppSettingQueryWhere
    on QueryBuilder<AppSetting, AppSetting, QWhereClause> {
  QueryBuilder<AppSetting, AppSetting, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension AppSettingQueryFilter
    on QueryBuilder<AppSetting, AppSetting, QFilterCondition> {
  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition>
  notifyNightlyForecastEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notifyNightlyForecast',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition>
  notifyRainfallEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notifyRainfall', value: value),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> tempUnitEqualTo(
    TemperatureUnit value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tempUnit', value: value),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition>
  tempUnitGreaterThan(TemperatureUnit value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tempUnit',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> tempUnitLessThan(
    TemperatureUnit value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tempUnit',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> tempUnitBetween(
    TemperatureUnit lower,
    TemperatureUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tempUnit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> themeEqualTo(
    ThemeColor value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'theme', value: value),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> themeGreaterThan(
    ThemeColor value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'theme',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> themeLessThan(
    ThemeColor value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'theme',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> themeBetween(
    ThemeColor lower,
    ThemeColor upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'theme',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension AppSettingQueryObject
    on QueryBuilder<AppSetting, AppSetting, QFilterCondition> {
  QueryBuilder<AppSetting, AppSetting, QAfterFilterCondition> weatherUnits(
    FilterQuery<WeatherUnits> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'weatherUnits');
    });
  }
}

extension AppSettingQueryLinks
    on QueryBuilder<AppSetting, AppSetting, QFilterCondition> {}

extension AppSettingQuerySortBy
    on QueryBuilder<AppSetting, AppSetting, QSortBy> {
  QueryBuilder<AppSetting, AppSetting, QAfterSortBy>
  sortByNotifyNightlyForecast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notifyNightlyForecast', Sort.asc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy>
  sortByNotifyNightlyForecastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notifyNightlyForecast', Sort.desc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> sortByNotifyRainfall() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notifyRainfall', Sort.asc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy>
  sortByNotifyRainfallDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notifyRainfall', Sort.desc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> sortByTempUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempUnit', Sort.asc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> sortByTempUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempUnit', Sort.desc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> sortByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> sortByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }
}

extension AppSettingQuerySortThenBy
    on QueryBuilder<AppSetting, AppSetting, QSortThenBy> {
  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy>
  thenByNotifyNightlyForecast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notifyNightlyForecast', Sort.asc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy>
  thenByNotifyNightlyForecastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notifyNightlyForecast', Sort.desc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> thenByNotifyRainfall() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notifyRainfall', Sort.asc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy>
  thenByNotifyRainfallDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notifyRainfall', Sort.desc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> thenByTempUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempUnit', Sort.asc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> thenByTempUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tempUnit', Sort.desc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> thenByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<AppSetting, AppSetting, QAfterSortBy> thenByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }
}

extension AppSettingQueryWhereDistinct
    on QueryBuilder<AppSetting, AppSetting, QDistinct> {
  QueryBuilder<AppSetting, AppSetting, QDistinct>
  distinctByNotifyNightlyForecast() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notifyNightlyForecast');
    });
  }

  QueryBuilder<AppSetting, AppSetting, QDistinct> distinctByNotifyRainfall() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notifyRainfall');
    });
  }

  QueryBuilder<AppSetting, AppSetting, QDistinct> distinctByTempUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tempUnit');
    });
  }

  QueryBuilder<AppSetting, AppSetting, QDistinct> distinctByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'theme');
    });
  }
}

extension AppSettingQueryProperty
    on QueryBuilder<AppSetting, AppSetting, QQueryProperty> {
  QueryBuilder<AppSetting, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppSetting, bool, QQueryOperations>
  notifyNightlyForecastProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notifyNightlyForecast');
    });
  }

  QueryBuilder<AppSetting, bool, QQueryOperations> notifyRainfallProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notifyRainfall');
    });
  }

  QueryBuilder<AppSetting, TemperatureUnit, QQueryOperations>
  tempUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tempUnit');
    });
  }

  QueryBuilder<AppSetting, ThemeColor, QQueryOperations> themeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'theme');
    });
  }

  QueryBuilder<AppSetting, WeatherUnits, QQueryOperations>
  weatherUnitsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weatherUnits');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const WeatherUnitsSchema = Schema(
  name: r'WeatherUnits',
  id: -2809470454693332931,
  properties: {
    r'pressure': PropertySchema(
      id: 0,
      name: r'pressure',
      type: IsarType.byte,
      enumMap: _WeatherUnitspressureEnumValueMap,
    ),
    r'rainfall': PropertySchema(
      id: 1,
      name: r'rainfall',
      type: IsarType.byte,
      enumMap: _WeatherUnitsrainfallEnumValueMap,
    ),
    r'visibility': PropertySchema(
      id: 2,
      name: r'visibility',
      type: IsarType.byte,
      enumMap: _WeatherUnitsvisibilityEnumValueMap,
    ),
    r'windSpeed': PropertySchema(
      id: 3,
      name: r'windSpeed',
      type: IsarType.byte,
      enumMap: _WeatherUnitswindSpeedEnumValueMap,
    ),
  },
  estimateSize: _weatherUnitsEstimateSize,
  serialize: _weatherUnitsSerialize,
  deserialize: _weatherUnitsDeserialize,
  deserializeProp: _weatherUnitsDeserializeProp,
);

int _weatherUnitsEstimateSize(
  WeatherUnits object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _weatherUnitsSerialize(
  WeatherUnits object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.pressure.index);
  writer.writeByte(offsets[1], object.rainfall.index);
  writer.writeByte(offsets[2], object.visibility.index);
  writer.writeByte(offsets[3], object.windSpeed.index);
}

WeatherUnits _weatherUnitsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WeatherUnits(
    pressure:
        _WeatherUnitspressureValueEnumMap[reader.readByteOrNull(offsets[0])] ??
        PressureUnit.hPa,
    rainfall:
        _WeatherUnitsrainfallValueEnumMap[reader.readByteOrNull(offsets[1])] ??
        RainfallUnit.millimeterForRainAndCentimeterForSnow,
    visibility:
        _WeatherUnitsvisibilityValueEnumMap[reader.readByteOrNull(
          offsets[2],
        )] ??
        VisibilityUnit.metric,
    windSpeed:
        _WeatherUnitswindSpeedValueEnumMap[reader.readByteOrNull(offsets[3])] ??
        WindSpeedUnit.kilometersPerHour,
  );
  return object;
}

P _weatherUnitsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_WeatherUnitspressureValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              PressureUnit.hPa)
          as P;
    case 1:
      return (_WeatherUnitsrainfallValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              RainfallUnit.millimeterForRainAndCentimeterForSnow)
          as P;
    case 2:
      return (_WeatherUnitsvisibilityValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              VisibilityUnit.metric)
          as P;
    case 3:
      return (_WeatherUnitswindSpeedValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              WindSpeedUnit.kilometersPerHour)
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _WeatherUnitspressureEnumValueMap = {
  'hPa': 0,
  'mbar': 1,
  'mmHg': 2,
  'inHg': 3,
};
const _WeatherUnitspressureValueEnumMap = {
  0: PressureUnit.hPa,
  1: PressureUnit.mbar,
  2: PressureUnit.mmHg,
  3: PressureUnit.inHg,
};
const _WeatherUnitsrainfallEnumValueMap = {
  'inchForAll': 0,
  'centimeterForAll': 1,
  'millimeterForRainAndCentimeterForSnow': 2,
};
const _WeatherUnitsrainfallValueEnumMap = {
  0: RainfallUnit.inchForAll,
  1: RainfallUnit.centimeterForAll,
  2: RainfallUnit.millimeterForRainAndCentimeterForSnow,
};
const _WeatherUnitsvisibilityEnumValueMap = {'metric': 0, 'imperial': 1};
const _WeatherUnitsvisibilityValueEnumMap = {
  0: VisibilityUnit.metric,
  1: VisibilityUnit.imperial,
};
const _WeatherUnitswindSpeedEnumValueMap = {
  'metersPerSecond': 0,
  'kilometersPerHour': 1,
  'milesPerHour': 2,
  'knots': 3,
};
const _WeatherUnitswindSpeedValueEnumMap = {
  0: WindSpeedUnit.metersPerSecond,
  1: WindSpeedUnit.kilometersPerHour,
  2: WindSpeedUnit.milesPerHour,
  3: WindSpeedUnit.knots,
};

extension WeatherUnitsQueryFilter
    on QueryBuilder<WeatherUnits, WeatherUnits, QFilterCondition> {
  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  pressureEqualTo(PressureUnit value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pressure', value: value),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  pressureGreaterThan(PressureUnit value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pressure',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  pressureLessThan(PressureUnit value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pressure',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  pressureBetween(
    PressureUnit lower,
    PressureUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pressure',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  rainfallEqualTo(RainfallUnit value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rainfall', value: value),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  rainfallGreaterThan(RainfallUnit value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rainfall',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  rainfallLessThan(RainfallUnit value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rainfall',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  rainfallBetween(
    RainfallUnit lower,
    RainfallUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rainfall',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  visibilityEqualTo(VisibilityUnit value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'visibility', value: value),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  visibilityGreaterThan(VisibilityUnit value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'visibility',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  visibilityLessThan(VisibilityUnit value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'visibility',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  visibilityBetween(
    VisibilityUnit lower,
    VisibilityUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'visibility',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  windSpeedEqualTo(WindSpeedUnit value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'windSpeed', value: value),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  windSpeedGreaterThan(WindSpeedUnit value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'windSpeed',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  windSpeedLessThan(WindSpeedUnit value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'windSpeed',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WeatherUnits, WeatherUnits, QAfterFilterCondition>
  windSpeedBetween(
    WindSpeedUnit lower,
    WindSpeedUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'windSpeed',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension WeatherUnitsQueryObject
    on QueryBuilder<WeatherUnits, WeatherUnits, QFilterCondition> {}
