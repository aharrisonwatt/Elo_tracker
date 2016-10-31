import React from 'react';
import { Link } from 'react-router';

const App = ({ children }) => (
  <div>
    <header className="navbar">
      <Link to="/" className="home-link">
        <h1>Elo Rater</h1>
      </Link>
    </header>
    {children}
  </div>
);

export default App;
