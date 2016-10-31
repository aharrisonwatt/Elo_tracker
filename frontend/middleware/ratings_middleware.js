import { RatingsConstants, recieveRatings } from '../actions/ratings_actions';
import { fetchRatings } from '../util/rating_api_util';

export default ({ getState, dispatch }) => next => (action) => {
  switch (action.type) {
    case RatingsConstants.REQUEST_RATINGS: {
      const success = data => dispatch(recieveRatings(data));
      fetchRatings(success);
      return next(action);
    }
    default:
      return next(action);
  }
};
