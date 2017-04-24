export const TournamentsConstants = {
  RECEIVE_TOURNAMENTS: 'RECEIVE_TOURNAMENTS',
  REQUEST_TOURNAMENTS: 'REQUEST_TOURNAMENTS',
};

export const requestTournaments = () => ({
  type: TournamentsConstants.REQUEST_TOURNAMENTS,
});

export const recieveTournaments = tournaments => ({
  type: TournamentsConstants.RECEIVE_TOURNAMENTS,
  tournaments,
});
