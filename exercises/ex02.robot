*** Settings ***   

*** Variables ***
${NUM}    3

*** Tasks ***
Antecessor e sucessor de um número
    Log To Console    \nO antecessor de ${NUM} é ${${NUM} - 1} e o sucessor é ${${NUM} + 1} 