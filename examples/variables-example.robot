*** Settings ***

*** Variables ***
${NOME}     Ana
${NUM1}    2
${NUM2}    3
${SENHA}   123

*** Tasks ***
Show Username
    IF    '${NOME}' == 'Raul' and '${SENHA}' == '123'
        Log To Console    \nBem vindo ${NOME}!
    END