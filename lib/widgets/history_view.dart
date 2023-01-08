import 'package:flutter/material.dart';
import 'package:helpfeed2/models/request_model.dart';
import 'package:helpfeed2/res/app_colors.dart';


class HistoryView extends StatelessWidget {
  final RequestModel request;
  final Function() onClick;

  const HistoryView({Key? key, required this.request, required this.onClick}) : super(key: key);

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
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(request.name![0]),

                ),
                const SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request.name.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                    Text(request.pickupLocation!['address'],overflow: TextOverflow.ellipsis,maxLines: 2,)
                  ],
                ),
                /*Row(
                  children: [
                    Icon(Icons.location_on),
                    UtilMethods.calculateDistance(, lon1, lat2, lon2)
                  ],
                )*/
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                const SizedBox(width: 32,),
                Column(
                  children:[
                  Text(request.quantity.toString()),
                    Icon(Icons.person),
                  ]
                ),

                const SizedBox(width: 16,),
                Column(
                    children:[
                      Text(request.getDuration()),
                      Icon(Icons.timelapse),
                    ]
                ),
                const Spacer(),

                Chip(label: Text(request.status.toString().toUpperCase(),style: TextStyle(color: request.getForegroundColor()),),backgroundColor: request.getBackgroundColor(),)
              ],
            ),

          ],
        ),
      ),
    );
  }


}
