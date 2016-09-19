import { RatingsConstants } from '../actions/ratings_actions';

const RatingsReducer = (state = {}, action) => {
  switch (action.type){
    case RatingsConstants.RECEIVE_RATINGS:
      return action.ratings
    default:
      return state
  }
}

export default RatingsReducer;
