import 'package:edwisely/data/blocs/assessmentLandingScreen/objectiveBloc/objective_bloc.dart';
import 'package:edwisely/ui/widgets_util/assessment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ObjectiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: context.bloc<ObjectiveBloc>(),
      // ignore: missing_return
      builder: (BuildContext context, state) {
        if (state is ObjectiveInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ObjectiveSuccess) {
          return ListView.builder(
            itemCount: state.questionsEntity.data.length,
            itemBuilder: (BuildContext context, int index) {
              return
                  //   ListTile(
                  //   title: Text(
                  //     state.questionsEntity.data[index].name,
                  //     style: TextStyle(fontWeight: FontWeight.bold),
                  //   ),
                  //   subtitle: Text(state.questionsEntity.data[index].description),
                  //   leading:
                  //       Image.network(state.questionsEntity.data[index].test_img),
                  //   trailing: Text(state.questionsEntity.data[index].start_time),
                  // );
                  AssessmentTile(
                state.questionsEntity.data[index].name,
                state.questionsEntity.data[index].description,
                state.questionsEntity.data[index].questions_count.toString(),
              );
            },
          );
        }
      },
    );
  }
}
