import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'package:taga_cuyo/core/utils/string_count.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  //count string
  int _inputCount = 0;
  final int _outputCount = 0;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      setState(() {
        _inputCount = getStringCount(_inputController.text);
      });
    });
  }

  @override
  void dispose() {
    _inputController.dispose(); // Dispose controllers to avoid memory leaks
    _outputController.dispose(); // Dispose the output controller as well
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  _inputContainer(context),
                  SizedBox(height: 20),
                  _outputContainer(context),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 25,
              right: 25,
              child: CustomButton(
                onTab: () {},
                text: 'Translate',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Using the utility function to get the screen width
  Widget _inputContainer(BuildContext context) {
    return Container(
        width: ScreenUtils.getScreenWidth(context),
        decoration: BoxDecoration(
            color: AppColors.accentColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: _inputController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: "Ilagay ang gustong malaman...",
                  hintStyle: TextStyle(color: Color.fromARGB(221, 89, 86, 86)),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: AppColors.titleColor, // Set the icon color
                    size: 32.0, // Set the icon size
                  ),
                  Text("$_inputCount characters")
                ],
              )
            ],
          ),
        ));
  }

  // Using the utility function to get the screen width
  Widget _outputContainer(BuildContext context) {
    return Container(
        width: ScreenUtils.getScreenWidth(context),
        decoration: BoxDecoration(
            color: AppColors.accentColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: _outputController,
                readOnly: true,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: "Output will be displayed here...",
                  hintStyle: TextStyle(color: Color.fromARGB(221, 89, 86, 86)),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.copy_rounded,
                        color: AppColors.titleColor, // Set the icon color
                        size: 32.0, // Set the icon size
                      ),
                      SizedBox(width: 25),
                      Icon(
                        Icons.volume_up_rounded,
                        color: AppColors.titleColor, // Set the icon color
                        size: 32.0, // Set the icon size
                      ),
                    ],
                  ),
                  Text("$_outputCount characters")
                ],
              )
            ],
          ),
        ));
  }
}
