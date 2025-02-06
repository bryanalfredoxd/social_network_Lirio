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

                // Si la acción es agregar "Me gusta"
                if (data.action === 'added') {
                    likeCountElem.textContent = currentCount + 1;
                    buttonElem.classList.add('liked');
                    likeTextElem.textContent = ''; // Elimina el texto
                } 
                // Si la acción es quitar "Me gusta"
                else if (data.action === 'removed') {
                    likeCountElem.textContent = currentCount - 1;
                    buttonElem.classList.remove('liked');
                    likeTextElem.textContent = ''; // Elimina el texto
                }

                // Aquí puedes evitar la recarga y manejar solo el cambio en los "likes"
                // Evita que las imágenes se dupliquen al no renderizar nuevamente toda la página
                // Solo actualiza el botón de "like" y su estado
            } else {
                alert('Error: ' + (data.error || 'No se pudo procesar la solicitud.'));
            }
        })
        .catch(error => console.error('Error:', error));
    });
});
