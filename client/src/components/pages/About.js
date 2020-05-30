import React, { Fragment } from "react";
import Users from "../users/Users";
import { Link } from "react-router-dom";

const About = () => {
  return (
    <Fragment>
      <Link to="/" className="btn btn-light">
        Back
      </Link>
      <h1>About the wildcards bounties program</h1>
      <p>
        Wildcards mission is to bring radical and sustainable change thoughout
        the world, starting off with animal conservation. With global animal
        populations declining by 60% over only the last 40 years, it is crucial
        we react. It is our responsibility to stop this devastating trend.
      </p>
      <br />
      <p>
        Wildcards is a fun and engadging platform that channels funding into a
        numerous global animal conservation efforts in order to create a more
        sustainable future for our children and grandchildren.
      </p>
      <br />
      <p>
        Animals from our global network of conservations are represented as
        NFT's. These NFT's are unique in the sense that they are always for
        sale. Whenever a wildcard NFT is bought, the user must immediately set a
        selling price for this NFT. It can be bought at anytime for this sale
        price, and hence is considered always for sale. The owner of the NFT is
        required to pay a percentage of the selling price they set (called a
        harberger tax) in order to maintain gardianship of the wildcard NFT. All
        of this harberger tax is flows directly to the relative conservation
        organisation that the wildcard NFT represents.
      </p>
      <br />
      <h2>Our appeal to artists</h2>
      <p>
        In order to continue growing wildcards to scale where we can truly
        reverse the devistating trend of animal extincition, we need more and
        more artworks to represent the wildcards and raise funds for these
        conservation organisations. We have listed a number of artworks we are
        looking to source, and this list will continue to rapidly grow. Please
        consider drawing a wildcard and making your mark by contributing to
        animal conservation.
      </p>
      <br />
      <h3>Whats in it for you?</h3>
      <p>
        Of course the main thing is that your efforts are helping channel more
        and more funds into animal conservation. The artwork representing the
        wildcard you create, over its lifetime can channel thousands and
        thousands of dollars over time to a organisation fighting this battle on
        the front line.
      </p>
      <br />
      <p>
        You will also recieve full credit on the wildcards platform as well as
        unique badge in your profile as a wildcards artist. Finally, if that
        wasn't enough, we are willing to offer a financial incentive. You will
        receive a small percentage on the sale price every single time your
        wildcard artwork is sold on the platform.
      </p>
    </Fragment>
  );
};

export default About;
