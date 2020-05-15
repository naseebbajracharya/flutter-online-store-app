import 'package:flutter_online_store/models/app_state.dart';
import 'package:flutter_online_store/models/user.dart';
import 'package:flutter_online_store/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action)
  );
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction){
    //return uuser from action
    return action.user;
  }
  return user;
}