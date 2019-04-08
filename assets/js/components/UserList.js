import React, { useContext } from "react";
import { BackendContext } from "./App";
import styled from "styled-components";

const User = styled.div`
  font-family: sans-serif;
  width: 100px;
  text-align: center;
  border-radius: 3px;
  background-color: seagreen;
  color: white;
  padding: 10px;
  &:hover {
    background-color: slateblue;
    cursor: pointer;
  }
`;

const Container = styled.div`
  display: flex;
`;

function UserList() {
  const { users } = useContext(BackendContext);
  return (
    <Container>
      {Object.entries(users).map(([key, user]) => (
        <React.Fragment key={key}>
          <User>{user.name}</User>
        </React.Fragment>
      ))}
    </Container>
  );
}

export default UserList;
