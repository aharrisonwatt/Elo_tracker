import React from 'react';
//Components
import RatingGameFilter from '../rating_index/rating_game_filter';
import RatingDisplay from './rating_display';

class UserProfile extends React.Component{
  constructor(props) {
    super(props);
    this.state = {
      gameFilter: ''
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
    let game_object;
    if (this.props.user['user']){
      let user_object = this.props.user['user']
      games = Object.keys(user_object);
      if (this.state.gameFilter === ''){
        this.state.gameFilter = games[0]
      }
      game_object = user_object[this.state['gameFilter']]
    }
    return(
      <div>
        <div>
          <h1>{this.props.params.username}</h1>
          <RatingGameFilter
            updateGameFilter={this.updateGameFilter}
            games={games}
            currentFilter={this.state.gameFilter}/>
        </div>
        <RatingDisplay gameObject={game_object} />
      </div>
    )
  }
}

export default UserProfile
