import { connect } from 'react-redux';
import RatingIndex from './rating_index';

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
