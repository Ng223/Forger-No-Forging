pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

contract manageProducts{

  address public owner;

  address[] productsInTheMarket;

  constructor() public {owner=msg.sender;}

  function releaseNewProduct(string calldata _productName, uint256 _productId, string calldata _description, uint256 _totalSupply, address _manufacturerAddress) external onlyOwner returns (bool success){
    productSC newProduct = new productSC (_productName, _productId ,_description, _totalSupply, _manufacturerAddress);
    productsInTheMarket.push(address(newProduct));
  }

  function getProductsInTheMarket() public view returns (address[] memory){
  return productsInTheMarket;
}

  modifier onlyOwner {
      require(msg.sender == owner);
      _;
  }
}

contract productSC{

  struct product{
    string productName;
    uint256 productId;
    string description;
    uint256 totalSupply;
    address manufacturer;
  }

  product p;
  uint256 public constant decimal = 0;
  mapping(address => uint256) balances;

  constructor(string memory _productName, uint256 _productId ,string memory _description, uint256 _totalSupply, address _manufacturer) public {
      p.productName = _productName;
      p.productId = _productId;
      p.description = _description;
      p.totalSupply = _totalSupply;
      p.manufacturer = _manufacturer;
      balances[_manufacturer] = _totalSupply;
  }


  function getProductInfo() external view returns (product memory _p){
      _p=p;
      return _p;
  }

  function balanceOf(address entity) external view returns (uint256 balance){
      return balances[entity];
  }

  function transfer(address _to, uint256 _amount) external returns (bool success){
      if (balances[msg.sender] >= _amount
      && _amount > 0
      && balances[_to] + _amount > balances[_to]){
          balances[msg.sender] = balances[msg.sender] - _amount;
          balances[_to] = balances[_to] + _amount;
          emit Transfer(msg.sender, _to, _amount);
          return true;
      }
      else{
          return false;
      }
  }

  event Transfer(
    address indexed _from,
    address indexed _to,
    uint256 _value);

}
