import React from "react";
import Chart from "./Chart";
import UserList from "./UserList";
import { getLastMonth } from "./selectors";

function App() {
  const lastMonth = getLastMonth();
  return (
    <React.Fragment>
      <UserList />
      <Chart />
    </React.Fragment>
  );
}
export default App;
