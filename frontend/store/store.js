import { createStore } from 'redux';
import RootReducer from '../reducers/root_reducer';
import { applyMiddleware } from 'redux'
import RootMiddleware from '../middleware/root_middleware';
import RatingsMiddleware from '../middleware/ratings_middleware'

const configureStore = (preloadedstate = {}) => (
  createStore(
    RootReducer,
    preloadedstate,
    applyMiddleware(RatingsMiddleware)
  )
);

export default configureStore;
