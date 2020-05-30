import { SET_LOADING, GET_USER, GET_REPOS } from '../types';

export default (state, action) => {
  switch (action.type) {
    case GET_USER:
      return {
        ...state,
        user: action.payload,
        loading: false
      };
    case GET_REPOS:
      return {
        ...state,
        repos: action.payload,
        loading: false
      };

    case SET_LOADING:
      return {
        ...state, //copying state , spread operator
        loading: true
      };
    default:
      return state;
  }
};
