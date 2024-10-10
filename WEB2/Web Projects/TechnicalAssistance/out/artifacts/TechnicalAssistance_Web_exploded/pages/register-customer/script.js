"use strict"

window.onload = initPage;

function initPage(){
    let form;
    form = document.getElementById('form');
    // desativar a validação automática do HTML5
    form.noValidate = true;
    form.addEventListener('submit', function(e){
        let valid = processValidity(this);
        if(!valid){
            e.preventDefault();
        }
    });
}

/**
 * Processa a validade dos campos do formulário, criada para caso seja necessário adicionar mais validações
 * @param form
 * @returns {boolean}
 */
function processValidity(form){
    return applyValidity(form);
}

function applyValidity(form){
    let valid = true;
    let count = 0;
    let elements = form.elements;
    for(let i = 0; i < elements.length - 1; i++){
        let element = elements[i];
        let span = document.getElementById(i);
        if(!element.validity.valid){
            span.innerHTML = element.validationMessage;
            count++;
        }else{
            span.innerHTML = "";
        }
    }
    if(count > 0){
        valid = false;
    }
    return valid;
}