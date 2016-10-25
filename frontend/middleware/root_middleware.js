import { applyMiddleware } from 'redux';

import RatingsMiddleware from './ratings_middleware';
import UserMiddleware from './user_middleware';

const RootMiddleware = applyMiddleware(
  RatingsMiddleware,
  UserMiddleware
);

export default RootMiddleware;
