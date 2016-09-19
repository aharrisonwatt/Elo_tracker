//react
var React = require('react'),
    ReactDOM = require('react-dom'),
    Modal = require("react-modal");

//router
var ReactRouter = require('react-router'),
    Router = ReactRouter.Router,
    Route = ReactRouter.Route,
    IndexRoute = ReactRouter.IndexRoute,
    hashHistory = ReactRouter.hashHistory;

//component
var App = require('./components/app'),
    MainPage = require('./components/MainPage');

var Routes = (
  <Router history={hashHistory}>
    <Route path="/" component={App}>
      <IndexRoute component={MainPage} />
    </Route>
  </Router>
);

document.addEventListener('DOMContentLoaded', function(){
  var root = document.getElementById('root');
  Modal.setAppElement(document.body);
  ReactDOM.render(Routes, root);
});
