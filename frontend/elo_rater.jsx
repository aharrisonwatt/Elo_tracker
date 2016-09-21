//React
import React from 'react';
import ReactDOM from 'react-dom';
//Components
import Root from './components/root'
import App from './components/app'
//Actions
import { requestRatings } from './actions/ratings_actions';
import configureStore from './store/store';

document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore();
  const root = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, root);
})
