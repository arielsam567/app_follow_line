class TextFieldModel {
  String key;
  String value;
  bool blocked;

  TextFieldModel({
    this.key = '',
    this.value = '',
    this.blocked = false,
  });

  TextFieldModel.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        blocked = json['blocked'] == true,
        value = json['value'];

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        'blocked': blocked,
      };
}
