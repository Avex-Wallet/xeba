// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNFTModelCollection on Isar {
  IsarCollection<NFTModel> get nFTModels => this.collection();
}

const NFTModelSchema = CollectionSchema(
  name: r'NFTModel',
  id: 5768684949082751669,
  properties: {
    r'audio_properties': PropertySchema(
      id: 0,
      name: r'audio_properties',
      type: IsarType.string,
    ),
    r'audio_url': PropertySchema(
      id: 1,
      name: r'audio_url',
      type: IsarType.string,
    ),
    r'chain': PropertySchema(
      id: 2,
      name: r'chain',
      type: IsarType.string,
    ),
    r'contract': PropertySchema(
      id: 3,
      name: r'contract',
      type: IsarType.object,
      target: r'Contract',
    ),
    r'contract_address': PropertySchema(
      id: 4,
      name: r'contract_address',
      type: IsarType.string,
    ),
    r'created_date': PropertySchema(
      id: 5,
      name: r'created_date',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 6,
      name: r'description',
      type: IsarType.string,
    ),
    r'extra_metadata': PropertySchema(
      id: 7,
      name: r'extra_metadata',
      type: IsarType.object,
      target: r'ExtraMetadata',
    ),
    r'image_properties': PropertySchema(
      id: 8,
      name: r'image_properties',
      type: IsarType.string,
    ),
    r'image_url': PropertySchema(
      id: 9,
      name: r'image_url',
      type: IsarType.string,
    ),
    r'model_properties': PropertySchema(
      id: 10,
      name: r'model_properties',
      type: IsarType.string,
    ),
    r'model_url': PropertySchema(
      id: 11,
      name: r'model_url',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 12,
      name: r'name',
      type: IsarType.string,
    ),
    r'owner_count': PropertySchema(
      id: 13,
      name: r'owner_count',
      type: IsarType.long,
    ),
    r'previews': PropertySchema(
      id: 14,
      name: r'previews',
      type: IsarType.object,
      target: r'Previews',
    ),
    r'status': PropertySchema(
      id: 15,
      name: r'status',
      type: IsarType.string,
    ),
    r'token_count': PropertySchema(
      id: 16,
      name: r'token_count',
      type: IsarType.long,
    ),
    r'token_id': PropertySchema(
      id: 17,
      name: r'token_id',
      type: IsarType.string,
    ),
    r'video_properties': PropertySchema(
      id: 18,
      name: r'video_properties',
      type: IsarType.string,
    ),
    r'video_url': PropertySchema(
      id: 19,
      name: r'video_url',
      type: IsarType.string,
    )
  },
  estimateSize: _nFTModelEstimateSize,
  serialize: _nFTModelSerialize,
  deserialize: _nFTModelDeserialize,
  deserializeProp: _nFTModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'Previews': PreviewsSchema,
    r'Contract': ContractSchema,
    r'ExtraMetadata': ExtraMetadataSchema
  },
  getId: _nFTModelGetId,
  getLinks: _nFTModelGetLinks,
  attach: _nFTModelAttach,
  version: '3.1.0+1',
);

