document.addEventListener("DOMContentLoaded", function () {
  const startDateInput = document.querySelector(".start-date-input");
  const endDateInput = document.querySelector(".end-date-input");
  const totalPriceField = document.querySelector("#booking_total_price");

  startDateInput.addEventListener("change", updateTotalPrice);
  endDateInput.addEventListener("change", updateTotalPrice);

  function updateTotalPrice() {
    const startDate = new Date(startDateInput.value);
    const endDate = new Date(endDateInput.value);
    const days = (endDate - startDate) / (1000 * 60 * 60 * 24);
    const rate = <%= @dj.rate %>; // Replace this with the actual rate of the DJ
    const totalPrice = days * rate;

    if (isNaN(totalPrice)) {
      totalPriceField.value = "";
    } else {
      totalPriceField.value = totalPrice.toFixed(2); // Format the total price to 2 decimal places
    }
  }
});
