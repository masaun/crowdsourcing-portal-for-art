import React from "react";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import Navbar from "./components/layout/Navbar";
import User from "./components/users/User";
import Alert from "./components/layout/Alert";
import ParticleComponent from "./components/layout/ParticleComponent";
import Home from "./components/pages/Home";
import About from "./components/pages/About";
import Contact from "./components/pages/Contact";
import NotFound from "./components/pages/NotFound";
import Project from "./components/project/Project";

import GithubState from "./context/github/GithubState";
import AlertState from "./context/alert/AlertState";
import ProjectState from "./context/projects/ProjectState";

import "./App.css";

const App = () => {
  return (
    <GithubState>
      <AlertState>
        <ProjectState>
          <Router>
            <div
              style={{
                position: "absolute",
                top: 0,
                left: 0,
                width: "100%",
                height: "100%"
              }}
            >
              <ParticleComponent />
              <div
                style={{
                  position: "absolute",
                  top: 0,
                  left: 0,
                  width: "100%",
                  height: "100%"
                }}
              >
                <div className="App">
                  <Navbar />
                  <div className="container">
                    <Alert />
                    <Switch>
                      <Route exact path="/" component={Home} />
                      <Route exact path="/about" component={About} />
                      <Route exact path="/contact" component={Contact} />
                      <Route exact path="/user/moose-code" component={User} />
                      <Route
                        exact
                        path="/project/:list_id"
                        component={Project}
                      />
                      <Route component={NotFound} />
                    </Switch>
                  </div>
                </div>
              </div>
            </div>
          </Router>
        </ProjectState>
      </AlertState>
    </GithubState>
  );
};

export default App;