int _nFTModelEstimateSize(
  NFTModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.audio_properties;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.audio_url;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.chain;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.contract;
    if (value != null) {
      bytesCount += 3 +
          ContractSchema.estimateSize(value, allOffsets[Contract]!, allOffsets);
    }
  }
  {
    final value = object.contract_address;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.created_date;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.extra_metadata;
    if (value != null) {
      bytesCount += 3 +
          ExtraMetadataSchema.estimateSize(
              value, allOffsets[ExtraMetadata]!, allOffsets);
    }
  }
  {
    final value = object.image_properties;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.image_url;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.model_properties;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.model_url;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.previews;
    if (value != null) {
      bytesCount += 3 +
          PreviewsSchema.estimateSize(value, allOffsets[Previews]!, allOffsets);
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.token_id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.video_properties;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.video_url;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _nFTModelSerialize(
  NFTModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.audio_properties);
  writer.writeString(offsets[1], object.audio_url);
  writer.writeString(offsets[2], object.chain);
  writer.writeObject<Contract>(
    offsets[3],
    allOffsets,
    ContractSchema.serialize,
    object.contract,
  );
  writer.writeString(offsets[4], object.contract_address);
  writer.writeString(offsets[5], object.created_date);
  writer.writeString(offsets[6], object.description);
  writer.writeObject<ExtraMetadata>(
    offsets[7],
    allOffsets,
    ExtraMetadataSchema.serialize,
    object.extra_metadata,
  );
  writer.writeString(offsets[8], object.image_properties);
  writer.writeString(offsets[9], object.image_url);
  writer.writeString(offsets[10], object.model_properties);
  writer.writeString(offsets[11], object.model_url);
  writer.writeString(offsets[12], object.name);
  writer.writeLong(offsets[13], object.owner_count);
  writer.writeObject<Previews>(
    offsets[14],
    allOffsets,
    PreviewsSchema.serialize,
    object.previews,
  );
  writer.writeString(offsets[15], object.status);
  writer.writeLong(offsets[16], object.token_count);
  writer.writeString(offsets[17], object.token_id);
  writer.writeString(offsets[18], object.video_properties);
  writer.writeString(offsets[19], object.video_url);
}

NFTModel _nFTModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NFTModel(
    audio_properties: reader.readStringOrNull(offsets[0]),
    audio_url: reader.readStringOrNull(offsets[1]),
    chain: reader.readStringOrNull(offsets[2]),
    contract: reader.readObjectOrNull<Contract>(
      offsets[3],
      ContractSchema.deserialize,
      allOffsets,
    ),
    contract_address: reader.readStringOrNull(offsets[4]),
    created_date: reader.readStringOrNull(offsets[5]),
    description: reader.readStringOrNull(offsets[6]),
    extra_metadata: reader.readObjectOrNull<ExtraMetadata>(
      offsets[7],
      ExtraMetadataSchema.deserialize,
      allOffsets,
    ),
    image_properties: reader.readStringOrNull(offsets[8]),
    image_url: reader.readStringOrNull(offsets[9]),
    model_properties: reader.readStringOrNull(offsets[10]),
    model_url: reader.readStringOrNull(offsets[11]),
    name: reader.readStringOrNull(offsets[12]),
    owner_count: reader.readLongOrNull(offsets[13]),
    previews: reader.readObjectOrNull<Previews>(
      offsets[14],
      PreviewsSchema.deserialize,
      allOffsets,
    ),
    status: reader.readStringOrNull(offsets[15]),
    token_count: reader.readLongOrNull(offsets[16]),
    token_id: reader.readStringOrNull(offsets[17]),
    video_properties: reader.readStringOrNull(offsets[18]),
    video_url: reader.readStringOrNull(offsets[19]),
  );
  object.id = id;
  return object;
}

