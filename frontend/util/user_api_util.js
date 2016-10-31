export const fetchUser = function(username, success) {
  $.ajax({
    method: 'GET',
    url: `api/users/${username}`,
    success,
    error: () => console.log('error'),
  });
};
