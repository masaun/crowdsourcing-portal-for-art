import React, { useContext } from 'react';
import { Link } from 'react-router-dom';
import GithubContext from '../../context/github/githubContext';

const UserItem = () => {
  const githubContext = useContext(GithubContext);

  const {
    user: { login, avatar_url }
  } = githubContext;

  return (
    <div className='card text-center'>
      <img
        src={avatar_url}
        alt=''
        className='round-img'
        style={{ width: '150px' }}
      />
      <h3>{login}</h3>
      <div>
        <Link to={`/user/moose-code`} className='btn btn-dark btn-sm my-1'>
          Github info
        </Link>
      </div>
    </div>
  );
};

export default UserItem;
