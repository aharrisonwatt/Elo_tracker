import { TournamentsConstants } from '../actions/tournaments_actions';

const TournamentsReducer = (state = {}, action) => {
  switch (action.type) {
    case TournamentsConstants.RECEIVE_TOURNAMENTS:
      return action.tournaments;
    default:
      return state;
  }
};

export default TournamentsReducer;
