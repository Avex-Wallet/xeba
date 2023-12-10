class GetNftRequest {
  String? address;
  String? chain;
  String? cursor;

  GetNftRequest({this.address, this.chain, this.cursor});

  GetNftRequest.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    chain = json['chain'];
    cursor = json['cursor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['chain'] = chain;
    data['cursor'] = cursor;
    return data;
  }
}
