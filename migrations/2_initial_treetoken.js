const TokenFactory = artifacts.require("TokenFactory");
// const TreeToken = artifacts.require("TreeToken");

module.exports = function (deployer) {
  deployer.deploy(TokenFactory,20000);

};
