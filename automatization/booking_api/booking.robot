*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

#cria uma sessao (como se fosse no postman) para requisicao
#como é uma sessao, pode usar o alias e a url para salvar as informacoes e usar abaixo
Suite Setup    Create Session    alias=${SESSION_NAME}    url=${BASE_URL}

*** Variables ***
${SESSION_NAME}    iqs
${BASE_URL}    https://restful-booker.herokuapp.com
${PAYLOADS_DIR}     ${CURDIR}${/}payloads
${CONTRACTS_DIR}     ${CURDIR}${/}contracts    

*** Keywords ***
POST /${endpoint}
    #url abaixo é o endpoint usado na requisicao
    [Arguments]    ${filename}    ${expected_status}
    ${payload}=    Load Json From File    ${PAYLOADS_DIR}${/}${filename}
    ${response}=    POST On Session    alias=${SESSION_NAME}    url=/${endpoint}    json=${payload}    expected_status=${expected_status}
    RETURN    ${response}

GET /${endpoint}
    [Arguments]    ${expected_status}
    ${response}=    GET On Session    alias=${SESSION_NAME}    url=/${endpoint}    expected_status=${expected_status}
    RETURN    ${response}

Validate Json
    [Arguments]    ${response}    ${filename}
    Validate Json By Schema File    ${response.json()}    ${CONTRACTS_DIR}${/}${filename}

Select Random ID From Booking List
    ${response}=   GET /booking    200
    ${bookingid}=    Evaluate    random.choice($response.json())['bookingid']    modules=random
    RETURN    ${bookingid}

*** Test Cases ***
CT1: Realizar autenticação com um usuário válido
    ${response}=    POST /auth    PostAuthValid.json    200  
    Validate Json    ${response}    CreateTokenValid.json

CT2: Realizar autenticação com um usuário inválido
    ${response}=   POST /auth    PostAuthInvalid.json    200
    Validate Json    ${response}    CreateTokenInvalid.json

CT3: Obter reservas 
    ${response}=   GET /booking    200
    Validate Json    ${response}    GetBooking.json
    
CT4: Obter uma reserva por ID 
    ${bookingid}=     Select Random ID From Booking List
    ${response}    GET On Session    alias=${SESSION_NAME}    url=/booking/${bookingid}    expected_status=200
    Validate Json    ${response}    GetBookingIds.json    

CT5: Criar uma reserva
    ${response}=   POST /booking    PostBooking.json    200
    Validate Json    ${response}    CreateBooking.json

    ${bookingid}    Set Variable    ${response.json()}[bookingid]
    ${booking}    Set Variable    ${response.json()}[booking]

    ${response}    GET /booking/${bookingid}    200
    Dictionaries Should Be Equal    ${booking}    ${response.json()}   

CT6: Substituir uma reserva
     