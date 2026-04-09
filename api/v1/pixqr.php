<!DOCTYPE html>
<html lang="en" style="font-size: 60px;">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <title>Pix QR</title>
  <link rel="icon" href="Pix%20QR_arquivos/logo.png">

  <link href="Pix%20QR_arquivos/default.css" rel="stylesheet">
  <link href="Pix%20QR_arquivos/toastr.css" rel="stylesheet">

  <script type="text/javascript" src="Pix%20QR_arquivos/jquery.min.js"></script>
  <script type="text/javascript" src="Pix%20QR_arquivos/qrcode.min.js"></script>
  <script type="text/javascript" src="Pix%20QR_arquivos/toastr.js"></script>
  <script type="text/javascript" src="Pix%20QR_arquivos/adapter-view.js"></script>
  <script type="text/javascript" src="Pix%20QR_arquivos/common.js"></script>
</head>

<body>
<div class="container">
  <div class="top">
    <div class="logo">
      
    </div>
    <div class="trade">
      <div class="qrcode-tips">
        <p class="tips">Abra seu banco e pague escaneando o</p>
        <p class="tips weight">código QR ou copiando e colando</p>
      </div>
      <div class="qrcode-wrap">
        <div id="qrcode" class="qrcode-box" title="">
          <canvas width="256" height="256" style="display: none;"></canvas>
          <img id="qrcode-image" style="display: block;" src="">
        </div>
      </div>
    </div>
  </div>

  <div id="bottom" class="bottom">
    <div class="line-split"></div>
    <p>Valor do Pix: R$ <span id="pix-value"></span></p>

    <input type="text" id="copy" class="button" value="">
    <br>
    <br>
    <input type="button" id="copy-button" class="button clickable" value="COPIAR CÓDIGO PIX">

    <div class="desc">
      Abra o app com sua chave cadastrada, escolha pagar com PIX e escaneie o QR Code e cole o código
    </div>

    <div class="desc">
      Este código QR só pode ser pago uma vez, se você precisar pagar novamente, solicite novamente esse código
    </div>

    <div class="background">
      <svg preserveAspectRatio="none" viewBox="0 0 257 227" fill="none" xmlns="http://www.w3.org/2000/svg" class="_icon5_c7hnz_309">
        <g opacity="0.3">
          <path d="M97.6862 192.899C93.9183 189.683 91.4369 185.915 88.9556 182.055C85.0958 176.265 81.4198 170.384 78.6628 163.951C73.3325 151.268 69.9322 138.218 68.7375 124.433C67.5428 110.097 68.1861 96.0361 72.4135 82.251C76.8248 67.8226 84.1768 55.0485 93.6426 43.3771C106.601 27.2026 123.235 15.9908 142.166 8.54681C166.152 -0.918939 190.873 -2.94075 215.87 4.59509C228.093 8.27111 238.937 14.6123 247.392 24.5375C259.799 39.1497 259.707 57.0703 248.495 72.142C239.121 84.7323 225.979 89.4193 210.908 90.5221C199.88 91.3492 189.219 88.776 178.651 86.5703C164.774 83.6295 150.805 83.17 137.295 87.7651C125.073 91.9925 114.136 98.5174 105.59 108.626C88.3123 129.212 86.0148 152.463 92.9993 177.368C94.3778 182.239 96.2158 186.926 97.7781 191.613C97.87 191.888 97.7781 192.164 97.6862 192.899Z" fill="white"></path>
          <path d="M64.6939 102.377C60.926 98.4255 58.9042 93.4629 56.239 88.9598C50.9088 79.7697 42.9135 73.7962 33.4477 69.385C26.4633 66.1684 19.295 63.4114 12.7701 59.2759C-0.00407314 51.2806 -3.9558 33.5438 4.40715 21.5967C9.27788 14.7042 16.4461 12.4985 24.2577 11.6714C30.8745 10.9362 37.3075 11.5795 43.6487 13.4176C48.887 14.888 52.9306 17.8288 56.8823 21.5048C69.6565 33.4519 70.6674 48.8912 69.2889 64.698C68.1861 76.737 65.6129 88.5922 65.6129 100.723C65.6129 101.274 65.6129 101.918 64.6939 102.377Z" fill="white"></path>
          <path d="M181.316 225.983C180.489 226.075 179.753 226.259 178.926 226.351C176.629 225.708 174.331 226.443 172.126 226.167C167.806 225.708 163.579 225.064 159.26 225.616C131.781 220.837 108.714 209.533 97.7781 181.871C88.68 158.896 93.0912 136.932 104.119 115.887C101.454 124.893 100.259 134.267 100.076 143.641C99.8918 156.139 102.465 168.086 110.277 178.195C120.661 191.705 134.998 197.77 151.724 198.597C154.665 198.689 157.422 197.862 160.087 196.943C165.693 195.105 170.288 196.759 173.872 201.17C176.077 203.927 178.559 206.133 181.683 207.695C186.186 209.901 190.414 209.809 194.457 206.317C197.123 204.019 199.971 201.722 203.923 202.181C206.588 202.457 208.886 203.468 209.897 206.133C210.908 208.798 209.989 211.004 208.151 213.025C201.35 220.286 192.895 223.962 183.246 225.616C182.602 225.432 181.867 225.34 181.316 225.983Z" fill="white"></path>
          <path d="M158.708 225.432C163.027 224.789 170.104 224.447 174.331 224.907C176.629 225.09 177.18 225.642 179.386 226.377C172.769 227.48 164.222 226.811 158.708 225.432Z" fill="white"></path>
          <path d="M180.305 225.892C180.948 225.248 182.786 225.064 183.521 225.432C182.878 225.891 181.04 226.167 180.305 225.892Z" fill="white"></path>
        </g>
      </svg>
    </div>
  </div>