P _nFTModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<Contract>(
        offset,
        ContractSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readObjectOrNull<ExtraMetadata>(
        offset,
        ExtraMetadataSchema.deserialize,
        allOffsets,
      )) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readObjectOrNull<Previews>(
        offset,
        PreviewsSchema.deserialize,
        allOffsets,
      )) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _nFTModelGetId(NFTModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _nFTModelGetLinks(NFTModel object) {
  return [];
}

void _nFTModelAttach(IsarCollection<dynamic> col, Id id, NFTModel object) {
  object.id = id;
}

extension NFTModelQueryWhereSort on QueryBuilder<NFTModel, NFTModel, QWhere> {
  QueryBuilder<NFTModel, NFTModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NFTModelQueryWhere on QueryBuilder<NFTModel, NFTModel, QWhereClause> {
  QueryBuilder<NFTModel, NFTModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<NFTModel, NFTModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NFTModelQueryFilter
    on QueryBuilder<NFTModel, NFTModel, QFilterCondition> {
  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audio_properties',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audio_properties',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audio_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audio_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audio_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audio_properties',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audio_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audio_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audio_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audio_properties',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audio_properties',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_propertiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audio_properties',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> audio_urlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audio_url',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> audio_urlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audio_url',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> audio_urlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audio_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> audio_urlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audio_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> audio_urlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audio_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> audio_urlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audio_url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> audio_urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audio_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> audio_urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audio_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> audio_urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audio_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> audio_urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audio_url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> audio_urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audio_url',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      audio_urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audio_url',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chain',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chain',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chain',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chain',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chain',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> chainIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chain',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> contractIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contract',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> contractIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contract',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contract_address',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contract_address',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract_address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contract_address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contract_address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contract_address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contract_address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contract_address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contract_address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contract_address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract_address',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      contract_addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contract_address',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> created_dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'created_date',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      created_dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'created_date',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> created_dateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'created_date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      created_dateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'created_date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> created_dateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'created_date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> created_dateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'created_date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      created_dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'created_date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> created_dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'created_date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> created_dateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'created_date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> created_dateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'created_date',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      created_dateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'created_date',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      created_dateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'created_date',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      extra_metadataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'extra_metadata',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      extra_metadataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'extra_metadata',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image_properties',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image_properties',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image_properties',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image_properties',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image_properties',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_propertiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image_properties',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> image_urlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image_url',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> image_urlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image_url',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> image_urlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> image_urlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> image_urlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> image_urlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image_url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> image_urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> image_urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> image_urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> image_urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image_url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> image_urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image_url',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      image_urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image_url',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'model_properties',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'model_properties',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'model_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'model_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'model_properties',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'model_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'model_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'model_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'model_properties',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model_properties',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_propertiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'model_properties',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> model_urlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'model_url',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> model_urlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'model_url',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> model_urlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> model_urlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'model_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> model_urlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'model_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> model_urlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'model_url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> model_urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'model_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> model_urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'model_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> model_urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'model_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> model_urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'model_url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> model_urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model_url',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      model_urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'model_url',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> owner_countIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'owner_count',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      owner_countIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'owner_count',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> owner_countEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'owner_count',
        value: value,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      owner_countGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'owner_count',
        value: value,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> owner_countLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'owner_count',
        value: value,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> owner_countBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'owner_count',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> previewsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'previews',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> previewsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'previews',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_countIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'token_count',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      token_countIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'token_count',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_countEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'token_count',
        value: value,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      token_countGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'token_count',
        value: value,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_countLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'token_count',
        value: value,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_countBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'token_count',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'token_id',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'token_id',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'token_id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'token_id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'token_id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'token_id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'token_id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'token_id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'token_id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'token_id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'token_id',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> token_idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'token_id',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'video_properties',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'video_properties',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'video_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'video_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'video_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'video_properties',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'video_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'video_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'video_properties',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'video_properties',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'video_properties',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_propertiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'video_properties',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> video_urlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'video_url',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> video_urlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'video_url',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> video_urlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'video_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> video_urlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'video_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> video_urlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'video_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> video_urlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'video_url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> video_urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'video_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> video_urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'video_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> video_urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'video_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> video_urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'video_url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> video_urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'video_url',
        value: '',
      ));
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition>
      video_urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'video_url',
        value: '',
      ));
    });
  }
}

extension NFTModelQueryObject
    on QueryBuilder<NFTModel, NFTModel, QFilterCondition> {
  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> contract(
      FilterQuery<Contract> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'contract');
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> extra_metadata(
      FilterQuery<ExtraMetadata> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'extra_metadata');
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterFilterCondition> previews(
      FilterQuery<Previews> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'previews');
    });
  }
}

extension NFTModelQueryLinks
    on QueryBuilder<NFTModel, NFTModel, QFilterCondition> {}

