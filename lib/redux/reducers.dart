import 'package:flutter_online_store/models/app_state.dart';
import 'package:flutter_online_store/models/product.dart';
import 'package:flutter_online_store/models/user.dart';
import 'package:flutter_online_store/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    products: productsReducer(state.products, action)
  );
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction){
    //return uuser from action
    return action.user;
  } else if (action is LogoutUserAction) {
    return action.user;
  }
  return user;
}

List <Product> productsReducer(List<Product> products, dynamic action){
  if(action is GetProductsAction){
    return action.products;
  }
  return products;
}