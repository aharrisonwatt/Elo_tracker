import React from 'react';
import { Link } from 'react-router';

const App = ({children}) => (
  <div>
    <header>
      <Link to="/" className="home-link">
        <h1>Elo Rater</h1>
      </Link>
    </header>
    {children}
  </div>
);

export default App;
