

import 'package:hive/hive.dart';
part 'education_model.g.dart';

@HiveType(typeId: 0)
class EducationModel extends HiveObject {

  @HiveField(0)
  late final String educationTypeCTR;
  @HiveField(1)
  late final String educationYearCTR;
  @HiveField(2)
  late final String instituteNameCTR;

  // EducationModel(this.educationTypeCTR, this.educationYearCTR, this.instituteNameCTR);


}