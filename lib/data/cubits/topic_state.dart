part of 'topic_cubit.dart';

@immutable
abstract class TopicState {}

class TopicInitial extends TopicState {}

class TopicFetched extends TopicState {
  final TopicEntity topicEntity;

  TopicFetched(this.topicEntity);
}

class TopicFailed extends TopicState {}

class TopicEmpty extends TopicState {}
