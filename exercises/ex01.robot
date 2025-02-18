*** Settings ***   

*** Variables ***
${NUM1}    4
${NUM2}    8

*** Tasks ***
Soma de Valores
    Log To Console    \nA soma é: ${${NUM1} + ${NUM2}}