// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.8.0;

contract massConsented{

    address owner;

    constructor () public {
        owner = msg.sender;
    }

    address[] permitted;

    struct trans{
        string name;
        address payer;
        address receiver;
    }

    trans activeTrans;

    mapping(string => address) public role_add_map;

    mapping(address=>bool) add_bool_map;

    mapping(string=>uint) trans_yes_map;
    mapping(string=>uint) trans_no_map;


    modifier onlyOwner {
        require (msg.sender == owner);
        _;
    }

    modifier onlyPermitted{
        require(add_bool_map[msg.sender]);
        _;
    }

    function addPerson (string memory useString, address useAddress) public onlyOwner{
        permitted.push(useAddress);
        role_add_map[useString] = useAddress;
        add_bool_map[useAddress] = true;
    }

    function createTrans (address _payer, address _receiver, string memory _name) public onlyPermitted{
        activeTrans.name = _name;
        activeTrans.payer = _payer;
        activeTrans.receiver = _receiver;
        trans_yes_map[_name] = 0;
        trans_no_map[_name] = 0;
    }

    function voteActiveTransYes () public onlyPermitted{
         trans_yes_map[activeTrans.name] = trans_yes_map[activeTrans.name] + 1;
         if(trans_yes_map[activeTrans.name] >= permitted.length/2){
             //
         }
    }

    function voteActiveTransNo () public onlyPermitted{
        trans_no_map[activeTrans.name] = trans_no_map[activeTrans.name] + 1;
        if(trans_yes_map[activeTrans.name] >= permitted.length/2){
             //
         }
    }

}