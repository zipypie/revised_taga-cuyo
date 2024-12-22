import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'package:taga_cuyo/core/utils/string_count.dart';
import 'package:taga_cuyo/core/models/language_model.dart';
import 'package:taga_cuyo/presentation/main/translator/language_switcher.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  LanguagePair languagePair = LanguagePair.defaultPair();

  // Count string
  int _inputCount = 0;
  int _outputCount = 0;

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

  void _swapLanguages() {
    setState(() {
      languagePair.swap(); // Immediately swap the languages.
    });
  }

  void _translateText() {
    // Add your translation logic here, e.g., using an API or local method.
    // For now, let's just display the input text in the output field.
    setState(() {
      _outputController.text = _inputController.text; // Example output
      _outputCount = getStringCount(_outputController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  LanguageSwitcher(
                    languagePair: languagePair,
                    onLanguageSwap: _swapLanguages,
                  ),
                  const SizedBox(height: 20),
                  _inputContainer(context),
                  const SizedBox(height: 20),
                  _outputContainer(context),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 25,
              right: 25,
              child: CustomButton(
                onTab: _translateText, // Call the translation function
                text: 'Translate',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Input container
  Widget _inputContainer(BuildContext context) {
    return Container(
      width: ScreenUtils.getScreenWidth(context),
      height: ScreenUtils.getScreenHeight(context, subtract: 130) * 0.33,
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              languagePair.language1,
              style: TextStyles.h3b,
            ),
            TextField(
              controller: _inputController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: "Input you want to translate here...",
                hintStyle: TextStyle(color: Color.fromARGB(221, 89, 86, 86)),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: AppColors.titleColor,
                      size: 32.0,
                    ),
                    SizedBox(width: 25),
                    Icon(
                      Icons.volume_up,
                      color: AppColors.titleColor,
                      size: 32.0,
                    )
                  ],
                ),
                Text("$_inputCount characters"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Output container
  Widget _outputContainer(BuildContext context) {
    return Container(
      width: ScreenUtils.getScreenWidth(context),
      height: ScreenUtils.getScreenHeight(context, subtract: 130) * 0.33,
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              languagePair.language2,
              style: TextStyles.h3b,
            ),
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
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
                Text("$_outputCount characters"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
