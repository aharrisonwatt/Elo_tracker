import { createStore } from 'redux';
import RootReducer from '../reducers/root_reducer';
import RootMiddleware from '../middleware/root_middleware';

const configureStore = (preloadedstate = {}) => (
  createStore(
    RootReducer,
    preloadedstate,
    RootMiddleware
  )
);

export default configureStore;
