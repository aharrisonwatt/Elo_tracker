import { RatingsConstants } from '../actions/ratings_actions';
import { fetchRatings } from '../util/rating_api_util';

export default ({getState, dispatch}) => next => action => {
  const result = next(action);
  switch(action.type){
    case RatingsConstants.REQUEST_RATINGS:
      const success = data => console.log(data);
      fetchResults(success)
      return next(action);
    default:
      return next(action);
  }
  return result;
};
