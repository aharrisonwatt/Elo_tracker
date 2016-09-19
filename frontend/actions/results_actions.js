export const ResultsConstants = {
    RECEIVE_RESULTS: "RECEIVE_RESULTS",
    REQUEST_RESULTS: "REQUEST_RESULTS"
};

export const requestResults = () => ({
  type: ResultsConstants.REQUEST_RESULTS
});

export const recieveResults = (results) => ({
  type: ResultsConstants.RECEIVE_RESULTS,
  results
});
