import { applyMiddleware } from 'redux';

import { RatingsMiddleware } from './ratings_middleware';

const RootMiddleware = applyMiddleware(
  RatingsMiddleware
);

export default RootMiddleware;
