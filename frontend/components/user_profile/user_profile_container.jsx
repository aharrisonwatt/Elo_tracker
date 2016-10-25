import { connect } from 'react-redux';
import UserProfile from './user_profile';
import { requestUser } from '../../actions/user_actions';

const mapStateToProps = state => ({
  user: state.user
});

const mapDispatchToProps = dispatch => ({
  requestUser: () => dispatch(requestUser())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(UserProfile);
