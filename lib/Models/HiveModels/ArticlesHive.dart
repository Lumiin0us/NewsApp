import 'package:hive/hive.dart';
part 'ArticlesHive.g.dart';

@HiveType(typeId: 0)
class ArticlesHive extends HiveObject
{
  @HiveField(0)
  String title;

  @HiveField(1)
  String description; 

  ArticlesHive({required this.title, required this.description});
}

