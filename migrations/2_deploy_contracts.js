var manageProducts = artifacts.require("./manageProducts.sol");
var manageManufacturers = artifacts.require("./manageManufacturers.sol");
module.exports = function(deployer) {
      deployer.deploy(manageProducts);
      deployer.deploy(manageManufacturers);
}
