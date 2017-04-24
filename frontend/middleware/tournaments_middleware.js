import { TournamentsConstants, recieveTournaments } from '../actions/tournaments_actions';
import { fetchTournaments } from '../util/tournament_api_util';

export default ({ getState, dispatch }) => next => (action) => {
  switch (action.type) {
    case TournamentsConstants.REQUEST_TOURNAMENTS: {
      const success = data => dispatch(recieveTournaments(data));
      fetchTournaments(success);
      return next(action);
    }
    default:
      return next(action);
  }
};
