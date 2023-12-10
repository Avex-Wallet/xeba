// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTokenModelCollection on Isar {
  IsarCollection<TokenModel> get tokenModels => this.collection();
}

const TokenModelSchema = CollectionSchema(
  name: r'TokenModel',
  id: 6587729607152393036,
  properties: {
    r'accountId': PropertySchema(
      id: 0,
      name: r'accountId',
      type: IsarType.long,
    ),
    r'balance': PropertySchema(
      id: 1,
      name: r'balance',
      type: IsarType.string,
    ),
    r'chainId': PropertySchema(
      id: 2,
      name: r'chainId',
      type: IsarType.long,
    ),
    r'chainName': PropertySchema(
      id: 3,
      name: r'chainName',
      type: IsarType.string,
    ),
    r'contract_address': PropertySchema(
      id: 4,
      name: r'contract_address',
      type: IsarType.string,
    ),
    r'contract_decimals': PropertySchema(
      id: 5,
      name: r'contract_decimals',
      type: IsarType.long,
    ),
    r'contract_name': PropertySchema(
      id: 6,
      name: r'contract_name',
      type: IsarType.string,
    ),
    r'contract_ticker_symbol': PropertySchema(
      id: 7,
      name: r'contract_ticker_symbol',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 8,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'is_spam': PropertySchema(
      id: 9,
      name: r'is_spam',
      type: IsarType.bool,
    ),
    r'last_transferred_at': PropertySchema(
      id: 10,
      name: r'last_transferred_at',
      type: IsarType.string,
    ),
    r'logo_url': PropertySchema(
      id: 11,
      name: r'logo_url',
      type: IsarType.string,
    ),
    r'native_token': PropertySchema(
      id: 12,
      name: r'native_token',
      type: IsarType.bool,
    ),
    r'pretty_quote': PropertySchema(
      id: 13,
      name: r'pretty_quote',
      type: IsarType.string,
    ),
    r'quote': PropertySchema(
      id: 14,
      name: r'quote',
      type: IsarType.double,
    ),
    r'quote_rate': PropertySchema(
      id: 15,
      name: r'quote_rate',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 16,
      name: r'type',
      type: IsarType.string,
    ),
    r'valueInEther': PropertySchema(
      id: 17,
      name: r'valueInEther',
      type: IsarType.double,
    )
  },
  estimateSize: _tokenModelEstimateSize,
  serialize: _tokenModelSerialize,
  deserialize: _tokenModelDeserialize,
  deserializeProp: _tokenModelDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tokenModelGetId,
  getLinks: _tokenModelGetLinks,
  attach: _tokenModelAttach,
  version: '3.1.0+1',
);

int _tokenModelEstimateSize(
  TokenModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.balance.length * 3;
  {
    final value = object.chainName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.contract_address.length * 3;
  bytesCount += 3 + object.contract_name.length * 3;
  bytesCount += 3 + object.contract_ticker_symbol.length * 3;
  bytesCount += 3 + object.last_transferred_at.length * 3;
  bytesCount += 3 + object.logo_url.length * 3;
  bytesCount += 3 + object.pretty_quote.length * 3;
  bytesCount += 3 + object.quote_rate.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _tokenModelSerialize(
  TokenModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.accountId);
  writer.writeString(offsets[1], object.balance);
  writer.writeLong(offsets[2], object.chainId);
  writer.writeString(offsets[3], object.chainName);
  writer.writeString(offsets[4], object.contract_address);
  writer.writeLong(offsets[5], object.contract_decimals);
  writer.writeString(offsets[6], object.contract_name);
  writer.writeString(offsets[7], object.contract_ticker_symbol);
  writer.writeLong(offsets[8], object.hashCode);
  writer.writeBool(offsets[9], object.is_spam);
  writer.writeString(offsets[10], object.last_transferred_at);
  writer.writeString(offsets[11], object.logo_url);
  writer.writeBool(offsets[12], object.native_token);
  writer.writeString(offsets[13], object.pretty_quote);
  writer.writeDouble(offsets[14], object.quote);
  writer.writeString(offsets[15], object.quote_rate);
  writer.writeString(offsets[16], object.type);
  writer.writeDouble(offsets[17], object.valueInEther);
}

TokenModel _tokenModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TokenModel(
    balance: reader.readString(offsets[1]),
    contract_address: reader.readString(offsets[4]),
    contract_decimals: reader.readLong(offsets[5]),
    contract_name: reader.readString(offsets[6]),
    contract_ticker_symbol: reader.readString(offsets[7]),
    is_spam: reader.readBool(offsets[9]),
    last_transferred_at: reader.readString(offsets[10]),
    logo_url: reader.readString(offsets[11]),
    native_token: reader.readBool(offsets[12]),
    pretty_quote: reader.readString(offsets[13]),
    quote: reader.readDouble(offsets[14]),
    quote_rate: reader.readString(offsets[15]),
    type: reader.readString(offsets[16]),
  );
  object.accountId = reader.readLongOrNull(offsets[0]);
  object.chainId = reader.readLongOrNull(offsets[2]);
  object.chainName = reader.readStringOrNull(offsets[3]);
  return object;
}

P _tokenModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tokenModelGetId(TokenModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _tokenModelGetLinks(TokenModel object) {
  return [];
}

void _tokenModelAttach(IsarCollection<dynamic> col, Id id, TokenModel object) {}

extension TokenModelQueryWhereSort
    on QueryBuilder<TokenModel, TokenModel, QWhere> {
  QueryBuilder<TokenModel, TokenModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TokenModelQueryWhere
    on QueryBuilder<TokenModel, TokenModel, QWhereClause> {
  QueryBuilder<TokenModel, TokenModel, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TokenModelQueryFilter
    on QueryBuilder<TokenModel, TokenModel, QFilterCondition> {
  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountId',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> accountIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountId',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accountIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountId',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> accountIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountId',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> accountIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> balanceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      balanceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> balanceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> balanceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'balance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> balanceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> balanceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> balanceContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'balance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> balanceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'balance',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> balanceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'balance',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      balanceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'balance',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> chainIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chainId',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      chainIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chainId',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> chainIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chainId',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      chainIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chainId',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> chainIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chainId',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> chainIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chainId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      chainNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chainName',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      chainNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chainName',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> chainNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chainName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      chainNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chainName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> chainNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chainName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> chainNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chainName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      chainNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chainName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> chainNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chainName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> chainNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chainName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> chainNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chainName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      chainNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chainName',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      chainNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chainName',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_addressEqualTo(
    String value, {
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

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_addressGreaterThan(
    String value, {
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

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_addressLessThan(
    String value, {
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

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_addressBetween(
    String lower,
    String upper, {
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

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
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

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
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

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contract_address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contract_address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract_address',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contract_address',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_decimalsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract_decimals',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_decimalsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contract_decimals',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_decimalsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contract_decimals',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_decimalsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contract_decimals',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contract_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contract_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contract_name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contract_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contract_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contract_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contract_name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract_name',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contract_name',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_ticker_symbolEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract_ticker_symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_ticker_symbolGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contract_ticker_symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_ticker_symbolLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contract_ticker_symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_ticker_symbolBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contract_ticker_symbol',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_ticker_symbolStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contract_ticker_symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_ticker_symbolEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contract_ticker_symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_ticker_symbolContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contract_ticker_symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_ticker_symbolMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contract_ticker_symbol',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_ticker_symbolIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contract_ticker_symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      contract_ticker_symbolIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contract_ticker_symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> is_spamEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'is_spam',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      last_transferred_atEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'last_transferred_at',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      last_transferred_atGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'last_transferred_at',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      last_transferred_atLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'last_transferred_at',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      last_transferred_atBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'last_transferred_at',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      last_transferred_atStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'last_transferred_at',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      last_transferred_atEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'last_transferred_at',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      last_transferred_atContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'last_transferred_at',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      last_transferred_atMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'last_transferred_at',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      last_transferred_atIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'last_transferred_at',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      last_transferred_atIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'last_transferred_at',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> logo_urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logo_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      logo_urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logo_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> logo_urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logo_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> logo_urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logo_url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      logo_urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logo_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> logo_urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logo_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> logo_urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logo_url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> logo_urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logo_url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      logo_urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logo_url',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      logo_urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logo_url',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      native_tokenEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'native_token',
        value: value,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      pretty_quoteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pretty_quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      pretty_quoteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pretty_quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      pretty_quoteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pretty_quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      pretty_quoteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pretty_quote',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      pretty_quoteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pretty_quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      pretty_quoteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pretty_quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      pretty_quoteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pretty_quote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      pretty_quoteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pretty_quote',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      pretty_quoteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pretty_quote',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      pretty_quoteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pretty_quote',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> quoteEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quote',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> quoteGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quote',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> quoteLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quote',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> quoteBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quote',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> quote_rateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quote_rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      quote_rateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quote_rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      quote_rateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quote_rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> quote_rateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quote_rate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      quote_rateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quote_rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      quote_rateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quote_rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      quote_rateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quote_rate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> quote_rateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quote_rate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      quote_rateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quote_rate',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      quote_rateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quote_rate',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      valueInEtherEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valueInEther',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      valueInEtherGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valueInEther',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      valueInEtherLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valueInEther',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      valueInEtherBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valueInEther',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension TokenModelQueryObject
    on QueryBuilder<TokenModel, TokenModel, QFilterCondition> {}

extension TokenModelQueryLinks
    on QueryBuilder<TokenModel, TokenModel, QFilterCondition> {}

extension TokenModelQuerySortBy
    on QueryBuilder<TokenModel, TokenModel, QSortBy> {
  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByChainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainId', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByChainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainId', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByChainName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainName', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByChainNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainName', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByContract_address() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_address', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      sortByContract_addressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_address', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByContract_decimals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_decimals', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      sortByContract_decimalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_decimals', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByContract_name() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_name', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByContract_nameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_name', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      sortByContract_ticker_symbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_ticker_symbol', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      sortByContract_ticker_symbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_ticker_symbol', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByIs_spam() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'is_spam', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByIs_spamDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'is_spam', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      sortByLast_transferred_at() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'last_transferred_at', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      sortByLast_transferred_atDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'last_transferred_at', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByLogo_url() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo_url', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByLogo_urlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo_url', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByNative_token() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'native_token', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByNative_tokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'native_token', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByPretty_quote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pretty_quote', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByPretty_quoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pretty_quote', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByQuote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByQuoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByQuote_rate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote_rate', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByQuote_rateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote_rate', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByValueInEther() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valueInEther', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByValueInEtherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valueInEther', Sort.desc);
    });
  }
}

extension TokenModelQuerySortThenBy
    on QueryBuilder<TokenModel, TokenModel, QSortThenBy> {
  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountId', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByChainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainId', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByChainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainId', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByChainName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainName', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByChainNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainName', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByContract_address() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_address', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      thenByContract_addressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_address', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByContract_decimals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_decimals', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      thenByContract_decimalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_decimals', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByContract_name() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_name', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByContract_nameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_name', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      thenByContract_ticker_symbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_ticker_symbol', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      thenByContract_ticker_symbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contract_ticker_symbol', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByIs_spam() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'is_spam', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByIs_spamDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'is_spam', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      thenByLast_transferred_at() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'last_transferred_at', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy>
      thenByLast_transferred_atDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'last_transferred_at', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByLogo_url() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo_url', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByLogo_urlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo_url', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByNative_token() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'native_token', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByNative_tokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'native_token', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByPretty_quote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pretty_quote', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByPretty_quoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pretty_quote', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByQuote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByQuoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByQuote_rate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote_rate', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByQuote_rateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quote_rate', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByValueInEther() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valueInEther', Sort.asc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByValueInEtherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valueInEther', Sort.desc);
    });
  }
}

extension TokenModelQueryWhereDistinct
    on QueryBuilder<TokenModel, TokenModel, QDistinct> {
  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountId');
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByBalance(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'balance', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByChainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chainId');
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByChainName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chainName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByContract_address(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contract_address',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct>
      distinctByContract_decimals() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contract_decimals');
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByContract_name(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contract_name',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct>
      distinctByContract_ticker_symbol({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contract_ticker_symbol',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByIs_spam() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'is_spam');
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByLast_transferred_at(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'last_transferred_at',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByLogo_url(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logo_url', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByNative_token() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'native_token');
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByPretty_quote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pretty_quote', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByQuote() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quote');
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByQuote_rate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quote_rate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QDistinct> distinctByValueInEther() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valueInEther');
    });
  }
}

extension TokenModelQueryProperty
    on QueryBuilder<TokenModel, TokenModel, QQueryProperty> {
  QueryBuilder<TokenModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<TokenModel, int?, QQueryOperations> accountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountId');
    });
  }

  QueryBuilder<TokenModel, String, QQueryOperations> balanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'balance');
    });
  }

  QueryBuilder<TokenModel, int?, QQueryOperations> chainIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chainId');
    });
  }

  QueryBuilder<TokenModel, String?, QQueryOperations> chainNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chainName');
    });
  }

  QueryBuilder<TokenModel, String, QQueryOperations>
      contract_addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contract_address');
    });
  }

  QueryBuilder<TokenModel, int, QQueryOperations> contract_decimalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contract_decimals');
    });
  }

  QueryBuilder<TokenModel, String, QQueryOperations> contract_nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contract_name');
    });
  }

  QueryBuilder<TokenModel, String, QQueryOperations>
      contract_ticker_symbolProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contract_ticker_symbol');
    });
  }

  QueryBuilder<TokenModel, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<TokenModel, bool, QQueryOperations> is_spamProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'is_spam');
    });
  }

  QueryBuilder<TokenModel, String, QQueryOperations>
      last_transferred_atProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'last_transferred_at');
    });
  }

  QueryBuilder<TokenModel, String, QQueryOperations> logo_urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logo_url');
    });
  }

  QueryBuilder<TokenModel, bool, QQueryOperations> native_tokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'native_token');
    });
  }

  QueryBuilder<TokenModel, String, QQueryOperations> pretty_quoteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pretty_quote');
    });
  }

  QueryBuilder<TokenModel, double, QQueryOperations> quoteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quote');
    });
  }

  QueryBuilder<TokenModel, String, QQueryOperations> quote_rateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quote_rate');
    });
  }

  QueryBuilder<TokenModel, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<TokenModel, double, QQueryOperations> valueInEtherProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valueInEther');
    });
  }
}
