document.addEventListener("DOMContentLoaded", function () {
  const startTimeInput = document.querySelector(".start-time-input");
  const endTimeInput = document.querySelector(".end-time-input");
  const totalPriceField = document.querySelector("#booking_total_price");

  startTimeInput.addEventListener("change", updateTotalPrice);
  endTimeInput.addEventListener("change", updateTotalPrice);

  function getTimeInMilliseconds(timeInput) {
    const timeParts = timeInput.split(":");
    const hours = parseInt(timeParts[0], 10);
    const minutes = parseInt(timeParts[1], 10);
    return hours * 3600000 + minutes * 60000; // 1 hour = 3600000 ms, 1 minute = 60000 ms
  }

  function updateTotalPrice() {
    const startTime = getTimeInMilliseconds(startTimeInput.value);
    const endTime = getTimeInMilliseconds(endTimeInput.value);
    const durationInMillis = endTime - startTime;
    const durationInHours = durationInMillis / 3600000; // Convert back to hours
    const ratePerHour = <%= @dj.rate %>; // Replace this with the actual rate of the DJ
    const totalPrice = (durationInHours * ratePerHour).toFixed(2);

    if (isNaN(totalPrice)) {
      totalPriceField.value = "";
    } else {
      totalPriceField.value = totalPrice;
    }
  }
});
