/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
        let label = document.querySelectorAll('label').
        forEach(label => {
            label.innerHTML = label.innerText.split('').map((letters, i) => `<span style="transition-delay: ${i*50}ms">${letters}</span>`).join('');
        });
        
    function enviarDadosRegistro(event) {
        event.preventDefault(); // Impede o envio padrão do formulário

        // Coleta dos dados do formulário
        const nome = document.getElementById('nome').value;
        const usuario = document.getElementById('usuario').value;
        const senha = document.getElementById('senha').value;

        // Configura a requisição AJAX
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "registroSubmit.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // Exibir o SweetAlert com a resposta do servidor
                Swal.fire({
                    title: 'Cadastro',
                    text: xhr.responseText,
                    icon: 'success', // ou 'error' dependendo da resposta
                    confirmButtonText: 'OK'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Redireciona para a página de login após o OK
                        window.location.href = "index.jsp";
                    }
                });
            }
        };

        // Envio dos dados
        xhr.send(`nome=${encodeURIComponent(nome)}&usuario=${encodeURIComponent(usuario)}&senha=${encodeURIComponent(senha)}`);
    }
    
    function enviarLogin(event) {
    event.preventDefault(); // Impede o envio padrão do formulário

    // Coleta dos dados do formulário
    const usuario = document.getElementById('usuario').value;
    const senha = document.getElementById('senha').value;

    // Configura a requisição AJAX
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "loginSubmit.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const resposta = xhr.responseText.trim();  // Obtém e remove espaços em branco

            if (resposta === "success") {
                // Redireciona para quadro.jsp se o login for bem-sucedido
                window.location.href = "quadro.jsp";
            } else if (resposta === "fail") {
                // Exibe SweetAlert para login inválido
                Swal.fire({
                    title: 'Erro',
                    text: 'Usuário ou senha inválidos.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            } else {
                // Exibe SweetAlert para erro geral
                Swal.fire({
                    title: 'Erro',
                    text: 'Ocorreu um erro. Tente novamente mais tarde.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            }
        }
    };

    // Envio dos dados
    xhr.send(`usuario=${encodeURIComponent(usuario)}&senha=${encodeURIComponent(senha)}`);
}

    