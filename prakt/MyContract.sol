// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MyContract {

// Data Types

    // 1. STRING = 
        string public myString = "MyString";
    // 2. BOOLEAN
        bool public boolean1 = true;
    // 3. INTEGERS
        int public num = 5 * (4 + 6);
    // 4. UNSIGNED INTEGERS
        uint public myUint = 1;
    // 5. ADDRESS
        address public myAddress = 0x73af10f5fdeaE72987224866411d802E423c6BC0;



    string name = "Example"; 

    // 6. FUNCTIONS
        // This is a write function and requires gas fee. The function is public so it is available outside the smart contract and can also be inherited and cslled inside another function
        function setName(string memory _name) public {
            name = _name;
        }

        // This is a read function and does not cost any gas. View is a modifier which stipulates that this function is a read function and cant modify the state of a blockchsin
        function getMyString() public view returns (string memory){
            return myString;
        }

        // setting the function to internal means it will only be accesible inside this smart contract but can be inherited
        function resetName() internal {
            // calling public function in smart contract
            getMyString();
            name = "hello";
        }

        // setting the function to private means it will only be accesible inside this smart contract and called in another funcion in the same contract
        function resetName2() private  {
            name = "hello";
        }

        uint public _myUint = 5 * (4 +6);
        // This function can only be called outside of this smart contract
        function increament(uint _num) external  {
            // calling private function
            resetName2();
            _myUint += _num;
        }


    // MODIFIERS

        // VIEW
        // This is a read function and does not cost any gas. View is a modifier which stipulates that this function is a read function and cant modify the state of a blockchsin
        function read() public view returns (string memory){
            return myString;
        }

        // PURE
        // Pure functions do not read nor modify the state
        function add(uint a, uint b) public pure returns (uint){
            return a + b;
        }

        uint public balance;

        // PAYABLE
        // payable functions are allowed to receip=ve ether crypto whenever the tx is submitted
        function pay() public payable {
            balance = msg.value;
        }


    // CUSTOM MODIFIERS
        // solidity also lets you create your own modifiers which can be applied to functions

        address private owner;
        string public user = "";


        modifier onlyOwner() {
            // this modifies who sends a message. in this case the sender must be the owner.
            require(msg.sender == owner, 'You are not the owner');
            _; // call the function that is after the modifier
        }

        // apply the modifier like so
        function setUser(string memory _who) onlyOwner public {
            user = _who;
        }

    // CONNSTRUSCTORS
        // This function is ran once and only once when the contract is first initialised. constructors can be payable or non payable but is view

        // constructor(string memory _user) {
        //     user = _user;
        // }


    // GLOBAL VARIABLES 

        address public contractAddress;
        address public msgSender;
        address public origin;
        uint public amount;

        // THIS = this refers to the address of current smart contracts
        constructor() {
            contractAddress = address(this);
        }

        // MSG = sontaiuns properties of the current action like sender: which is the person performing the transaction, and value: which is the amount of crypto involved in the tx
        // TX = which is the current transaction. you can get the origin of the tx 
        function payTo() public payable {
            msgSender = msg.sender;
            amount = msg.value;
            origin = tx.origin;
        }


        // BLOCK = which contains details of the current block on the chain
        function getBlockInfo() public view returns (uint, uint, uint) {
            return ( 
                block.chainid, 
                block.number, 
                block.timestamp
            );
        }


    // OPERATORS 
        // Basic mathematical operators in solidity

        function addOperator(uint a, uint b) external pure returns (uint){
            return a + b;
        }

        function subtractOperator(uint a, uint b) external pure returns (uint){
            return a - b;
        }

        function multiplyOperator(uint a, uint b) external pure returns (uint){
            return a * b;
        } 

        function divideOperator(uint a, uint b) external pure returns (uint){
            return a / b;
        }

        function exponentOperator(uint a, uint b) external pure returns (uint){
            return a ** b;
        }

        function modulusOperator(uint a, uint b) external pure returns (uint){
            return a % b;
        }

        function incrementOperator(uint a) external pure returns (uint){
            a++;
            return a;
        }

        function decrementOperator(uint a) external pure returns (uint){
            if (a < 5) {
                a--;
            } else {
                return a;
            }
            return a;
        }

    
    // ARRAYS
        // array of type uint
        uint[] public array1 = [1, 2, 3];
        // initialize a uint type public array without a specific size
        uint[] public array2;
        // initialize uint type array with fixed length
        uint[10] public array3;
        // array of type string
        string[] public array4 = ["apple", "banana", "carrot"];
        // initialize a public array
        string[] public array5;
        // initialize string type array with fixed length
        string[10] public array6;

        function getArray(uint _index) external view returns (string memory) {
            return array4[_index];
        }

        function addToArray() external {
            // adding to the end of the array
            array5.push("hello");
            // adding to the beginning of the array
            array5.push("world");
            // adding to the beginning of the array
            array5.push("how");
            // adding to the beginning of the array
            array5.push("are");
            // adding to the beginning of the array
            array5.push("you");
        }

        function  length() public view returns (uint) {
            return array3.length;
        }

        function removeArrayItem(uint _index) public {
            delete array4[_index];
        }


    // MAPPINGS
        // mapping is a way to store information in smart contracts. It type of data structure which is similar to a hash table or dictionary in python or javascript. it takes a key value pair and allows you to access the value using a key


        // mapping(keyType => valueType) is the syntax for mapping in solidity
        mapping (uint => string) public names;
        mapping (string => uint) public nameToNumber;
        mapping (uint => address) public idToAddress;
        mapping (uint => address) internal idToAddressInternal;
        mapping (uint => uint) private idToPricePrivate;
        mapping (address => uint) private balances;
        mapping (address => bool) private hasVoted;
        mapping (address => mapping (address => uint)) internal tokenToOwnerBalances;


        function setMapping(uint _id, string memory _name) external {
            names[_id] = _name;
            nameToNumber[_name] = _id;
        }

        // get mapping detail
        function getName(uint _id) external view returns (string memory) {
            return names[_id];
        }

        function removeMapping(uint _id) public {
            delete names[_id];
        }


    // STRUCTS 

        // we can create custom types with structs, here we are creating a type of Book, with attributes of title, author and status of completion bool
        struct Book {
            string title;
            string author;
            bool completed;
        }

        // we can use this type by creatingh an array of type book
        Book[] public books;

        // we can also use this type to create a mapping of type book
        mapping(uint => Book) public bookToId;

        /*
            The outer address key maps to another mapping, which then maps a uint key (likely representing a book ID or index) to a Book struct.
            This allows the contract to store and manage multiple books for each address.
            For example, if you have an address 0x123... and you want to access the book with ID 5 owned by this address, you would retrieve it using bookOwnerToIdBooks[0x123...][5].
        */
        mapping(address => mapping(uint => Book)) internal bookOwnerToIdBooks;
        // here we are saving a book whose title returns a book
        mapping(string => mapping(string => Book)) internal bookTitleToAuthorBooks;

        function addBook(string memory _title, string memory _author) public {
            Book memory newBook = Book(_title, _author, false);
            books.push(newBook);

            // or

            books.push(Book(_title, _author, false));
        }

        function getBook(uint _index) public view returns (Book memory) {
            return books[_index];
        }

        function getBookOwner(address _owner, uint _id) public view returns (Book memory) {
            return bookOwnerToIdBooks[_owner][_id];
        }

        function getBookTitleAuthor(string memory _title, string memory _author) public view returns (Book memory) {
            return bookTitleToAuthorBooks[_title][_author];
        }

        function getBooksLength() public view returns (uint) {
            return books.length;
        }

        // update book read status
        function completed(uint _index) public {
            books[_index].completed = true;
        }

    // EVENTS

        // solidity lets you subscribe to events to find out anytime a function or something inside of a function has been called

        string public message = "Hello world";


        event MessageUpdated (
            // the attributes in here can be any data type you want and can have up to  17 of these attributes and can index up to 3
            // index3ed means we can filter through events or subscribe to events that only pertain to a particular user
            address indexed _user,
            string _message
        );

        function updateMessage(string memory _message) public {
            message = _message;
            // trigger the event after function executes
            emit MessageUpdated(msg.sender, _message);
        }

        // Anytime that this function is called , there is a record of it on the blockchain that one can go back and look at.
        // You can also get notifications in realtime because we can subscribe to the event externally and get push notifications of some sorts
        // We can also get a history of every single time that the message has been emmited
    
    
    // ETHER & GWEI

        // 1 wei is equal to 1 wei
        uint public value1 = 1 wei;
        uint public value2 = 1;

        // 1 gwei is equal to 1billion wei
        uint public value3 = 1 gwei;
        uint public value4 = 1000000000;

        // 1 ether is equal to 1 followed by 18 decimal places
        uint public value5 = 1 ether;
        uint public value6 = 1000000000000000000; 

        // you can receive ether to a smart contrac with the receive function if you call an external and payable
        receive() external payable { }

        // you can also use the fallback function if no receive function is implemented or if msg data is not present

        uint public count = 0;

        fallback() external payable { 
            count ++;
        }


    // BALANCES and TRANSACTIONS

        // you can check the balance of any smart contract 
        function checkBalance() public view returns (uint) {
            return address(this).balance;
        }

        // you can send ether to a different address will CALL, any function can receive ether as long as they have a payable modifier
        function transfer(address payable _to) public payable {
            // we can check for the success of this message and we can add a require
            (bool sent, ) = _to.call{value: msg.value}("");
            require(sent, "Failed");
        }

    
    // ERROR HANDLING

        // Most common way is to use the require() function, this checks if the given value/argument is true or false

        event Log(string message);

        function errorExample(uint _value) public payable {
            // this requires the argument to be true before running the function else itll throw the error
            require(_value > 10, "Must be greater than 10");
            emit Log("success");
        }

        // another way is to use the revert function. 
        function errorExample2(uint _value) public payable {
            if (_value <= 10) {
                revert("Must be greater than 10");
            }
            emit Log("success");
        }

}

