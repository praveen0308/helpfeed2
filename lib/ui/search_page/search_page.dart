import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/models/user_model.dart';
import 'package:helpfeed2/ui/search_page/search_page_cubit.dart';

import '../user_profile/user_profile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchText = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<SearchPageCubit>(context).fetchUsers("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchText,
              keyboardType: TextInputType.name,
              onChanged: (txt) {
                BlocProvider.of<SearchPageCubit>(context).fetchUsers(txt);
              },

              decoration: const InputDecoration(
                hintText: "Search here...",
                  border: OutlineInputBorder(borderSide: BorderSide())),
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<SearchPageCubit, SearchPageState>(
                builder: (context, state) {
                  if(state is Searching){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if (state is ReceivedUsers) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          UserModel user = state.users[index];
                          return ListTile(
                            leading: CircleAvatar(child:Text(user.name![0]),),
                            title: Text(user.name??""),
                            onTap: (){

                              Navigator.pushNamed(context, "/userProfile",
                                  arguments: user.userId);
                            },
                          );
                        });
                  }

                  return const Center(child: Text("Nothing Found!!!"),);


                })
          ],
        ),
      ),
    ));
  }
}
