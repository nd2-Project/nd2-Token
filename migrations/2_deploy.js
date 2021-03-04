// migrations/2_deploy.js
const nd2Token = artifacts.require("nd2Token");

module.exports = async function (deployer) {
  await deployer.deploy(nd2Token);
};