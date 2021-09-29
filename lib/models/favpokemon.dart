import 'package:hive/hive.dart';
part 'favpokemon.g.dart';

@HiveType(typeId: 1)
class Favpokemon extends HiveObject {
  @HiveField(4)
  int index;

  @HiveField(2)
  String name;

  @HiveField(3)
  List<String> types;

  Favpokemon(this.index, this.name, this.types);

  @override
  toString() => '$name';
}
