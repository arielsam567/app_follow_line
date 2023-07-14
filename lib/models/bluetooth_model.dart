class BluetoothModel{
  final String name;
  final String id;
  int? rssi;


  BluetoothModel({
    required this.name,
    required this.id,
    this.rssi,
  });

}