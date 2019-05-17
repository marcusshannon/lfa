import React from "react";
import styled from "styled-components";
import { data } from "./data";

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
  const { users } = data;
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
