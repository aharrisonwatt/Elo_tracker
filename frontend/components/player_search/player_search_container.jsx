import React from 'react';
import PlayerIndexCards from './player_index_cards';
import RatingPlayerFilter from '../rating_index/rating_player_filter';
import Autosuggest from 'react-autosuggest';
import { hashHistory } from 'react-router';

const escapeRegexCharacters = str => str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

const getSuggestions = (value, list) => {
  const escapedValue = escapeRegexCharacters(value.trim());

  if (escapedValue === '') {
    return [];
  }

  const regex = new RegExp('^' + escapedValue, 'i');

  return list.filter(name => regex.test(name));
};

const getSuggestionValue = suggestion => suggestion;

const renderSuggestion = suggestion => suggestion;

class PlayerSearchContainer extends React.Component {
  constructor(props) {
    super(props);
    this.onChange = this.onChange.bind(this);
    this.onSuggestionsFetchRequested = this.onSuggestionsFetchRequested.bind(this);
    this.onSuggestionsClearRequested = this.onSuggestionsClearRequested.bind(this);
    this.onSuggestionSelected = this.onSuggestionSelected.bind(this);
    this.state = {
      value: '',
      suggestions: [],
    };
  }

  onChange(event, { newValue }) {
    this.setState({
      value: newValue,
    });
  }

  onSuggestionsFetchRequested({ value }) {
    this.setState({
      suggestions: getSuggestions(value, this.props.players),
    });
  }

  onSuggestionsClearRequested() {
    this.setState({
      suggestions: [],
    });
  }

  onSuggestionSelected(event, { suggestion }) {
    hashHistory.push(suggestion);
  }

  render() {
    const { value, suggestions } = this.state;
    const inputProps = {
      placeholder: 'Find a Player',
      value,
      onChange: this.onChange,
    };

    return (
      <div>
        <Autosuggest
          suggestions={suggestions}
          onSuggestionsFetchRequested={this.onSuggestionsFetchRequested}
          onSuggestionsClearRequested={this.onSuggestionsClearRequested}
          getSuggestionValue={getSuggestionValue}
          renderSuggestion={renderSuggestion}
          inputProps={inputProps}
          onSuggestionSelected={this.onSuggestionSelected}
        />
      </div>
    );
  }
}

PlayerSearchContainer.propTypes = {
  players: React.PropTypes.array,
};

export default PlayerSearchContainer;
