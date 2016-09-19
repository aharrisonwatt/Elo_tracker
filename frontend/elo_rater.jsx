//React
import React from 'react';
import ReactDOM from 'react-dom';
//Components

//Actions
import configureStore from './store/store';

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  window.Store = configureStore();
})
