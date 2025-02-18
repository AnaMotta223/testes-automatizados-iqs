*** Settings ***

*** Variables ***
${NUM}    1

*** Tasks ***
Count 1 to 100
    FOR    ${i}    IN RANGE    100
        Log To Console    ${i}
        ${i}    Evaluate    ${i} + 1
    END