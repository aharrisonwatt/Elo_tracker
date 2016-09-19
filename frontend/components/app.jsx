import React, { PropTypes } from 'react'
import Navbar from './navbar'

const App = React.createClass({
  render () {
    return (
      <div classname='main-body'>
        <Navbar />
        {this.props.children}
      </div>
    )
  }
})

export default App
