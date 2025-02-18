*** Settings ***

*** Variables ***
${NUM_LOUCAS}    5

*** Tasks ***
Lava loucas
    WHILE    ${NUM_LOUCAS} > 0
        Log To Console    \nLouças a serem lavadas: ${NUM_LOUCAS}
        Log To Console    Uma louça está sendo lavada
        ${NUM_LOUCAS}    Evaluate    ${NUM_LOUCAS} - 1
    END
    Log To Console    \nTodas as louças foram lavadas
    