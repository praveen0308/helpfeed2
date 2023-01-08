import 'package:flutter/material.dart';
import 'package:helpfeed2/models/review_model.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;

  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(review.title.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
          Text(review.description!),
          const SizedBox(height: 8,),
          Row(
            children: [
              const Icon(Icons.timelapse),
              Text(review.getAddedOn()),
              const Spacer(),
              Text("by ${review.name}")
            ],
          ),

        ],
      ),
    );
  }
}
