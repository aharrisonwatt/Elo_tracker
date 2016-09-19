import { ResultsConstants } from '../actions/results_actions';

export default ({getState, dispatch}) => next => action => {
  const result = next(action);
  switch(action.type){
    case ResultsConstants.REQUEST_RESULTS:
      console.log('results requested');
      return next(action);
    default:
      return next(action);
  }
  return result;
};
