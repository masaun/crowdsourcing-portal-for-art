import { GET_EPISODES, GET_EPISODE } from "../types";

export default (state, action) => {
  switch (action.type) {
    case GET_EPISODES:
      return {
        ...state,
        episodes: action.payload
        //loading: false
      };
    case GET_EPISODE:
      return {
        ...state,
        episode: action.payload
        //loading: false
      };
    default:
      return state;
  }
};
