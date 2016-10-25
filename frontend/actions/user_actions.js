export const UserConstants = {
    RECEIVE_USER: "RECEIVE_USER",
    REQUEST_USER: "REQUEST_USER"
};

export const requestUser = () => ({
  type: UserConstants.REQUEST_USER
});

export const recieveUser = (user) => ({
  type: UserConstants.RECEIVE_USER,
  ratings
});
