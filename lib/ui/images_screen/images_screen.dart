import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/res/app_colors.dart';
import 'package:helpfeed2/ui/images_screen/images_screen_cubit.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar:AppBar(title: const Text("Images"),) ,
      body: BlocBuilder<ImagesScreenCubit,ImagesScreenState>(builder: (context,state){
        if(state is Error){
          return Center(child: Text(state.msg),);
        }
        if(state is ReceivedImages){
          var images = state.images;
          if(images.isNotEmpty){
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                crossAxisCount: 3,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return  Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(images[index]),
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center(child: Text("No Images !!!"),);
          }

        }
        return const Center(child: CircularProgressIndicator());
      }),

      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, "/uploadImages");
      },backgroundColor: AppColors.primaryDarkest,child:const Icon(Icons.add),),
    ));
  }

  @override
  void initState() {
    BlocProvider.of<ImagesScreenCubit>(context).fetchImages();
  }
}
