import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:model_add_demo/box/boxs.dart';
import 'package:model_add_demo/model/education_model.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {

  EducationModel? educationModel;


  TextEditingController educationNameCTR = TextEditingController();
  TextEditingController educationYearCTR = TextEditingController();
  TextEditingController instituteCTR = TextEditingController();

  FocusNode educationNameFocus = FocusNode();
  FocusNode educationYearFocus = FocusNode();
  FocusNode instituteFocus = FocusNode();

  @override
  void dispose() {
    Hive.box("educationmodel").close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic Education List"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: educationNameCTR,
                    decoration: const InputDecoration(
                      hintText: "Education Type"
                    ),
                    onChanged: (value){
                      setState(() {
                        educationModel?.educationTypeCTR = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: educationYearCTR,
                    decoration: const InputDecoration(
                        hintText: "Education Year"
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value){
                      setState(() {
                        educationModel?.educationYearCTR = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: instituteCTR,
                    decoration: const InputDecoration(
                        hintText: "Education Institute"
                    ),
                    onChanged: (value){
                      setState(() {
                        educationModel?.instituteNameCTR = value;
                      });
                    },
                  ),

                  const SizedBox(height: 50,),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: (educationNameCTR.text != '' && educationYearCTR.text != '' && instituteCTR.text != '') ? Colors.indigo : Colors.grey
                    ),
                      onPressed: (){
                      setState(() {
                        if(educationNameCTR.text != '' && educationYearCTR.text != '' && instituteCTR.text != ''){
                          /// Add Data Into List
                          addDataIntoModel();

                          /// Clear Text Field
                          educationNameCTR.clear();
                          educationYearCTR.clear();
                          instituteCTR.clear();
                        }
                      });
                      }, child: const Text("Add"))
                ],
              ),
            ),

            const SizedBox(height: 20,),
            ValueListenableBuilder<Box<EducationModel>>(
              valueListenable: Boxes.getEducationListData().listenable(),
              builder: (context, box, _) {
                final educationList = box.values.toList().cast<EducationModel>();
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index){
                    return const SizedBox(height: 20,);
                  },
                  itemBuilder: (context, i) {
                    String educationType = educationList[i].educationTypeCTR;
                    String educationYear = educationList[i].educationYearCTR;
                    String instituteName = educationList[i].instituteNameCTR;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20,),
                                    Text("Degree: $educationType", style: const TextStyle(fontSize: 16,color: Colors.black87, fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 20,),
                                    Text("Year: $educationYear", style: const TextStyle(fontSize: 16,color: Colors.black87, fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 20,),
                                    Text("Institute: $instituteName", style: const TextStyle(fontSize: 16,color: Colors.black87, fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  /// Delete
                                  educationList[i].delete();
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration:  BoxDecoration(
                                  color: Colors.red,borderRadius: BorderRadius.circular(25)
                                ),
                                  child:const Center(child:  Icon(Icons.remove,size: 25, color: Colors.white),)),
                            ),
                            const SizedBox(width: 20)
                          ],
                        ),
                      ),
                    );
                  }, itemCount: educationList.length,
                );
              }
            ),
          ],
        ),
      ),
    );
  }


  addDataIntoModel(){
    final educationModel = EducationModel()
      ..educationTypeCTR = educationNameCTR.text
      ..educationYearCTR = educationYearCTR.text
      ..instituteNameCTR = instituteCTR.text;

      final box = Boxes.getEducationListData();
      box.add(educationModel);

  }
}
