import { connect } from 'react-redux';
import TournamentIndex from './tournament_index';
import { requestTournaments } from '../../actions/tournaments_actions';

const mapStateToProps = state => ({
  tournaments: state.tournaments,
});

const mapDispatchToProps = dispatch => ({
  requestTournaments: () => dispatch(requestTournaments()),
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TournamentIndex);
