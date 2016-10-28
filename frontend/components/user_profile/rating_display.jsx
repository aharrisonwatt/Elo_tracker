import React from 'react'

class RatingDisplay extends React.Component{
  constructor(props){
    super(props);
  }

  render() {
    let rating_display = <div></div>
    if (this.props.gameObject){
      let game_object = this.props.gameObject
      rating_display =
        <div>
          <h2>rank: {game_object['rank']}</h2>
          <h2>MMR: {game_object['rating']}</h2>
        </div>
    }
    return(
      <div>
        {rating_display}
      </div>
    )
  }
}

export default RatingDisplay
