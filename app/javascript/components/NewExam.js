import React from "react"
import PropTypes from "prop-types"
import { toast } from 'react-toastify';

class NewExam extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      sltDifficulity: "master"
    }
    this.onHandleChange = this.onHandleChange.bind(this);
  }
  onHandleChange(event) {
    var target = event.target;
    var name = target.name;
    var value = target.value;
    this.setState({
      [name] : value
    });
  }
  handleClick(event) {
    event.preventDefault();
    var difficulity = this.refs.difficulity.value;
    $.ajax({
      url: "/api/v1/exams",
      type: "POST",
      data: { exam: { difficulity: difficulity, category_id: 1 } },
      success: (exam) => {
        this.props.handleSubmit(exam);
      }
    });
  }
  showToast = () => {
    toast.success("Create Exam Successfully!!!")
  }
  render () {
    return (
      <div className="panel panel-default">
        <form onSubmit={ this.handleClick.bind(this) }>
          <label>Difficulity:</label>
          <select className="form-control" name="sltDifficulity" value={ this.state.sltDifficulity } onChange={ this.onHandleChange } ref='difficulity'>
            <option value="master">master</option>
            <option value="amateur">amateur</option>
          </select>

          <button type="submit" className="btn btn-primary" onClick={this.showToast}>Create</button>
        </form>
      </div>
    );
  }
}

export default NewExam
