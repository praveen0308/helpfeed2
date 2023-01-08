import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/models/review_model.dart';
import 'package:helpfeed2/ui/post_review/post_review_cubit.dart';
import 'package:helpfeed2/ui/registration/basic_detail/basic_details_cubit.dart';
import 'package:helpfeed2/utils/toaster.dart';

class PostReview extends StatefulWidget {
  const PostReview({Key? key}) : super(key: key);

  @override
  State<PostReview> createState() => _PostReviewState();
}

class _PostReviewState extends State<PostReview> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Post A Review"),
      ),
      body: BlocConsumer<PostReviewCubit, PostReviewState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Donor Name"),
                TextFormField(
                  controller: _title,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text("Your Review"),
                TextFormField(
                  controller: _description,
                  keyboardType: TextInputType.name,
                  maxLines: 8,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                const Spacer(),
                if(state is! PostingReview)ElevatedButton(onPressed: (){
                  BlocProvider.of<PostReviewCubit>(context).addReview(ReviewModel(
                    title: _title.text,
                    description: _description.text,
                    addedOn: DateTime.now().millisecondsSinceEpoch,

                  ));
                }, child: const Text("Post")),
                if(state is PostingReview) const Center(child: CircularProgressIndicator(),)

              ],
            ),
          );
        },
        listener: (context, state) {
          if(state is PostedSuccessfully){
            showToast("Review posted successfully!!!",ToastType.success);
            Navigator.pop(context,true);
          }

        },
      ),
    ));
  }
}
