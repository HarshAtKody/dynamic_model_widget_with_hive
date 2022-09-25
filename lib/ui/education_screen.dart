import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_add_demo/model/education_model.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {


  List<EducationModel> educationList = [];
  EducationModel? educationModel;


  TextEditingController educationNameCTR = TextEditingController();
  TextEditingController educationYearCTR = TextEditingController();
  TextEditingController instituteCTR = TextEditingController();

  FocusNode educationNameFocus = FocusNode();
  FocusNode educationYearFocus = FocusNode();
  FocusNode instituteFocus = FocusNode();

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
                          educationList.add(EducationModel(educationNameCTR.text, educationYearCTR.text, instituteCTR.text));

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
            Visibility(
              visible: educationList.isNotEmpty,
              child: ListView.separated(
                physics:const NeverScrollableScrollPhysics(),
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
                            child: Column(
                              children: [
                                const SizedBox(height: 20,),
                                Text(educationType, style: const TextStyle(fontSize: 16,color: Colors.black87),),
                                const SizedBox(height: 20,),
                                Text(educationYear, style: const TextStyle(fontSize: 16,color: Colors.black87),),
                                const SizedBox(height: 20,),
                                Text(instituteName, style: const TextStyle(fontSize: 16,color: Colors.black87),),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                educationList.removeAt(i);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
