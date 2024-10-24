"use strict";

window.onload = initPage;
window.onload = () => {
    document.getElementById('zipcode').addEventListener('input', searchCep);
    document.getElementById('zipcode').addEventListener('input', maskZipcode);
    document.getElementsByName('cpf')[0].addEventListener('input', maskCPF);
    document.getElementsByName('phone')[0].addEventListener('input', maskPhone);
}

function maskZipcode() {
    let cep = document.getElementsByName('zipcode')[0];

    if (cep.value.length < 9) {
        cep.value = cep.value.replace(/\D/g, '');
        cep.value = cep.value.replace(/^(\d{5})(\d)/, '$1-$2');
    }

    if (cep.value.length > 9) {
        cep.value = cep.value.substring(0, 9);
    }

    return cep.value;
}


function maskPhone() {
    let phone = document.getElementsByName('phone')[0];
    phone.value = phone.value.replace(/\D/g, '');

    if (phone.value.length > 10) {
        phone.value = phone.value.replace(/^(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
    } else {
        phone.value = phone.value.replace(/^(\d{2})(\d{4})(\d{4})/, '($1) $2-$3');
    }

    if (phone.value.length > 15) {
        phone.value = phone.value.substring(0, 15);
    }

    return phone.value;
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

async function searchCep(){

    let cep = document.getElementById('zipcode').value.replace(/\D/g, '');

    let street = document.getElementById('street');
    let neighborhood = document.getElementById('neighborhood');
    let city = document.getElementById('city');
    let state = document.getElementById('state');

    if (cep.length < 8) {
        street.value = '';
        neighborhood.value = '';
        city.value = '';
        state.value = '';
        return;
    }

    try {
        let url = 'https://viacep.com.br/ws/'+cep+'/json/';
        let response = await fetch(url);
        let data = await response.json();

        if (data.erro || data.logradouro == undefined) return;

        street.value = data.logradouro;
        neighborhood.value = data.bairro;
        city.value = data.localidade;
        state.value = data.uf;
    } catch (e) {
        console.log('Erro ao buscar CEP: ' + e);
    }

}