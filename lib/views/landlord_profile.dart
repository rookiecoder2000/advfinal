import 'package:flutter/material.dart';

class LandlordProfile extends StatefulWidget {
  LandlordProfile({Key? key}) : super(key: key);

  @override
  State<LandlordProfile> createState() => _LandlordProfileState();
}

//if not verified then stepper if verified return edit2
class _LandlordProfileState extends State<LandlordProfile> {
  bool isCompleted = false;
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text("Verification Process"),
      ),
      body: isCompleted
          ? verificationCompleted()
          : Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  //set verification status
                  setState(() {
                    isCompleted = true;
                  });
                  print("Completed");
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepCancel: () {
                setState(() {
                  if (currentStep == 0) {
                  } else {
                    currentStep -= 1;
                  }
                });
                //   currentStep == 0 ? null : () => setState(() => currentStep -= 1);
              },
            ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: Text("Account"),
            content: Column(
              children: [
                Text("HATDOG"),
                SizedBox(
                  height: 50,
                )
              ],
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text("SAD"),
            content: Column(
              children: [Text("chEESEDOG")],
            )),
        Step(
            isActive: currentStep >= 2,
            title: Text("Credentials"),
            content: Column(
              children: [Text("nanay mo sabog")],
            ))
      ];

  Widget verificationCompleted() {
    return Container(
      child:
          Text("Congratulations your account has been successfully verified!"),
    );
  }
}
