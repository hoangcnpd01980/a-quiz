import React from "react"
import PropTypes from "prop-types"
import NewExam from "components/NewExam"
import AllExams from "components/AllExams"

class Body extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      exams: []
    }
    this.handleSubmit = this.handleSubmit.bind(this);
  }
  componentDidMount(){
    fetch("/api/v1/exams")
      .then((response) => {return response.json()})
      .then((data) => {this.setState({ exams: data }) });
  }
  handleSubmit(exam) {
    var newState = this.state.exams.concat(exam);
    this.setState({ exams: newState });
  }
  render () {
    return (
      <div>
        <NewExam handleSubmit={this.handleSubmit} />
        <AllExams exams={this.state.exams} />
      </div>
    );
  }
}

export default Body
