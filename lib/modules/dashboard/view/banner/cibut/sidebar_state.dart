part of 'sidebar_cubit.dart';

class SideBarState extends Equatable {

  final int index;

  const SideBarState({ required this.index});

  @override
  List<Object> get props => [ index];
}
