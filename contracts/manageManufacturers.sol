pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

contract manageManufacturers{

  address public owner;

  struct manufacturer{
    string manufacturerName;
    string manufacturerLocation;
    address manufacturerAddr;
  }

  mapping(address => manufacturer) public manufacturerByAddress;

  constructor() public {owner=msg.sender;}

  function registerManufacturer(string calldata _manufacturerName, string calldata _manufacturerLocation, address _manufacturerAddr) external onlyOwner returns(bool){
    manufacturer memory newManufacturer;
    newManufacturer.manufacturerName = _manufacturerName;
    newManufacturer.manufacturerLocation = _manufacturerLocation;
    newManufacturer.manufacturerAddr = _manufacturerAddr;
    manufacturerByAddress[_manufacturerAddr] = newManufacturer;
    return true;
  }

  modifier onlyOwner {
      require(msg.sender == owner);
      _;
  }
}
