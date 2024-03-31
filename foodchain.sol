pragma solidity ^0.8.0;

contract FoodSupplyChain {
    struct Product {
        uint id;
        string name;
        uint quantity;
    }
    
    mapping(uint => Product) public products;
    uint public productCount;
    
    constructor() {
        productCount = 0;
    }
    
    function addProduct(uint _productId, string memory _name, uint _quantity) public {
        require(_productId > 0, "Invalid product ID");
        
        if(products[_productId].id == 0) {
            // If the product is new, add it
            productCount++;
            products[_productId] = Product(_productId, _name, _quantity);
        } else {
            // If the product already exists, increase its quantity
            products[_productId].quantity += _quantity;
        }
    }
    
    function buyProduct(uint _productId, uint _quantity) public returns (string memory) {
        require(products[_productId].id > 0, "Product not available");
        require(products[_productId].quantity >= _quantity, "Insufficient quantity available");
        
        // Additional logic for purchase handling (e.g., payment)
        products[_productId].quantity -= _quantity;
        
        return "Purchase successful";
    }
    
    function getAvailableProducts() public view returns (uint[] memory, string[] memory, uint[] memory) {
        uint[] memory ids = new uint[](productCount);
        string[] memory names = new string[](productCount);
        uint[] memory quantities = new uint[](productCount);
        
        uint index = 0;
        for(uint i = 1; i <= productCount; i++) {
            if(products[i].quantity > 0) {
                ids[index] = products[i].id;
                names[index] = products[i].name;
                quantities[index] = products[i].quantity;
                index++;
            }
        }
        
        return (ids, names, quantities);
    }
}
