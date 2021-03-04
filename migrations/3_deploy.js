// migrations/3_deploy.js
const nd2Reward = artifacts.require("nd2Gift");

module.exports = async function (deployer) {
  await deployer.deploy(nd2Reward, "0xe78A0F7E598Cc8b0Bb87894B0F60dD2a88d6a8Ab");
};