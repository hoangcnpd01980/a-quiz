import React from 'react';
import { Steps, Button, message } from 'antd';
import 'antd/dist/antd.css';

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
    }
  }
  next() {
    const current = this.state.current + 1;
    this.setState({current});
  }
  countDown = () => {
    if (this.state.timerStop) {
      setInterval(() => {
        this.setState({timerStarted: true, timerStop: false});
        if (this.state.timerStarted) {
          if (this.state.seconds == 0) {
            this.setState((prevState) => ({minutes: prevState.minutes - 1, seconds: 60}));
          }
          if (this.state.minutes == -1) {
            return false;
          } else {
            this.setState((prevState) => ({ seconds: prevState.seconds - 1}));
          }
        }
      }, 1000)
    }
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
  onToggle(answer, index, question_index){
    const newExams = this.state.exam.slice();
    newExams[question_index]["answers"][index].checked = !newExams[question_index]["answers"][index].checked
    this.setState({
      exam: newExams
    });
  }
  render() {
    const { isLoaded, exam, current } = this.state;
    const { Step } = Steps;
    if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
      return (
        <div className="container">
          <div className="timer-container">
            <div className="current-timer">
              {this.state.hours + ":" + this.state.minutes + ":" + this.state.seconds}
            </div>
          </div>
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
            {current === exam.length - 1 && (
              <Button type="primary" onClick={() => message.success('Processing complete!')}>
                Done
              </Button>
            )}
            {current > 0 && (
              <Button type="primary" style={{ marginLeft: 8 }} onClick={() => this.prev()}>
                Previous
              </Button>
            )}
          </div>
        </div>
      )
    }
  }
}

export default Show;
