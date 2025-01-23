// Función de JavaScript para manejar "Me gusta"
document.querySelectorAll('.like-btn').forEach(button => {
    button.addEventListener('click', function() {
        const postId = this.getAttribute('data-post-id');
        const userId = this.getAttribute('data-user-id');
        const likeCountElem = this.querySelector('.like-count');
        const likeTextElem = this.querySelector('.like-text');
        const buttonElem = this;

        // Realizar la solicitud AJAX para manejar "Me gusta"
        fetch('../controllers/like_action.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `post_id=${postId}&user_id=${userId}`
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                let currentCount = parseInt(likeCountElem.textContent);

                if (data.action === 'added') {
                    likeCountElem.textContent = currentCount + 1;
                    buttonElem.classList.add('liked');
                    likeTextElem.textContent = ''; // Texto para el botón
                } else if (data.action === 'removed') {
                    likeCountElem.textContent = currentCount - 1;
                    buttonElem.classList.remove('liked');
                    likeTextElem.textContent = ''; // Elimina el texto
                }
            } else {
                alert('Error: ' + (data.error || 'No se pudo procesar la solicitud.'));
            }
        })
        .catch(error => console.error('Error:', error));
    });
});
