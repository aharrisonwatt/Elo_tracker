import { combineReducers } from 'redux';

import RatingsReducer from './ratings_reducer';
import UserReducer from './user_reducer';
import TournamentsReducer from './tournaments_reducer';

export default combineReducers({
  user: UserReducer,
  ratings: RatingsReducer,
  tournaments: TournamentsReducer,
});
