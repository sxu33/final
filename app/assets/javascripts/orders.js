document.addEventListener("turbo:load", () => {
    const addressForm = document.getElementById("address_form");
    if (addressForm) {
        addressForm.addEventListener("ajax:success", (event) => {
            const [data, status, xhr] = event.detail;
            const invoiceElement = document.getElementById("invoice");
            invoiceElement.innerHTML = xhr.response;
        });
    }
});
