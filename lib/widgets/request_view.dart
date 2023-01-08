import 'package:flutter/material.dart';
import 'package:helpfeed2/models/request_model.dart';
import 'package:helpfeed2/res/app_colors.dart';


class RequestView extends StatelessWidget {
  final RequestModel request;
  final VoidCallback onCallClick;
  final Function() onClick;

  const RequestView({Key? key, required this.request, required this.onCallClick, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(request.name![0]),

                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request.name.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                      Text(request.pickupLocation!['address'],overflow: TextOverflow.ellipsis,maxLines: 2,softWrap: false,)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                const SizedBox(width: 32,),
                Column(
                  children:[
                  Text(request.quantity.toString()),
                    const Icon(Icons.person),
                  ]
                ),

                const SizedBox(width: 16,),
                Column(
                    children:[
                      Text(request.getDuration()),
                      const Icon(Icons.timelapse),
                    ]
                ),
                const SizedBox(width: 16,),
                Column(
                    children:[
                      Text(request.getDistance()),
                      const Icon(Icons.location_on),
                    ]
                ),
                const Spacer(),

                InkWell(
                  onTap: onCallClick,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDarkest,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }


}
