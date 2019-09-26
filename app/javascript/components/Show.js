import React, { useState, useEffect } from "react"

function Show(id){
  useEffect(() => {
    fetchExam();
  }, []);

  const [exam, setExam] = useState({});

  const fetchExam = async () => {
    const fetchExam = await fetch('/api/v1/exams/' + id.id);
    const exam = await fetchExam.json();
    setExam(exam);
  };
  var rows = [];

  if (exam.length) {
    rows = exam.map((item, index) => (
      <div key={index}>
        Question: {item.question_content}
        Level: {item.level}
      </div>
  ))
 }

  return (
    <div>
      {rows}
    </div>
  )
}

export default Show;
