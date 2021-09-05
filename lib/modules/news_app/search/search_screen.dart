import 'package:darsh/layout/news_app/cubit/cubit.dart';
import 'package:darsh/layout/news_app/cubit/states.dart';
import 'package:darsh/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller:searchController ,
                  type: TextInputType.text,
                  onChanged:(value)
                  {
                    cubit.getSearch(value);
                  },
                  validate:(value)
                  {
                    if(value.isEmpty)
                      return('Please enter a valid search');
                  },
                  label: 'Search',
                  prefix: Icons.search,
                  color: Colors.deepOrange,
                ),
              ),
              Expanded(child: buildArticle(condition: true, list:cubit.search )),
            ],
          ),
        );
      },
    );
  }
}
