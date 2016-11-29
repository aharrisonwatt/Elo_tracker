import React from 'react';

// Components
import RatingGameFilter from '../rating_index/rating_game_filter';
import RatingDisplay from './rating_display';

class UserProfile extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      gameFilter: '',
    };
    this.updateGameFilter = this.updateGameFilter.bind(this);
  }

  componentDidMount() {
    this.props.requestUser(this.props.params.username);
  }

  componentWillReceiveProps() {
    this.setState({ gameFilter: '' });
  }

  updateGameFilter(gameName) {
    this.setState({ gameFilter: gameName });
  }
  render() {
    let games;
    let gameObject;
    if (this.props.user.user) {
      const userObject = this.props.user.user;
      games = Object.keys(userObject);
      if (this.state.gameFilter === '') {
        this.state.gameFilter = games[games.length - 1];
      }
      gameObject = userObject[this.state.gameFilter];
    }
    return (
      <div className="user-profile-container">
        <div className="user-profile-main-container">
          <h1>{this.props.params.username}</h1>
          <RatingGameFilter
            updateGameFilter={this.updateGameFilter}
            games={games}
            currentFilter={this.state.gameFilter}
          />
        </div>
        <RatingDisplay gameObject={gameObject} />
      </div>
    );
  }
}

UserProfile.propTypes = {
  user: React.PropTypes.shape({
    user: React.PropTypes.object,
  }),
  requestUser: React.PropTypes.func,
  params: React.PropTypes.object,
};

export default UserProfile;
