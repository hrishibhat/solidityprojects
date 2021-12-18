// SPDX-License-Identifier: MIT

contract ItemManager {
    enum SuppyChainSteps {Created, Paid, Delivered}
    
    struct S_Item {
        ItemManager.SuppyChainSteps _step;
        string _name;
        uint _priceInWei;
    }
    mapping(uint => S_Item) public items;
    uint index;

    event SupplyChainStep(uint _itemIndex, uint _step);

    function createItem(string memory _name, uint _priceInWei) public {
        items[index]._priceInWei = _priceInWei;
        items[index]._step= SuppyChainSteps.Created;
        items[index]._name = _name;
        emit SupplyChainStep(index, uint(items[index]._step));
    }
}