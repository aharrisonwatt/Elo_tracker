import { combineReducers } from 'redux';

import RatingsReducer from './ratings_reducer';

export default combineReducers({
  ratings: RatingsReducer
});
