import 'package:hive/hive.dart';
part 'quotes.g.dart';


@HiveType(typeId:0)

class Quotes extends HiveObject{

  @HiveField(0)
  final String quote;


@HiveField(1)
final String author;

@HiveField(2)
final int characterCount;
@HiveField(3)
 bool used;

Quotes({
  required this.quote,
  required this.author,
  required this.characterCount,
  this.used=false
  

});
bool get isUsed => used;

  static Future<void> fromJson(item) async {}



}