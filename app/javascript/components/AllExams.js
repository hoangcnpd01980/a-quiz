import React from "react"
import PropTypes from "prop-types"
import { BrowserRouter as Router, Link } from "react-router-dom"

class AllExams extends React.Component {
  render () {
    var exams = this.props.exams.map((exam, index) => {
      return(
        <div key={index} className="row exam">
          <div className="col-md-4 title">
            <div className="item">
              <div className="item-title">
                <div className="info-card">
                  <i className="fa fa-question"></i>
                  <p>Questions</p>
                  <div className="count">
                    <p>{exam.questions_count}</p>
                  </div>
                </div>
                <div className="info-card">
                  <i className="fa fa-clock-o"></i>
                  <p>Minutes</p>
                  <div className="count">
                    <p>20</p>
                  </div>
                </div>
                <div className="container text-center difficulity">
                  <p>Difficulity: {exam.difficulity}</p>
                </div>
              </div>
            </div>
          </div>
          <div className="col-md-8">
            <div className="name-title">
              <p>Full Stack .NET quiz medium level</p>
            </div>
            <div className="name-exam">
              <p>Take this .NET test especially designed for .NET developers new to .NET Core 2.0. Topics: Entity Framework Core, ASP.NET Core, .NET Core Command-Line Interface (CLI) Tools, Kestrel, API, etc.</p>
            </div>
            <div className="action text-center">
              <a href={`/admin/exams/${exam.id}`}><button className="btn btn-click">TAKE THE TEST</button></a>
            </div>
          </div>
        </div>
      )}
    )
    return (
      <div className="container">
        {exams}
      </div>
    );
  }
}

export default AllExams
