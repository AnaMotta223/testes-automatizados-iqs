*** Settings ***

*** Variables ***
@{LISTA_DE_VEICULOS}    carro    moto    avião    submarino 

*** Test Cases ***
Example List
    Log To Console    \nO primeiro item da lista é: ${LISTA_DE_VEICULOS}[0]
    FOR    ${veiculo}    IN    @{LISTA_DE_VEICULOS}
        Log To Console    ${veiculo}        
    END
    
