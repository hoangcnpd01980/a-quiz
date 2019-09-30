import React from "react"
import PropTypes from "prop-types"
import Body from "components/Body"
import { BrowserRouter as Router, Switch, Route } from "react-router-dom"
import routes from "components/routes"
import { ToastContainer } from 'react-toastify'
import 'react-toastify/dist/ReactToastify.css'

class Main extends React.Component {
  render () {
    return (
    <Router>
      <div>
        <Body />
        <Switch>
          { this.showContentMenus(routes) }
          <ToastContainer
            hideProgressBar={true}
            autoClose={3000}
            exact
          />
        </Switch>
      </div>
    </Router>
    );
  }
  showContentMenus = (routes) => {
    var result = null;
    if (routes.length > 0) {
      result = routes.map((route, index) => {
        return(
          <Route
            key={index}
            path={route.path}
            exact={route.exact}
            component={route.main}
          />
        )
      });
    }
    return result;
  }
}

export default Main
