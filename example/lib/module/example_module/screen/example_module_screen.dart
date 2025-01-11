part of '../import/example_module_import.dart';

class ExampleModuleScreen extends StatefulWidget {
  final ExampleModuleBloc bloc;

  const ExampleModuleScreen({
    super.key,
    required this.bloc,
  });

  @override
  ExampleModuleScreenState createState() => ExampleModuleScreenState(bloc);
}

class ExampleModuleScreenState
    extends BaseScreen<ExampleModuleBloc, ExampleModuleScreen, dynamic> {
  ExampleModuleScreenState(super.bloc);

  @override
  Widget buildWidget(BuildContext context, RenderDataState state) {
    return Container();
  }

  @override
  void listenToState(BuildContext context, BaseState state) {}
}
