import React from "react";
import Chart from "./Chart";
import UserList from "./UserList";

const initialState = JSON.parse(
  document.getElementById("initial-state").dataset["initialState"]
);
console.log("initialState: ", initialState);

export const BackendContext = React.createContext(null);

function App() {
  return (
    <BackendContext.Provider value={initialState}>
      <React.Suspense fallback={null}>
        <UserList />
        <Chart />
      </React.Suspense>
    </BackendContext.Provider>
  );
}
export default App;
