
import 'package:hive_flutter/hive_flutter.dart';
import 'package:model_add_demo/model/education_model.dart';

class Boxes {
  static Box<EducationModel> getEducationListData() => Hive.box<EducationModel>("educationmodel");
}