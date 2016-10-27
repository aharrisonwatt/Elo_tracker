import React from 'react';
import RatingGameFilter from '../rating_index/rating_game_filter';

class UserProfile extends React.Component{
  constructor(props) {
    super(props);
    this.state = {
      gameFilter: 'Street Fighter V'
    };
    this.updateGameFilter = this.updateGameFilter.bind(this);
  }

  componentDidMount() {
    this.props.requestUser(this.props.params.username);
  }

  updateGameFilter(game_name) {
    this.state['gameFilter'] = game_name
    this.forceUpdate();
  }

  render() {
    let games;
    if (this.props.user['user']){
      debugger
    }
    return(
      <div>
        <div>
          <h1>{this.props.params.username}</h1>
          <RatingGameFilter
            updateGameFilter={this.updateGameFilter}
            games={games}/>
        </div>
      </div>
    )
  }
}

export default UserProfile
