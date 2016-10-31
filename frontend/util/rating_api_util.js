export const fetchRatings = function(success) {
  $.ajax({
    method: 'GET',
    url: 'api/ratings',
    success,
    error: () => console.log('error'),
  });
};
