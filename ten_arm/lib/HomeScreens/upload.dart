import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ten_arm/Persistent/persistent.dart';
import 'package:ten_arm/Widgets/button_nav_bar.dart';

class Upload extends StatefulWidget {
  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final TextEditingController _jobCategoryController =
      TextEditingController(text: "Choose your college/University");

  final TextEditingController _jobtitleController = TextEditingController();

  final TextEditingController _jobDescriptionController =
      TextEditingController();

  final TextEditingController _jobDeadlineController =
      TextEditingController(text: "Project Deadline Date");

  final _formkey = GlobalKey<FormState>();
  DateTime? picked;
  Timestamp? deadlineDateTimeStamp;
  bool _isLoading = false;

  Widget _textTitles({required String label}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        label,
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _textFormFields({
    required String valueKey,
    required TextEditingController controller,
    required bool enabled,
    required Function fct,
    required int maxLength,
    InputDecoration? decoration, // Optional parameter for decoration
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          fct();
        },
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Value is missing";
            }
            return null;
          },
          controller: controller,
          enabled: enabled,
          key: ValueKey(valueKey),
          style: const TextStyle(color: Colors.white),
          maxLines: valueKey == "JobDescription" ? 2 : 1,
          maxLength: maxLength,
          keyboardType: TextInputType.text,
          decoration: decoration ??
              const InputDecoration(
                filled: true,
                fillColor: Colors.black54,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
        ),
      ),
    );
  }

  _showTaskCategoriesDialog({required Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: const Text(
              "Student Preferences",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: Persistent.jobCategoryList.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _jobCategoryController.text =
                            Persistent.jobCategoryList[index];
                      });

                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_right_outlined,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            Persistent.jobCategoryList[index],
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ))
            ],
          );
        });
  }

  void _pickDateDialog() async{
picked = await showDatePicker(context: context,
 initialDate: DateTime.now(), 
 firstDate: DateTime.now().subtract(
  const Duration(days:0),
 ),
 lastDate: DateTime(2100),
 );
 if(picked!=null){
     setState(() {
       _jobDeadlineController.text="${picked!.year} - ${picked!.month} - ${picked!.day}";
       deadlineDateTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(picked!.microsecondsSinceEpoch);

     });
 }
 
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo.shade400,
            Colors.cyan.shade200,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: ButtonNavBar(indexNum: 2),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(7),
            child: Card(
              color: Colors.white10,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Please fill all Fields",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textTitles(label: "Student Preferences"),
                            _textFormFields(
                              valueKey: 'StudentPreferences',
                              controller: _jobCategoryController,
                              enabled: false,
                              fct: () {
                                _showTaskCategoriesDialog(size: size);
                              },
                              maxLength: 50,
                            ),
                            _textTitles(label: "Project Title:"),
                            _textFormFields(
                                valueKey: "ProjectTitle",
                                controller: _jobtitleController,
                                enabled: true,
                                fct: () {},
                                maxLength: 50),
                            _textTitles(label: "Project Description :"),
                            _textFormFields(
                                valueKey: "JobDescription",
                                controller: _jobDescriptionController,
                                enabled: true,
                                fct: () {},
                                maxLength: 100),
                            _textTitles(label: "Project Deadline Date :"),
                            _textFormFields(
                              valueKey: "JobDeadline",
                              controller: _jobDeadlineController,
                              enabled: false,
                              fct: () {
                                _pickDateDialog();
                              },
                              maxLength: 50,
                              decoration: const InputDecoration(
                                hintText: "Enter the deadline date",
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.black54,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : MaterialButton(
                                onPressed: () {},
                                color: Colors.black,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Upload",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      Icon(
                                        Icons.upload,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
