import React, { useContext } from "react";
import ProjectItem from "./ProjectItem";
import ProjectContext from "../../context/projects/projectContext";

const Projects = () => {
  const projectContext = useContext(ProjectContext);

  const { episodes } = projectContext;

  return (
    <div style={userStyle}>
      {episodes.map(episode => (
        <ProjectItem key={episode.id} episode={episode} />
      ))}
    </div>
  );
};

const userStyle = {
  display: "grid",
  gridTemplateColumns: "repeat(auto-fill,minmax(250px, 1fr))",
  gridGap: "1rem",
  objectFit: "cover"
};

export default Projects;
