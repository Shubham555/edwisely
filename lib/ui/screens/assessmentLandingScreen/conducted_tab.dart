import 'package:edwisely/data/blocs/assessmentLandingScreen/conductdBloc/conducted_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConductedTab extends StatefulWidget {
  @override
  _ConductedTabState createState() => _ConductedTabState();
}

class _ConductedTabState extends State<ConductedTab>
    with TickerProviderStateMixin {
  TabController _objectiveOrSubjectiveTabController;
  TabController _sectionOrSubjectTabController;

  @override
  void initState() {
    _objectiveOrSubjectiveTabController = TabController(length: 2, vsync: this);
    _sectionOrSubjectTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 30),
          indicatorColor: Colors.white,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          isScrollable: true,
          controller: _objectiveOrSubjectiveTabController,
          tabs: [
            Tab(
              text: 'Objective',
            ),
            Tab(
              text: 'Subjective',
            ),
          ],
        ),
        TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 30),
          indicatorColor: Colors.white,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          isScrollable: true,
          controller: _sectionOrSubjectTabController,
          tabs: [
            Tab(
              text: 'Section',
            ),
            Tab(
              text: 'Subject',
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder(
            cubit: context.bloc<ConductedBloc>()
              ..add(
                GetConductedTests(
                    _objectiveOrSubjectiveTabController.index == 0
                        ? AssessmentType.Objective
                        : AssessmentType.Subjective,
                    _sectionOrSubjectTabController.index == 0
                        ? AssessmentSortBy.Section
                        : AssessmentSortBy.Subject),
              ),
            // ignore: missing_return
            builder: (BuildContext context, state) {
              if (state is ConductedInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ConductedSuccess) {
                return ListView.builder(
                  itemCount: state.questionsEntity.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(state.questionsEntity.data[index].name),
                      subtitle:
                          Text(state.questionsEntity.data[index].description),
                      leading: Image.network(
                          state.questionsEntity.data[index].test_img),
                      trailing:
                          Text(state.questionsEntity.data[index].start_time),
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}
