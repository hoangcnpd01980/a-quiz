import React from "react"
import Show from "components/Show"

const routes = [
  {
    path: '/admin/exams/:id',
    exact: true,
    main: ({match}) => <Show match={match} />
  }
];

export default routes;
