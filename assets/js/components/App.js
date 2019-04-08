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
        {/* <UserList />
        <Chart /> */}
        <form action="/users" method="post">
          <input type="hidden" value={initialState.token} name="_csrf_token" />
          <h1>User creation form</h1>
          <div>
            <label htmlFor="name">
              username: <input type="text" id="name" name="name" />
            </label>
          </div>
          <div>
            <label htmlFor="slack_id">
              slack id: <input type="text" id="slack_id" name="slack_id" />
            </label>
          </div>
          <button type="submit">create user</button>
        </form>
      </React.Suspense>
    </BackendContext.Provider>
  );
}
export default App;
