

import 'package:educanapp/views/success/success.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';
import '../../controller/sign_up_controller.dart';

class OrderLesson extends StatefulWidget {
  const OrderLesson({Key? key}) : super(key: key);

  @override
  State<OrderLesson> createState() => _OrderLessonState();
}


class _OrderLessonState extends State<OrderLesson> {
  int currentStep = 0;
  bool isCompleted = false;
  final location = TextEditingController();
  final timec = TextEditingController();
  final clas = TextEditingController();
  final subject = TextEditingController();
  final attend = TextEditingController();
  final chours = TextEditingController();
  final topic = TextEditingController();
  final mode = TextEditingController();
  bool _isRadioSelected = true;
  String _pname = '';

  var result;
  final controller = SignUpController();
  var f = NumberFormat("###,###", "en_US");
  @override
  void initState() {
    super.initState();
    mode.text ="Physical";
    _loadCounterx();
  }
  _loadCounterx() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pname = (prefs.getString('uid') ?? '');

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lesson Order"),
        centerTitle: true,
        backgroundColor:  const Color(0xFF1A8F00),
      ),
      body: isCompleted
          ? Success(sub: "Your Order has been submitted Successfully!",)
          : Theme(
              data: Theme.of(context).copyWith(
                  colorScheme:
                      const ColorScheme.light(primary: Color(0xFF1A8F00))),
              child: Stepper(
                type: StepperType.horizontal,
                steps: getSteps(),
                currentStep: currentStep,
                onStepTapped: (step) => setState(() => currentStep = step),
                onStepContinue: () async{
                  final isLastStep = currentStep == getSteps().length - 1;
                  if (isLastStep) {
                    setState(() => isCompleted = true);
                    // print('Completed');

                    result = await controller.postLessonOrder(_pname,mode.text,location.text,clas.text,subject.text,topic.text,attend.text,chours.text,timec.text);


                    //send data to server
                  } else {
                    setState(() => currentStep += 1);
                  }
                },
                onStepCancel: currentStep == 0
                    ? null
                    : () {
                        setState(() => currentStep -= 1);
                      },
                controlsBuilder: (context, ControlsDetails controls) {
                  final isLastStep = currentStep == getSteps().length - 1;
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controls.onStepContinue,
                            child: Text(isLastStep ? "Submit" : "Proceed"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (currentStep != 0)
                          Expanded(
                              child: ElevatedButton(
                            onPressed: controls.onStepCancel,
                            child: const Text("Back"),
                          )),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text("Details"),
          content: Column(
            children: <Widget>[
              const Text("Enter your Lesson Details below :"),
              const SizedBox(height: 6,),
              const Text("Mode of Delivery (Physical or Virtual)"),
              const SizedBox(height: 3,),
              LabeledRadio(
                label: 'Virtual Lesson',
                descr: 'Via Zoom',
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                value: false,
                groupValue: _isRadioSelected,
                onChanged: (bool newValue) {
                  setState(() {
                    _isRadioSelected = newValue;
                    mode.text ="Virtual";
                  });
                },
              ),
              LabeledRadio(
                label: 'Physical Lesson',
                descr: 'Meet Teacher Physically',
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                value: true,
                groupValue: _isRadioSelected,
                onChanged: (bool newValue) {
                  setState(() {
                    _isRadioSelected = newValue;
                    mode.text ="Physical";
                  });
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      controller: location,
                      decoration: const InputDecoration(labelText: 'Location'),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: timec,
                      decoration: const InputDecoration(labelText: 'Time (e.g 8:00 AM)'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: clas,
                      decoration: const InputDecoration(labelText: 'Class'),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: TextFormField(
                      controller: subject,
                      decoration: const InputDecoration(labelText: 'Subject'),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: topic,
                      decoration: const InputDecoration(labelText: 'Topic / Chapter / Concept'),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: attend,
                      decoration: const InputDecoration(labelText: 'No. of Attendees'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: chours,
                      decoration: const InputDecoration(labelText: 'Number of Contact Hours (e.g 5)'),
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text("Payment"),
          content: Column(
            children: const [
              Text("Please note that our Lessons are billed per hour as follows :",),
              SizedBox(height: 6,),
              Text("1 to 3 Students"),
              SizedBox(height: 3,),
              Text("Virtual Lesson : UGX 20,000 per student\nPhysical Lesson : UGX 40,000 per student"),
              SizedBox(height: 6,),
              Text("More than 3 Students"),
              SizedBox(height: 3,),
              Text("Virtual Lesson : UGX 10,000 per student\nPhysical Lesson : UGX 20,000 per student"),

            ],
          ),
        ),
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text("Submit"),
          content: Column(
            children:  [
              const Text("Lesson Order Summary :",),
              const SizedBox(height: 6,),
              Text("Mode of Delivery: ${mode.text}"),
              const SizedBox(height: 3,),
              Text("Time: ${timec.text}"),
              const SizedBox(height: 3,),
              Text("Class: ${clas.text}"),
              const SizedBox(height: 3,),
              Text("Subject: ${subject.text}"),
              const SizedBox(height: 3,),
              Text("Topic: ${topic.text}"),
              const SizedBox(height: 3,),
              Text("Number of Attendees: ${attend.text}"),
              const SizedBox(height: 3,),
              Text("Hours: ${chours.text}"),
              const Divider(
                  color: Color(0xFF1A8F00)
              ),
              const SizedBox(height: 3,),

              Text("Amount Per Student: UGX "+f.format(int.parse(getAmount(attend.text==""?int.parse("0"):int.parse(attend.text), mode.text)))),
              const SizedBox(height: 3,),
              Text("Total Amount: UGX "+f.format(int.parse(getTotalAmount(attend.text==""?int.parse("0"):int.parse(attend.text), mode.text,chours.text==""?int.parse("0"):int.parse(chours.text))))),
              const Divider(
                  color: Color(0xFF1A8F00)
              ),
              const SizedBox(height: 3,),
              Text("Please note that these fees are inclusive of lesson notes, exercises, marking and any other support materials for a successful lesson delivery.",overflow: TextOverflow.ellipsis,maxLines: 3,),
            ],
          ),
        ),
        // Step(
        //   state: currentStep > 0 ? StepState.complete : StepState.indexed,
        //   isActive: currentStep >= 3,
        //   title: const Text("Success"),
        //   content: Container(),
        // ),
      ];
}

getAmount(int attend , String mode){
  int amp;
  if(mode == "Virtual") {
    if (attend >= 1 && attend <= 3) {
amp = 20000;
    } else {
amp = 10000;
    }
  }else {
    if (attend >= 1 && attend <= 3) {
amp = 40000;
    } else {
amp = 20000;
    }
  }
  return amp.toString();
}

getTotalAmount(int attend , String mode,int sx){
  int amp;
  int tot;
  if(mode == "Virtual") {
    if (attend >= 1 && attend <= 3) {
      amp = 20000;
      tot = amp *attend*sx;
    } else {
      amp = 10000;
      tot = amp *attend*sx;
    }
  }else {
    if (attend >= 1 && attend <= 3) {
      amp = 40000;
      tot = amp *attend*sx;
    } else {
      amp = 20000;
      tot = amp *attend*sx;
    }
  }
  return tot.toString();
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.descr,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final String descr;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
            Column(
              children: [
                Text(label),
                Text(descr),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

