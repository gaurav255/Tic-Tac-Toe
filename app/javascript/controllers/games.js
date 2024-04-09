// app/assets/javascripts/games.js
document.addEventListener('DOMContentLoaded', function() {
  const cellButtons = document.querySelectorAll('.cell-button');
  cellButtons.forEach(button => {
    button.addEventListener('click', function() {
      if (!button.classList.contains('disabled')) {
        button.closest('form').submit();
      }
    });
  });
});
