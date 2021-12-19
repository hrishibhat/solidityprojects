// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Item.sol';
import "./Ownable.sol";

contract ItemManager is Ownable{
    enum SuppyChainSteps {Created, Paid, Delivered}
    
    struct S_Item {
        Item _item;
        ItemManager.SuppyChainSteps _step;
        string _name;
    
    }
    mapping(uint => S_Item) public items;
    uint index;

    event SupplyChainStep(uint _itemIndex, uint _step);
    event SupplyChainStep(uint _itemIndex, uint _step, address _address);

    function createItem(string memory _name, uint _priceInWei) public onlyOwner {
        Item item = new Item(this, _priceInWei, index);
        items[index]._item = item;
        items[index]._step= SuppyChainSteps.Created;
        items[index]._name = _name;
        emit SupplyChainStep(index, uint(items[index]._step), address(item));
    }

    function triggerPayment(uint _index) public payable {
        Item item = items[_index]._item;
        require(address(item) == msg.sender, "Only items are allowed to update themselves");
        require(item.priceInWei() == msg.value, "Not fully paid yet");
        require(items[_index]._step == SuppyChainSteps.Created, "Item is further in the supply chain");
        items[index]._step= SuppyChainSteps.Paid;
        emit SupplyChainStep(_index, uint(items[_index]._step), address(item));
    }

    function triggerDelivery(uint _index) public onlyOwner {
        require(items[_index]._step == SuppyChainSteps.Paid, "Item is further in the supply chain");
        items[index]._step= SuppyChainSteps.Delivered;
        emit SupplyChainStep(_index, uint(items[_index]._step), address(items[_index]._item));
    }    

}