import React  from 'react';

class RatingIndex extends React.Component{
  componentDidMount(){
    this.props.requestRatings();
  }
  render(){
    let ratings;
    if (this.props.ratings['ratings']){
      ratings = this.props.ratings['ratings'].map( player_object =>(
          <div>
            <h2>{player_object['username']}</h2>
            <h2>{player_object['Street Fighter V']}</h2>
            <h2>{player_object['Ultra Street Fighter IV']}</h2>
          </div>
      ))
    }
    return (
      <div>
        {ratings}
      </div>
    )
  }
}

export default RatingIndex
