import { createStore } from 'redux';
import RootReducer from '../reducers/root_reducer';

const configureStore = (preloadedstate = {}) => (
  createStore(
    RootReducer,
    preloadedstate
  )
);

export default configureStore;
