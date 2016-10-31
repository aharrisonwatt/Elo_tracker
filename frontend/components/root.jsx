import React from 'react';
import { Provider } from 'react-redux';

// Router
import { Router, Route, IndexRoute, hashHistory } from 'react-router';

// Components
import App from './app';
import RatingIndexContainer from './rating_index/rating_index_container';
import UserProfileContainer from './user_profile/user_profile_container';


const Root = ({ store }) => (
  <Provider store={store}>
    <Router history={hashHistory}>
      <Route path="/" component={App}>
        <IndexRoute component={RatingIndexContainer} />
        <Route path="/:username" component={UserProfileContainer} />
      </Route>
    </Router>
  </Provider>
);

export default Root;
