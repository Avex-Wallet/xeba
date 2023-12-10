// ignore_for_file: prefer_void_to_null, unnecessary_new

class GetNftResponse {
  String? status;
  Null total;
  int? page;
  int? pageSize;
  String? cursor;
  List<NftResult>? result;

  GetNftResponse(
      {this.status,
      this.total,
      this.page,
      this.pageSize,
      this.cursor,
      this.result});

  GetNftResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    total = json['total'];
    page = json['page'];
    pageSize = json['page_size'];
    cursor = json['cursor'];
    if (json['result'] != null) {
      result = <NftResult>[];
      json['result'].forEach((v) {
        result!.add(NftResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['total'] = total;
    data['page'] = page;
    data['page_size'] = pageSize;
    data['cursor'] = cursor;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NftResult {
  String? tokenAddress;
  String? tokenId;
  String? contractType;
  String? ownerOf;
  String? blockNumber;
  String? blockNumberMinted;
  String? tokenUri;
  String? metadata;
  Null normalizedMetadata;
  Null mediaLinks;
  String? amount;
  String? name;
  String? symbol;
  String? tokenHash;
  String? lastTokenUriSync;
  String? lastMetadataSync;

  NftResult(
      {this.tokenAddress,
      this.tokenId,
      this.contractType,
      this.ownerOf,
      this.blockNumber,
      this.blockNumberMinted,
      this.tokenUri,
      this.metadata,
      this.normalizedMetadata,
      this.mediaLinks,
      this.amount,
      this.name,
      this.symbol,
      this.tokenHash,
      this.lastTokenUriSync,
      this.lastMetadataSync});

  NftResult.fromJson(Map<String, dynamic> json) {
    tokenAddress = json['token_address'];
    tokenId = json['token_id'];
    contractType = json['contract_type'];
    ownerOf = json['owner_of'];
    blockNumber = json['block_number'];
    blockNumberMinted = json['block_number_minted'];
    tokenUri = json['token_uri'];
    metadata = json['metadata'];
    normalizedMetadata = json['normalized_metadata'];
    mediaLinks = json['media_links'];
    amount = json['amount'];
    name = json['name'];
    symbol = json['symbol'];
    tokenHash = json['token_hash'];
    lastTokenUriSync = json['last_token_uri_sync'];
    lastMetadataSync = json['last_metadata_sync'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token_address'] = tokenAddress;
    data['token_id'] = tokenId;
    data['contract_type'] = contractType;
    data['owner_of'] = ownerOf;
    data['block_number'] = blockNumber;
    data['block_number_minted'] = blockNumberMinted;
    data['token_uri'] = tokenUri;
    data['metadata'] = metadata;
    data['normalized_metadata'] = normalizedMetadata;
    data['media_links'] = mediaLinks;
    data['amount'] = amount;
    data['name'] = name;
    data['symbol'] = symbol;
    data['token_hash'] = tokenHash;
    data['last_token_uri_sync'] = lastTokenUriSync;
    data['last_metadata_sync'] = lastMetadataSync;
    return data;
  }
}
