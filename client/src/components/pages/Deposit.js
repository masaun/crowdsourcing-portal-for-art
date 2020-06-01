import React, { Fragment } from "react";
import { Link } from "react-router-dom";

const Deposit = () => {
  return (
    <Fragment>
      <Link to="/deposit" className="btn btn-light">
        Back
      </Link>
      <br />
      <h4>Deposit</h4>
      <br />
      <p>test</p>
      <p>test</p>
    </Fragment>
  );
};

export default Deposit;
