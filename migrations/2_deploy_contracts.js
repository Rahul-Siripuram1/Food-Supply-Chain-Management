const Farmsupply = artifacts.require("Farmsupply");

module.exports = function(deployer) {
  deployer.deploy(Farmsupply);
};
