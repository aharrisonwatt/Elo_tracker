import { createStore } from 'redux';
import RootReducer from '../reducers/root_reducer';
import { applyMiddleware } from 'redux'
import RootMiddleware from '../middleware/root_middleware';
import ResultsMiddleware from '../middleware/results_middleware'

const configureStore = (preloadedstate = {}) => (
  createStore(
    RootReducer,
    preloadedstate,
    applyMiddleware(ResultsMiddleware)
  )
);

export default configureStore;