// INHERITANCE

// This contract encapsulates all the behaviour of a contract that restricts function calls to the person who deployed the contract to the blockchain or the owner


contract Ownable {

    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Caller must be owner");
        _;
    }
}

contract willInherit is Ownable {
    string public name = "I am inheriting ownable contract";

    function setName(string memory _name) public onlyOwner {
        name = _name;
    }
}


// or you can inherit an imported contract

import "contracts/2_Owner.sol";

contract willInheritImported is Owner {
    string public name = "I am inheriting ownable contract";

    function setName(string memory _name) public isOwner {
        name = _name;
        changeOwner(msg.sender);
    }
}


// INTERACTION BETWEEN CONTRACTS

contract SecretVault {
    string private secret;

    constructor(string memory _secret) {
        secret = _secret;
    }

    function setSecret(string memory _secret) external {
        secret = _secret;
    }

    function getSecret() external view returns (string memory) {
        return secret;
    }
}

contract SecretManager {
    SecretVault public secretVault;

    constructor(SecretVault _secretVault) {
        secretVault = _secretVault;
    }

    function getSecret() public view returns (string memory) {
        return secretVault.getSecret();
    }

    function setSecret(string memory _secret) public {
        return secretVault.setSecret(_secret);
    }
}


// INTERFACES

    // To my understanding i think its just same as interface in typescript, so you define the tpes and values of a type. 
    // this is when you dont need the complete code of anothe smart contract on chain
interface IERC20 {
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
}

contract Transfer {
    function erc20Transfer(IERC20 _token, address _to, uint _value) external returns (bool) {
        return _token.transferFrom(msg.sender, _to, _value);
    }
}
// or
contract TransferTwo {
    function erc20Transfer(address _tokenAddress, uint _amount) external returns (bool) {
        return IERC20(_tokenAddress).transferFrom(msg.sender, address(this), _amount);
    }
}