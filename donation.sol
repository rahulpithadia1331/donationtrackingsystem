pragma solidity ^0.5.0;

contract donation {
 
    address public donor;
    address  public NGO ; 
    address  public Victim;
    mapping (address => uint) public balances;
    
    constructor() public{
        donor = msg.sender;
    }
    
    modifier Donor{
        require(msg.sender == donor);
        _;
    }
    
    event Sent(address from, address to, uint amount);

    
    function depositFundIntoWallet() public payable {
        require(msg.value != 0, "You need to deposit some amount of funds into wallet!");
        balances[msg.sender] += msg.value;
    }
   
    function donatetoNGO(address _NGO, uint amount) public  {
        require(amount <= balances[msg.sender], "You have insuffient funds to withdraw");
        balances[msg.sender] -= amount;
        balances[_NGO] += amount;
       NGO = _NGO;
        emit Sent(msg.sender, _NGO, amount);
    }

    function donatetoVictim(address  _victim, uint amount) public  {
         Victim = _victim;
        require(amount <= balances[msg.sender], "You have insuffient funds to withdraw");
        balances[msg.sender] -= amount;
        balances[_victim] += amount;
         Victim = _victim;
    }
    
   
}
