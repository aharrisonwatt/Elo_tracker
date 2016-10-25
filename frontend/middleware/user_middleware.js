import { UserConstants, recieveUser } from '../actions/user_actions';
import { fetchUser } from '../util/user_api_util';

export default ({getState, dispatch}) => next => action => {
  const result = next(action);
  switch(action.type){
    case UserConstants.REQUEST_USER:
      const success = data => dispatch(recieveUser(data));
      fetchUser(action.username, success)
      return next(action);
    default:
      return next(action);
  }
  return result;
};
