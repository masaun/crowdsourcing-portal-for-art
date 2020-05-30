import React, { Fragment } from "react";
import { Link } from "react-router-dom";

const Contact = () => {
  return (
    <Fragment>
      <Link to="/" className="btn btn-light">
        Back
      </Link>
      <br />
      <h4>
        For more information or queries regarding the program please reach out
        to details listed below and we will get be in contact ASAP.
      </h4>
      <br />
      <p>Email: jonjon@wildcards.world </p>
      <p>Telegram: https://t.me/wildcardsworld</p>
    </Fragment>
  );
};

export default Contact;
