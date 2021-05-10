// Get the modal
var modal = document.getElementById('menu1_modal');
var modal2 = document.getElementById('menu2_modal');
var modal3 = document.getElementById('menu3_modal');

// Get the button that opens the modal
var btn = document.getElementById("menu1");
var btn2 = document.getElementById("menu2");
var btn3 = document.getElementById("menu3");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];
var span2 = document.getElementsByClassName("close2")[0];
var span3 = document.getElementsByClassName("close3")[0];

// When the user clicks the button, open the modal 
btn.onclick = function () {
    modal.style.display = "block";
};
btn2.onclick = function () {
    modal2.style.display = "block";
};
btn3.onclick = function () {
    modal3.style.display = "block";
};

// When the user clicks on <span> (x), close the modal
span.onclick = function () {
    modal.style.display = "none";
};
span2.onclick = function () {
    modal2.style.display = "none";
};
span3.onclick = function () {
    modal3.style.display = "none";
};

// When the user clicks anywhere outside of the modal, close it
window.onclick = function (event) {
    if (event.target === modal) {
        modal.style.display = "none";
    }
    if (event.target === modal2) {
        modal2.style.display = "none";
    }
    if (event.target === modal3) {
        modal3.style.display = "none";
    }
};