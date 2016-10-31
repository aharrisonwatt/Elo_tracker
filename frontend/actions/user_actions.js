export const UserConstants = {
  RECEIVE_USER: 'RECEIVE_USER',
  REQUEST_USER: 'REQUEST_USER',
};

export const requestUser = username => ({
  type: UserConstants.REQUEST_USER,
  username,
});

export const recieveUser = user => ({
  type: UserConstants.RECEIVE_USER,
  user,
});
