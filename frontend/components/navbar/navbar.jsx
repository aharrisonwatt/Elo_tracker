import React from 'react';
import { Link } from 'react-router';

const Navbar = () => (
  <header className="navbar">
    <Link to="/" className="home-link">
      <h1>Elo Tracker</h1>
    </Link>
    <a href="https://github.com/aharrisonwatt/Elo_tracker" className="github-link" >
      <img className="navbar-github-img"
           src="http://res.cloudinary.com/awatt/image/upload/v1479174500/GitHub-Mark-120px-plus_thnbvl.png"
      />
    </a>
  </header>
);

export default Navbar;
