*** Settings ***

*** Variables ***
${NUM}    1

*** Tasks ***
Count 1 to 100
    WHILE    ${NUM} <= 100
        Log To Console    ${NUM}
        ${NUM}    Evaluate    ${NUM} + 1
    END