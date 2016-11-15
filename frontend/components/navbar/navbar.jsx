import React from 'react'

const Navbar = () => (
  <header className="navbar">
    <a href="https://github.com/aharrisonwatt/Elo_tracker" className="github-link" >
      <img src="http://res.cloudinary.com/awatt/image/upload/v1479174500/GitHub-Mark-120px-plus_thnbvl.png" />
    </a>
    <Link to="/" className="home-link">
      <h1>Elo Rater</h1>
    </Link>
  </header>
);

export default Navbar