extension NFTModelQuerySortBy on QueryBuilder<NFTModel, NFTModel, QSortBy> {
  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByAudio_properties() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audio_properties', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByAudio_propertiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audio_properties', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByAudio_url() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audio_url', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByAudio_urlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audio_url', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByChain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chain', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByChainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chain', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByContract_address() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_address', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByContract_addressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_address', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByCreated_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_date', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByCreated_dateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_date', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByImage_properties() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image_properties', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByImage_propertiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image_properties', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByImage_url() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image_url', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByImage_urlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image_url', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByModel_properties() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model_properties', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByModel_propertiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model_properties', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByModel_url() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model_url', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByModel_urlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model_url', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByOwner_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner_count', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByOwner_countDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner_count', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByToken_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token_count', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByToken_countDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token_count', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByToken_id() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token_id', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByToken_idDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token_id', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByVideo_properties() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'video_properties', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByVideo_propertiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'video_properties', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByVideo_url() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'video_url', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> sortByVideo_urlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'video_url', Sort.desc);
    });
  }
}

extension NFTModelQuerySortThenBy
    on QueryBuilder<NFTModel, NFTModel, QSortThenBy> {
  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByAudio_properties() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audio_properties', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByAudio_propertiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audio_properties', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByAudio_url() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audio_url', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByAudio_urlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audio_url', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByChain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chain', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByChainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chain', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByContract_address() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_address', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByContract_addressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_address', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByCreated_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_date', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByCreated_dateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created_date', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByImage_properties() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image_properties', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByImage_propertiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image_properties', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByImage_url() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image_url', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByImage_urlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image_url', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByModel_properties() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model_properties', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByModel_propertiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model_properties', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByModel_url() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model_url', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByModel_urlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model_url', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByOwner_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner_count', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByOwner_countDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'owner_count', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByToken_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token_count', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByToken_countDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token_count', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByToken_id() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token_id', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByToken_idDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token_id', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByVideo_properties() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'video_properties', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByVideo_propertiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'video_properties', Sort.desc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByVideo_url() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'video_url', Sort.asc);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QAfterSortBy> thenByVideo_urlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'video_url', Sort.desc);
    });
  }
}

extension NFTModelQueryWhereDistinct
    on QueryBuilder<NFTModel, NFTModel, QDistinct> {
  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByAudio_properties(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audio_properties',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByAudio_url(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audio_url', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByChain(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chain', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByContract_address(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contract_address',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByCreated_date(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'created_date', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByImage_properties(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image_properties',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByImage_url(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image_url', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByModel_properties(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'model_properties',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByModel_url(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'model_url', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByOwner_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'owner_count');
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByToken_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'token_count');
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByToken_id(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'token_id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByVideo_properties(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'video_properties',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NFTModel, NFTModel, QDistinct> distinctByVideo_url(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'video_url', caseSensitive: caseSensitive);
    });
  }
}

extension NFTModelQueryProperty
    on QueryBuilder<NFTModel, NFTModel, QQueryProperty> {
  QueryBuilder<NFTModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> audio_propertiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audio_properties');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> audio_urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audio_url');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> chainProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chain');
    });
  }

  QueryBuilder<NFTModel, Contract?, QQueryOperations> contractProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contract');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> contract_addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contract_address');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> created_dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'created_date');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<NFTModel, ExtraMetadata?, QQueryOperations>
      extra_metadataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'extra_metadata');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> image_propertiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image_properties');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> image_urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image_url');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> model_propertiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'model_properties');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> model_urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'model_url');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<NFTModel, int?, QQueryOperations> owner_countProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'owner_count');
    });
  }

  QueryBuilder<NFTModel, Previews?, QQueryOperations> previewsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'previews');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<NFTModel, int?, QQueryOperations> token_countProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'token_count');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> token_idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'token_id');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> video_propertiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'video_properties');
    });
  }

  QueryBuilder<NFTModel, String?, QQueryOperations> video_urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'video_url');
    });
  }
}
