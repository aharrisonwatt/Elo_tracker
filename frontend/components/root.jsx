import React from 'react';
import { Provider } from 'react-redux';
//router
import { Router, Route, IndexRoute, hashHistory } from 'react-router';
//components
import App from './app'
import RatingIndexContainer from './rating_index/rating_index_container';


const Root = ({store}) => (
  <Provider store={store}>
    <Router history={hashHistory}>
      <Route path='/' componet={App}>
        <IndexRoute component={RatingIndexContainer} />
      </Route>
    </Router>
  </Provider>
);

export default Root;
