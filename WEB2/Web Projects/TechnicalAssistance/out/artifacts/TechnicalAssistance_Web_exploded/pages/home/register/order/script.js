window.onload = () => {
    select_customer()
    validade()
}

let input = document.getElementById('selected-customer');
console.log(input.innerHTML);

function validade() {
    let form = document.getElementById('form');
    form.addEventListener('submit', (e) => {
        if (!validateSelects()) {
            e.preventDefault();
        }
    });
}


function select_customer() {
    let inputs = document.getElementsByName('customer');

    for (let i = 0; i < inputs.length; i++) {
        let div = document.getElementById('div-' + i);

        div.addEventListener('click', () => {
            let input = document.getElementById('input-' + i);
            input.checked = true;

            let label = document.getElementById('selected-customer');
            label.innerHTML = "Cliente - " + document.getElementById('customer-name-' + i).innerHTML;
        }
        );
    }
}

function validateSelects(){
    let statusSelected = document.getElementById('status-select');
    let paymentSelected = document.getElementById('paymentMethod-select');
    let input = document.getElementById('selected-customer');


    if(statusSelected.value === "disabled"){
        alert("Selecione um status");
        return false;
    }

    if(paymentSelected.value === "disabled"){
        alert("Selecione um método de pagamento");
        return false;
    }

    if(input.innerHTML === "Selecione o Cliente"){
        alert("Selecione um cliente");
        return false;
    }

    return true;
}