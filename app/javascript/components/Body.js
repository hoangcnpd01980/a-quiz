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
    this.handleDelete = this.handleDelete.bind(this);
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
  handleDelete(id) {
    $.ajax({
      url: `/api/v1/exams/${id}`,
      type: 'DELETE',
      success:() => {
        this.removeExamClient(id);
      }
    });
  }
  removeExamClient(id) {
    fetch("/api/v1/exams")
      .then((response) => {return response.json()})
      .then((data) => {this.setState({ exams: data }) });
  }
  render () {
    return (
      <div>
        <NewExam handleSubmit={this.handleSubmit} />
        <AllExams exams={this.state.exams} handleDelete={this.handleDelete} />
      </div>
    );
  }
}

export default Body
