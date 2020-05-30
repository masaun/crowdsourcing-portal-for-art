import React from "react";
import { Link } from "react-router-dom";

const ProjectItem = ({ episode }) => {
  const { name, avatar_url, role, list_id } = episode;
  return (
    <div className="card text-center">
      <img
        src={avatar_url}
        alt=""
        className="round-img"
        style={{ width: "90px" }}
      />
      <h2>{name}</h2>
      <h4>{role}</h4>
      <div>
        <Link to={`/project/${list_id}`} className="btn btn-dark btn-sm my-1">
          more
        </Link>
      </div>
    </div>
  );
};

export default ProjectItem;
