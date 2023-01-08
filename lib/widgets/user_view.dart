import 'package:flutter/material.dart';
import 'package:helpfeed2/models/user_model.dart';
import 'package:helpfeed2/utils/util_methods.dart';

import '../res/app_colors.dart';

class UserView extends StatelessWidget {
  final UserModel userModel;
  final VoidCallback onClick;
  final VoidCallback onCallClick;
  const UserView({Key? key, required this.userModel, required this.onClick, required this.onCallClick}) : super(key: key);

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
                  child: Text(userModel.name![0]),

                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userModel.name.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                      Text(userModel.description??"No Description",overflow: TextOverflow.ellipsis,maxLines: 2,)
                    ],
                  ),
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
            Row(children: [
              const Icon(Icons.location_on),
              Text("${userModel.address!.city}-${userModel.address!.pincode}",overflow: TextOverflow.ellipsis,maxLines: 2,),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  UtilMethods.openPhone(userModel.contacts![0]);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDarkest,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(

                    children: const [
                      Icon(Icons.call,color: Colors.white,),
                      Text("Call",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)
                    ],
                  ),
                ),
              )

            ],),




          ],
        ),
      ),
    );
  }
}
