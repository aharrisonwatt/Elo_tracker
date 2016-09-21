import React from 'react';
import { Provider } from 'react-redux';
import App from './app'
import RatingIndexContainer from './rating_index_container';


const Root = ({store}) => (
  <Provider store={store}>
    <RatingIndexContainer/>
  </Provider>
);

export default Root;