</div>

<script>
  // Função para obter parâmetros da URL
  function getUrlParameter(name) {
      name = name.replace(/[\[\]]/g, "\\$&");
      var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
          results = regex.exec(window.location.href);
      if (!results) return null;
      if (!results[2]) return '';
      return decodeURIComponent(results[2].replace(/\+/g, " "));
  }

  // Obtém o valor do parâmetro paymentCodeBase64 da URL
  var paymentCodeBase64 = getUrlParameter('paymentCodeBase64');

  // Atualiza o atributo src da imagem com o valor do parâmetro paymentCodeBase64
  if (paymentCodeBase64) {
      // Remove espaços em branco da string paymentCodeBase64
      paymentCodeBase64 = paymentCodeBase64.replace(/\s+/g, '');
      document.getElementById('qrcode-image').src = 'data:image/png;base64,' + paymentCodeBase64;
  }

  // Obtém o valor do parâmetro paymentCode da URL
  var paymentCode = getUrlParameter('paymentCode');

  // Atualiza o título do elemento div com o valor do parâmetro paymentCode
  if (paymentCode) {
      document.getElementById('qrcode').setAttribute('title', paymentCode);
      // Define o valor do input com o ID "copy"
      document.getElementById('copy').value = paymentCode;
  }

  // Obtém o valor do parâmetro amount da URL
  var amount = getUrlParameter('valorPix');

  // Atualiza o elemento span com o valor do parâmetro amount
  if (amount) {
      document.getElementById('pix-value').textContent = amount;
  }

  // Função para copiar o código de pagamento ao clicar no botão
  function copyToClipboard(text, message) {
      navigator.clipboard.writeText(text).then(function() {
          alert(message);
      }, function(err) {
          console.error('Erro ao copiar: ', err);
      });
  }

  document.getElementById('copy-button').addEventListener('click', function() {
      copyToClipboard(paymentCode, 'ID de transação copiado');
  });

  console.log('paymentCodeBase64:', paymentCodeBase64);
</script>
</body>
</html>
