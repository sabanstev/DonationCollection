pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol"; // Подключаем для использования модификатора onlyOwner

contract DonationCollection is Ownable {
    mapping (address => uint) public donatList; // список донатеров с суммами

    function giveDonation() external payable { // Пожертвовать деньги
        donatList[msg.sender] += msg.value; // Добавляем/обновляем  запись о пожертвовавшем
    }

    function withdrawalOfFunds(uint _transferAmount, address payable _transferAddress) external onlyOwner { // Входные параметры сумма перевода и адрес перевода.
        require(address(this).balance >= _transferAmount, "insufficient funds"); // Если сумма для перевода больше чем собранно, то ошибка
        bool check = _transferAddress.send(_transferAmount); // Производим транзакцию
        require(check, "Error"); // Проверяем всё ли прошло хорошо 
    }
}