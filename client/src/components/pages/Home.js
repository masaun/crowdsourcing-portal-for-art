import React, { useContext, useEffect } from "react";
import Projects from "../project/Projects.js";
import ProjectContext from "../../context/projects/projectContext";

const Home = () => {
  const projectContext = useContext(ProjectContext);
  const { getEpisodes } = projectContext;
  useEffect(() => {
    getEpisodes();
  }, []);

  return (
    <div className="text-center">
      <h3>Current wildcards artwork bounties</h3>
      <h4>Navigate to about to learn more about the program</h4>
      <Projects />
    </div>
  );
};
export default Home;
