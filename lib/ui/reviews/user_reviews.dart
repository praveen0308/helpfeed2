import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/res/app_colors.dart';
import 'package:helpfeed2/ui/registration/basic_detail/basic_details_cubit.dart';
import 'package:helpfeed2/ui/reviews/user_reviews_cubit.dart';
import 'package:helpfeed2/widgets/review_widget.dart';

class UserReviews extends StatefulWidget {
  const UserReviews({Key? key}) : super(key: key);

  @override
  State<UserReviews> createState() => _UserReviewsState();
}

class _UserReviewsState extends State<UserReviews> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: BlocConsumer<UserReviewsCubit, UserReviewsState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NoReviews) {
            return const Center(
              child: Text("No Reviews"),
            );
          }
          if (state is ReceivedReviews) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.reviews.length,
                itemBuilder: (context, index) {
                  return ReviewWidget(review: state.reviews[index]);
                });
          }

          return Container();
        },
        listener: (context, state) {},
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var res = await Navigator.pushNamed(context, "/postReview");
          if(res==true){
            BlocProvider.of<UserReviewsCubit>(context).fetchReviews();
          }
        },
        label: const Text("Review",style: TextStyle(color: Colors.white),),
        icon: const Icon(Icons.add,color: Colors.white),

        backgroundColor: AppColors.primaryDarkest,
      ),
    ));
  }

  @override
  void initState() {
    BlocProvider.of<UserReviewsCubit>(context).fetchReviews();
    super.initState();
  }
}
