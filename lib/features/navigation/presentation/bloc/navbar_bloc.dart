import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/features/navigation/presentation/bloc/navbar_event.dart';
import 'package:movie_discovery_app/features/navigation/presentation/bloc/navbar_state.dart';

class NavbarBloc  extends Bloc<NavbarEvent,NavbarState> {
     NavbarBloc():super(const NavbarState()){
  on<ChangeNavbarIndex>((event,emit){
      emit(
        NavbarState(selectedIndex: event.index));
     });
}

}