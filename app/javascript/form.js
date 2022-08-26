window.addEventListener("turbo:load", function(event) {
    inputRadio = document.getElementById('inputRadio');
    fileRadio = document.getElementById('fileRadio');
    input = document.getElementById('textField');
    file = document.getElementById('fileField');

    inputRadio.addEventListener('change', e => {
        if(e.target.checked){
            input.disabled = false;
            file.disabled = true;
        } else {
            input.disabled = true;
            file.disabled = false;
        }
    });

    fileRadio.addEventListener('change', e => {
        if(e.target.checked){
            file.disabled = false;
            input.disabled = true;
        } else {
            file.disabled = true;
            input.disabled = false;
        }
    });
});

