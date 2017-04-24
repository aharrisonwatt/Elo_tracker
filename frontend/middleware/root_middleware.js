import { applyMiddleware } from 'redux';

import RatingsMiddleware from './ratings_middleware';
import UserMiddleware from './user_middleware';
import TournamentsMiddleware from './tournaments_middleware';

const RootMiddleware = applyMiddleware(
  RatingsMiddleware,
  UserMiddleware,
  TournamentsMiddleware
);

export default RootMiddleware;
