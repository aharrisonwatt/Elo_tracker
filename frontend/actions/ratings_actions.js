export const RatingsConstants = {
    RECEIVE_RATINGS: "RECEIVE_RATINGS",
    REQUEST_RATINGS: "REQUEST_RATINGS"
};

export const requestRatings = () => ({
  type: RatingsConstants.REQUEST_RATINGS
});

export const recieveRatings = (ratings) => ({
  type: ResultsConstants.RECEIVE_RATINGS,
  ratings
});
