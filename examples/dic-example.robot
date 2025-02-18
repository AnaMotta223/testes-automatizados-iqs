*** Settings ***

*** Variables ***
&{USUARIOS}    usuario1=joao    usuario2=joao

*** Tasks ***
Example Dic
    Log To Console    ${USUARIOS.usuario1}
