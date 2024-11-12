"use strict";

window.onload = initPage;
window.onload = () => {
    document.getElementsByName('cpf')[0].addEventListener('input', maskCPF);
    document.getElementsByName('confirmPassword')[0].addEventListener('input', checkPassword);
    document.getElementsByName('password')[0].addEventListener('input', checkPassword);
}

function maskCPF() {
    let cpf = document.getElementsByName('cpf')[0];

    if (cpf.value.length < 14){
        cpf.value = cpf.value.replace(/\D/g, '');

        cpf.value = cpf.value.replace(/(\d{3})(\d)/, '$1.$2');
        cpf.value = cpf.value.replace(/(\d{3})(\d)/, '$1.$2');
        cpf.value = cpf.value.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
    }

    if (cpf.value.length > 14) {
        cpf.value = cpf.value.substring(0, 14);
    }

    return cpf.value;
}

function checkPassword() {
    let password = document.getElementsByName('password')[0];
    let passwordConfirmation = document.getElementsByName('confirmPassword')[0];

    if (password.value !== passwordConfirmation.value) {
        passwordConfirmation.setCustomValidity('As senhas não coincidem');
    } else {
        passwordConfirmation.setCustomValidity('');
    }
}


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
 */
function processValidity(form){
    checkPassword();
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