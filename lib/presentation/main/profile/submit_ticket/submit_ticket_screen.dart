import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taga_cuyo/core/common_widgets/animations/splash_animation.dart';
import 'package:taga_cuyo/core/common_widgets/popup%20displays/snackbar.dart';
import 'package:taga_cuyo/core/common_widgets/textfields/big_textfield.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/models/device_info.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/my_user.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/submit_ticket_model.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import '../../../../core/cubit/submit_ticket_cubit/submit_ticket_cubit.dart';

class SubmitTicketScreen extends StatefulWidget {
  const SubmitTicketScreen({super.key});

  @override
  SubmitTicketScreenState createState() => SubmitTicketScreenState();
}

class SubmitTicketScreenState extends State<SubmitTicketScreen> {
  final TextEditingController _issueController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false; // To manage loading state
  bool isSuccess = false; // To manage success animation display

  // Pick an image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Submit the ticket
  void _submitTicket() async {
    if (_issueController.text.isEmpty) {
      showSnackBar(context, "Please describe the issue.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final currentUser = await _fetchCurrentUser();
    if (currentUser == null) return;

    try {
      // Collecting necessary details for the ticket
      final ticket = SubmitTicketModel(
        firstName: currentUser.firstName,
        lastName: currentUser.lastName,
        email: currentUser.email,
        issue: _issueController.text,
        imageIssue: _selectedImage?.path,
        timeStamp: DateTime.now().toString(),
        deviceInfo: await _getDeviceDetails(),
      );

      // Using the SubmitTicketCubit to submit the ticket
      context.read<SubmitTicketCubit>().submitTicket(ticket);
    } catch (e) {
      showSnackBar(context, "Failed to submit ticket: ${e.toString()}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fetch the current user
  Future<MyUser?> _fetchCurrentUser() async {
    try {
      final currentUserId =
          context.read<SubmitTicketCubit>().userRepository.getCurrentUserId();
      if (currentUserId == null) {
        showSnackBar(context, "No user is logged in.");
        return null;
      }
      return await context.read<UserRepository>().getMyUser(currentUserId);
    } catch (e) {
      log("Failed to fetch user: ${e.toString()}");
      return null;
    }
  }

  // Get the device details
  Future<String> _getDeviceDetails() async {
    try {
      return await DeviceInfoService().getDeviceDetails();
    } catch (e) {
      return "Unknown device";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit a Ticket', style: TextStyles.h1b),
        centerTitle: true,
      ),
      body: BlocListener<SubmitTicketCubit, SubmitTicketState>(
        listener: (context, state) {
          if (state is SubmitTicketFailure) {
            showSnackBar(context, state.error);
          } else if (state is SubmitTicketSuccess) {
            setState(() {
              isSuccess = true; // Trigger animation after success
            });
            showSnackBar(context, "Ticket submitted successfully!");
            // Optionally, navigate to another screen after a delay or reset the form
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                isSuccess = false; // Hide animation after a short time
              });
            });
          }
        },
        child: Stack(
          children: [
            // Main content
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Need help? ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.titleColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Please fill out the form below with as much detail as possible in order to submit a ticket. "
                      "This will help us understand the issue you're facing and assist you more efficiently. ",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    BigTextfield(
                      controller: _issueController,
                      hintText: 'Describe the issue with the app',
                      maxLines: 7,
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 20),

                    // Image Picker Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Add Image:",
                            style: TextStyle(fontSize: 16)),
                        IconButton(
                          icon:
                              Icon(Icons.add_a_photo, color: AppColors.primary),
                          onPressed: _pickImage,
                        ),
                      ],
                    ),

                    // Display the selected image
                    if (_selectedImage != null)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    const SizedBox(height: 30),

                    // Submit Button
                    CustomButton(
                      onTab: isLoading
                          ? () {}
                          : _submitTicket, // Disable during loading
                      text: isLoading ? 'Submitting...' : 'Submit Ticket',
                    ),
                  ],
                ),
              ),
            ),
            // Confetti Animation, centered in the Stack
            if (isSuccess)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: SplashAnimation.confetti(
                    height: ScreenUtils.getScreenHeight(context),
                    width: ScreenUtils.getScreenWidth(context),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
