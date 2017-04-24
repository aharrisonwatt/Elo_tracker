export const fetchTournaments = function(success) {
  $.ajax({
    method: 'GET',
    url: 'api/tournaments',
    success,
    error: () => console.log('error'),
  });
};
