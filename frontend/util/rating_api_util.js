export const fetchRatings = function(success){
 $.ajax({
   method: 'GET',
   url: 'api/results',
   success,
   error: () => console.log('error')
 });
};
