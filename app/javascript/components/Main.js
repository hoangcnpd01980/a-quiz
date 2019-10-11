import React from "react"
import PropTypes from "prop-types"
import Body from "components/Body"
import { BrowserRouter as Router, Switch, Route } from "react-router-dom"
import { ToastContainer } from 'react-toastify'
import 'react-toastify/dist/ReactToastify.css'

class Main extends React.Component {
  render () {
    return (
      <div>
        <Body />
        <ToastContainer
          hideProgressBar={true}
          autoClose={3000}
          exact
        />
      </div>
    );
  }
}

export default Main
