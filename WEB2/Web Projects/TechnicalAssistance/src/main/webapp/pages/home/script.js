window.onload = () => {
    let alerts = document.querySelector('.alert-message')

    if (alerts) {
        setTimeout(() => {
            alerts.style.display = 'none'
        }, 3000)
    }
}