import React from 'react';

class TournamentIndex extends React.Component {
  constructor(props) {
    super(props);
  }
  componentDidMount() {
    this.props.requestTournaments();
  }

  render() {
    return (
      <div>
        <p>
          Hello World
        </p>
      </div>
    );
  }
}

TournamentIndex.propTypes = {
  requestTournaments: React.PropTypes.func,
};

export default TournamentIndex;
