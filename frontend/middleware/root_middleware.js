import { applyMiddleware } from 'redux';

import { ResultsMiddleware } from './results_middleware';

const RootMiddleware = applyMiddleware(
  ResultsMiddleware
);

export default RootMiddleware;
