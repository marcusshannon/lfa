import { data } from "./data";

export function getRawReactions() {
  return data.raw_reactions;
}

export function getRawMessages() {
  return data.raw_messages;
}

export function getLastMonth() {
  return getRawMessages()
    .map(message => {
      return { ...message, ts: parseInt(message.ts.split(".")[0]) };
    })
    .filter(message => {
      //   const currentTime = new Date().getTime() / 1000;
      return 1546307799 - 2629743 < message.ts;
    });
}

function formatData(data) {
  return data;
}
