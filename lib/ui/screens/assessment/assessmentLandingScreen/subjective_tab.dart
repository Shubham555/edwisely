import 'package:edwisely/data/blocs/assessmentLandingScreen/subjectiveBloc/subjective_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: context.bloc<SubjectiveBloc>(),
      // ignore: missing_return
      builder: (BuildContext context, state) {
        if (state is SubjectiveInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SubjectiveSuccess) {
          return ListView.builder(
            itemCount: state.questionsEntity.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(state.questionsEntity.data[index].name),
                subtitle: Text(state.questionsEntity.data[index].description),
                leading:
                    Image.network(state.questionsEntity.data[index].test_img),
                trailing: Text(state.questionsEntity.data[index].start_time),
              );
            },
          );
        }
      },
    );
  }
}
