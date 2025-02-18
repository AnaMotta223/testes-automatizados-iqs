*** Settings ***
Library    SeleniumLibrary

Documentation    IQS - Automação de Testes WEB
...    Exemplo de Automação com Robot Framework e SeleniumLibrary


Test Setup    Run KeywordS   
...        Open Browser    url=${URL}    browser=${BROWSER}    AND
...        Maximize Browser Window    
Test Teardown    Close Browser    

# *** Keywords *** EXAMPLE
# Open Browser and Maximize
#     Open Browser    url=https://www.saucedemo.com/v1/    browser=chrome
#     Maximize Browser Window

*** Variables ***
#Config
${URL}    https://www.saucedemo.com/v1/
${BROWSER}    chrome

#Page Object Model
&{LOGIN_PAGE}    
...    UsernameInput=id:user-name    
...    PasswordInput=css:#password      
...    LoginButton=xpath://*[@id="login-button"]
...    ErrorMessage=data:test:error

#Credentials
${VALID_USER}    standard_user
${LOCKED_USER}    locked_out_user
${PASSWORD}    secret_sauce

*** Keywords ***
Realizar login com ${username} e ${password}
    Input Text    locator=${LOGIN_PAGE.UsernameInput}    text=${username}
    Input Password    locator=${LOGIN_PAGE.PasswordInput}    password=${password}
    Click Button    locator=${LOGIN_PAGE.LoginButton}

#verifications
Verificar se conseguiu realizar o login
    ${url}=    Get Location
    Should Contain    ${url}    /inventory.html

Verificar se não foi possível realizar o login
    ${message}=    Get Text    locator=${LOGIN_PAGE.ErrorMessage}     
    ${expected_message}    Set Variable    Epic sadface: Sorry, this user has been locked out.
    ${message}    Get Text    locator=${LOGIN_PAGE.ErrorMessage} 

*** Test Cases ***
CT01 - Realizar login com usuário válido
    #setup sao rotinas executadas antes do teste
    #run keywords executa um conjunto de comandos juntos com do and, poderia ser feito direto por keywords
    [Tags]    FLUXO-POSITIVO    REQ001
    [Documentation]    Esse caso de teste valida o login do usuário
    Realizar login com ${VALID_USER} e ${PASSWORD}
    Verificar se conseguiu realizar o login
    # Sleep      2s

CT02 - Realizar login com usuário bloqueado
    [Tags]    FLUXO-NEGATIVO    REQ002
    [Documentation]    Esse caso de teste valida o bloqueio de login do usuário
    Realizar login com ${LOCKED_USER} e ${PASSWORD}
    Verificar se não foi possível realizar o login
    
    