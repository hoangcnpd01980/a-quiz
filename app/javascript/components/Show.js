import React from 'react';
import { Steps, Button, message } from 'antd';
import 'antd/dist/antd.css';
import { Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap';

const pStyle = {
  color: 'green'
}

class Show extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      exam: [],
      isLoaded: false,
      current: 0,
      timerStarted: false,
      timerStop: true,
      hours: 0,
      minutes: 20,
      seconds: 0,
      results: [],
      modalIsOpen: false,
    }
  }
  next() {
    const current = this.state.current + 1;
    this.setState({current});
  }
  prev() {
    const current = this.state.current - 1;
    this.setState({current});
  }
  onChange = (current) => {
    this.setState({current});
  }
  componentDidMount() {
    const path = window.location.pathname
    const exam_id = path.substring(path.lastIndexOf('/') + 1)
    fetch(`/api/v1/exams/` + exam_id)
      .then(res => res.json())
      .then(json => {
        this.setState({
          isLoaded: true,
          exam: json,
        })
      });
  }
  countDown = () => {
    if (this.state.timerStop) {
      setInterval(() => {
        this.setState({timerStarted: true, timerStop: false});
        if (this.state.timerStarted) {
          if (this.state.seconds == 0) {
            this.setState((prevState) => ({minutes: prevState.minutes - 1, seconds: 60}));
          }
          if (this.state.minutes < 0) {
            this.setState((prevState) => ({minutes: 0, seconds: 0}))
            return false
          } else {
            this.setState((prevState) => ({ seconds: prevState.seconds - 1}));
          }
        }
      }, 1000)
      setTimeout(() => {
        return this.toggleModal()
      }, ((this.state.minutes * 60 * 1000) + (this.state.seconds * 1000) + 1000))
    }
  }
  onToggle(answer, index, question_index){
    const newExams = this.state.exam.slice();
    newExams[question_index]["answers"][index].checked = !newExams[question_index]["answers"][index].checked
    this.setState({
      exam: newExams
    });
  }
  toggleModal(){
    this.setState({
      modalIsOpen: ! this.state.modalIsOpen
    });
    $.ajax({
      url: "/api/v1/results",
      dataType: 'json',
      type: 'POST',
      data: {exam: this.state.exam},
      success: function(data) {
      }.bind(this),
      error: function(err) {
        console.log(err)
      }.bind(this)
    });
  }
  isLoading() {
    const { exam } = this.state
    return(
      <ModalBody>
          {exam.map((question, index) => (
            <div key={index}>
            <hr />
              <h5>{question.question_content}</h5>
              {question.answers.map((question_answers, i) =>
                <div className="row" key={i}>
                  <div className="col-6">
                    <div key={i}>
                      {
                        (() => {
                          if (question_answers.status == true) {
                            return (
                              <p style={pStyle}>{question_answers.content}</p>
                            )
                          } else {
                            return (
                              <p>{question_answers.content}</p>
                            )
                          }
                        })()
                      }
                    </div>
                  </div>
                  <div className="col-6">
                      <div key={i}>
                        {
                          (() => {
                            if (question_answers.checked == true) {
                              return (
                                <p>{String(question_answers.content)}</p>
                              )
                            } else if (question_answers.checked == false){
                            }
                          })()
                        }
                      </div>
                  </div>
                </div>
              )}
            </div>
          ))}
      </ModalBody>
    )
  }
  render() {
    const { isLoaded, exam, current, results } = this.state;
    const { Step } = Steps;
    if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
      return (
        <div className="container">
          <Button type="danger" onClick={this.toggleModal.bind(this)}>Nop bai</Button>
          <Steps current={current} onChange={this.onChange}>
            {exam.map(item => (
              <Step key={item.question_content} />
            ))}
          </Steps>
          <div className="steps-content">
            <div className="question-content">
              { exam[current].question_content }
            </div>
            <hr />
            <ul>
              {this.state.exam[current].answers.map((answer, i) =>
                <li key={i}>
                   {answer.content}
                  <input type="checkbox" checked={this.state.exam[current].answers[i].checked} onChange={this.onToggle.bind(this, answer, i, current)} />
                </li>
              )}
            </ul>
          </div>
          <div className="steps-action">
            {current < exam.length - 1 && (
              <Button type="primary" onClick={() => this.next()}>
                Next
              </Button>
            )}
            {current > 0 && (
              <Button type="primary" style={{ marginLeft: 8 }} onClick={() => this.prev()}>
                Previous
              </Button>
            )}
          </div>
          <Modal isOpen={this.state.modalIsOpen} className="modal-dialog modal-dialog-centered modal-lg">
            {this.isLoading()}
            <ModalFooter>
              <Button type="secondary" onClick={this.toggleModal.bind(this)} onChange={this.countDown()}>OK</Button>
            </ModalFooter>
          </Modal>
          <div className="timer-container">
            <div className="current-timer">
              {this.state.hours + ":" + this.state.minutes + ":" + this.state.seconds}
            </div>
          </div>
        </div>
      )
    }
  }
}

export default Show;
