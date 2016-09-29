import { connect } from 'react-redux';
import RatingIndex from './rating_index';
import {requestRatings} from '../actions/ratings_actions';

const mapStateToProps = state => ({
  ratings: state.ratings
});

const mapDispatchToProps = dispatch => ({
  requestRatings: () => dispatch(requestRatings())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(RatingIndex);
