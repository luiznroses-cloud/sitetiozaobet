<!-- Spinner de carregamento -->
<div id="loadingSpinner"
    style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1051; background-color: rgb(39 42 39); width: 100%; height: 100%; display: flex; justify-content: center; align-items: center; flex-direction: column;">
   <!--- <div class="spinner-grow text-primary" role="status">
        <span class="sr-only">Loading...</span>
    </div> --->
    <!-- <p style="margin-top: 15px; font-size: 18px; font-weight: 500; text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);">
        Carregando...
    </p> -->
</div>

<style>
    ::-webkit-scrollbar {
    width: 4px;
}

::-webkit-scrollbar-track {
    background-color: transparent;
    border-radius: 1.5px;
}

::-webkit-scrollbar-thumb {
    background-color: transparent;
    border-radius: 20px;
}
</style>

<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
<link href="assets/css/app.min.css" rel="stylesheet" type="text/css" />

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var spinner = document.getElementById("loadingSpinner");

        window.onload = function () {
            setTimeout(function () {
                spinner.style.display = 'none';
            }, 500);
        };
    });
</script>

<style>
        #particles-js {
        position: fixed;
        width: 100%;
        height: 100%;
        z-index: -1;
        top: 0;
        left: 0;
        opacity: 0.2;
    }
</style>

<div id="particles-js"></div>

<!-- Cache-buster global removido para evitar recarregamentos periódicos em telas de autenticação -->