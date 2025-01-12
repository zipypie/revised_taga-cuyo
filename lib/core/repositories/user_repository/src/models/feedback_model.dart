import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final double rating;
  final Map<String, bool> selectedOptions;
  final String comments;
  final Timestamp timestamp;

  FeedbackModel({
    required this.rating,
    required this.selectedOptions,
    required this.comments,
    required this.timestamp,
  });

  // Convert the FeedbackModel object to a map that can be saved to Firestore
  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'selectedOptions': selectedOptions,
      'comments': comments,
      'timestamp': timestamp,
    };
  }

  // Create a FeedbackModel object from a map (used when retrieving data from Firestore)
  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      rating: map['rating']?.toDouble() ?? 0.0,
      selectedOptions: Map<String, bool>.from(map['selectedOptions'] ?? {}),
      comments: map['comments'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }
}
