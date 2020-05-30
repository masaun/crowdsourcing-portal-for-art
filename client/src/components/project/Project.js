import React, { useEffect, useContext, Fragment } from "react";
import { Link } from "react-router-dom";
import ProjectContext from "../../context/projects/projectContext";

const Project = ({ match }) => {
  const projectContext = useContext(ProjectContext);

  const { getEpisode, episode } = projectContext;

  useEffect(() => {
    getEpisode(match.params.list_id);
  }, []);

  const { name, bio, avatar_url, company_bio, html_url, active } = episode;

  return (
    <Fragment>
      <Link to="/" className="btn btn-light">
        Back
      </Link>
      Artwrok completed?{" "}
      {active ? (
        <i className="fas fa-check text-success" />
      ) : (
        <i className="fas fa-times-circle text-danger" />
      )}
      <div className="card grid-2">
        <div className="all-center">
          <img
            src={avatar_url}
            className="round-img"
            alt=""
            style={{ width: "150px" }}
          />
          <h1>{name}</h1>
          {company_bio && <p>{company_bio}</p>}
          {html_url && (
            <a href={html_url} target="_blank" className="btn btn-dark my-1">
              {html_url}
            </a>
          )}
        </div>
        <div>
          {bio && (
            <Fragment>
              <h2>Description</h2>
              <p>{bio}</p>
            </Fragment>
          )}
        </div>
      </div>
    </Fragment>
  );
};

export default Project;
