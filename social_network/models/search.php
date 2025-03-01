<div class="container d-flex justify-content-center align-items-center min-vh-200">
  <div class="card p-4 w-100" style="max-width: 1000px;">
    <div class="form-group">
      <input type="text" class="form-control form-control-lg" placeholder="Buscar..." id="searchInput">
    </div>
    <div class="filter-buttons">
      <button id="filterProjects" class="btn btn-outline-primary active" data-filter="projects">
        <i class="bi bi-journal-text"></i> Proyectos
      </button>
      <button id="filterCategories" class="btn btn-outline-primary" data-filter="categories">
        <i class="bi bi-tags"></i> Categorias
      </button>
      <button id="filterUsers" class="btn btn-outline-primary" data-filter="users">
        <i class="bi bi-person"></i> Usuarios
      </button>
      <button id="filterRetweets" class="btn btn-outline-primary" data-filter="retweets">
        <i class="bi bi-reply-all"></i> Retweets
      </button>
      <button id="filterValuated" class="btn btn-outline-primary" data-filter="valuated">
        <i class="bi bi-heart"></i> Valorado
      </button>
    </div>
    <br>
    <div id="resultados"></div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
  const searchInput = document.getElementById('searchInput');
  const filterButtons = document.querySelectorAll('.filter-buttons button');
  const resultados = document.getElementById('resultados');

  async function fetchProyectos(searchText) {
  try {
    const response = await fetch(`../controllers/buscar_proyectos.php?query=${encodeURIComponent(searchText)}`);
    const proyectos = await response.json();

    resultados.innerHTML = proyectos
      .map(proyecto => `
        <div class="proyectos-card card mb-3" onclick="verDetalles(${proyecto.post_id})">
          <div class="card-body">
            <h5 class="card-title">${proyecto.titulo}</h5>
            <p class="card-text">${proyecto.descripcion}</p>
          </div>
        </div>
      `)
      .join('') || '<p>No hay resultados.</p>';
  } catch (error) {
    console.error("Error al buscar proyectos:", error);
    resultados.innerHTML = '<p>Error al cargar los resultados.</p>';
  }
}

// Función que redirige a la página de detalles del proyecto
function verDetalles(postId) {
  window.location.href = `../controllers/publicacion_detalle.php?post_id=${postId}`;
}



  // Manejar eventos de búsqueda
  searchInput.addEventListener('input', () => {
    const activeFilter = document.querySelector('.filter-buttons .btn.active').dataset.filter;
    if (activeFilter === 'projects') {
      fetchProyectos(searchInput.value);
    }
  });

  // Manejar los botones de filtro
  filterButtons.forEach(button => {
    button.addEventListener('click', () => {
      filterButtons.forEach(btn => btn.classList.remove('active'));
      button.classList.add('active');

      if (button.dataset.filter === 'projects') {
        fetchProyectos(searchInput.value);
      } else {
        resultados.innerHTML = '<p></p>';
      }
    });
  });

  // Cargar proyectos predeterminados al inicio
  fetchProyectos('');
</script>

<script>
  // Función para obtener resultados de categorías desde el servidor
  async function fetchCategorias(searchText) {
    try {
      const response = await fetch(`../controllers/buscar_categorias.php?query=${encodeURIComponent(searchText)}`);
      const categorias = await response.json();

      resultados.innerHTML = categorias
        .map(categoria => `
          <div class="categorias-card card mb-3" onclick="verDetallesCategoria(${categoria.id})">
            <div class="card-body">
              <h5 class="card-title">${categoria.nombre}</h5>
            </div>
          </div>
        `)
        .join('') || '<p>No hay resultados.</p>';
    } catch (error) {
      console.error("Error al buscar categorías:", error);
      resultados.innerHTML = '<p>Error al cargar los resultados.</p>';
    }
  }

  // Función que redirige a la página de detalles de la categoría
  function verDetallesCategoria(categoriaId) {
    window.location.href = `../controllers/resultados_categorias.php?categoria_id=${categoriaId}`;
  }

  // Escuchar eventos del buscador para el filtro "categorías"
  searchInput.addEventListener('input', () => {
    const activeFilter = document.querySelector('.filter-buttons .btn.active').dataset.filter;
    if (activeFilter === 'categories') {
      fetchCategorias(searchInput.value);
    }
  });

  filterButtons.forEach(button => {
    button.addEventListener('click', () => {
      filterButtons.forEach(btn => btn.classList.remove('active'));
      button.classList.add('active');

      if (button.dataset.filter === 'categories') {
        fetchCategorias(searchInput.value);
      } else {
        resultados.innerHTML = '<p></p>';
      }
    });
  });
</script>

<script>
  // Función para obtener resultados de usuarios desde el servidor
  async function fetchUsuarios(searchText) {
    try {
      const response = await fetch(`../controllers/buscar_usuarios.php?query=${encodeURIComponent(searchText)}`);
      const usuarios = await response.json();

      resultados.innerHTML = usuarios
        .map(usuario => `
          <div class="usuario-card card mb-3" onclick="verDetallesUsuario(${usuario.id})">
            <div class="card-body d-flex align-items-center">
              <img src="${usuario.foto_perfil || 'https://via.placeholder.com/80'}" 
                   alt="Foto de ${usuario.nombre}" 
                   class="img-thumbnail rounded-circle me-3"
                   style="width: 80px; height: 80px;">
              <div>
                <h5 class="card-title">${usuario.nombre} ${usuario.apellido}</h5>
                <p class="card-text">${usuario.email || 'Sin correo disponible'}</p>
              </div>
            </div>
          </div>
        `)
        .join('') || '<p>No hay resultados.</p>';
    } catch (error) {
      console.error("Error al buscar usuarios:", error);
      resultados.innerHTML = '<p>Error al cargar los resultados.</p>';
    }
  }

  // Función que redirige a la página de detalles del usuario
  function verDetallesUsuario(usuarioId) {
    window.location.href = `./usuarios_perfil.php?usuario_id=${usuarioId}`;
  }

  // Escuchar eventos del buscador para el filtro "usuarios"
  searchInput.addEventListener('input', () => {
    const activeFilter = document.querySelector('.filter-buttons .btn.active').dataset.filter;
    if (activeFilter === 'users') {
      fetchUsuarios(searchInput.value);
    }
  });

  filterButtons.forEach(button => {
    button.addEventListener('click', () => {
      filterButtons.forEach(btn => btn.classList.remove('active'));
      button.classList.add('active');

      if (button.dataset.filter === 'users') {
        fetchUsuarios(searchInput.value);
      } else {
        resultados.innerHTML = '<p></p>';
      }
    });
  });
</script>

<script>
  // Función para obtener los resultados de retweets desde el servidor
async function fetchRetweets(searchText) {
  try {
    const response = await fetch(`../controllers/buscar_retweets.php?query=${encodeURIComponent(searchText)}`);
    const proyectos = await response.json();

    resultados.innerHTML = proyectos
      .map(proyecto => `
         <div class="proyecto-card card mb-3" onclick="verDetallesRetweets(${proyecto.id}, ${proyecto.post_id})">
            <div class="card-body">
              <h5>${proyecto.titulo}</h5>
              <p class="card-text">${proyecto.descripcion}</p>
              <small>Me gusta: ${proyecto.retweet_count}</small>
            </div>
          </div>
        `)
      .join('') || '<p>No hay proyectos con retweets.</p>';
  } catch (error) {
    console.error("Error al buscar retweets:", error);
    resultados.innerHTML = '<p>Error al cargar los resultados.</p>';
  }
}

// Función que redirige a la página de detalles del proyecto retweets
function verDetallesRetweets(proyectoId, postId) {
  console.log("Proyecto ID:", proyectoId); // Muestra el proyectoId
  console.log("Post ID:", postId);         // Muestra el postId
  window.location.href = `../controllers/publicacion_detalle.php?proyecto_id=${proyectoId}&post_id=${postId}`;
}

  // Escuchar eventos del buscador para el filtro "retweets"
  searchInput.addEventListener('input', () => {
    const activeFilter = document.querySelector('.filter-buttons .btn.active').dataset.filter;
    if (activeFilter === 'retweets') {
      fetchRetweets(searchInput.value);
    }
  });

  filterButtons.forEach(button => {
    button.addEventListener('click', () => {
      filterButtons.forEach(btn => btn.classList.remove('active'));
      button.classList.add('active');

      if (button.dataset.filter === 'retweets') {
        fetchRetweets(searchInput.value);
      } else {
        resultados.innerHTML = '<p></p>';
      }
    });
  });
</script>

<script>
// Función para obtener los resultados de proyectos valorados desde el servidor
async function fetchValorados(searchText) {
  try {
    const response = await fetch(`../controllers/buscar_valorados.php?query=${encodeURIComponent(searchText)}`);
    const Valorado = await response.json();

    resultados.innerHTML = Valorado
      .map(proyecto => `
          <div class="proyecto-card card mb-3" onclick="verDetallesValorado(${proyecto.id}, ${proyecto.post_id})">
            <div class="card-body">
              <h5>${proyecto.titulo}</h5>
              <p class="card-text">${proyecto.descripcion}</p>
              <small>Me gusta: ${proyecto.like_count}</small>
            </div>
          </div>
        `)
      .join('') || '<p>No hay proyectos valorados.</p>';
  } catch (error) {
    console.error("Error al buscar valorados:", error);
    resultados.innerHTML = '<p>Error al cargar los resultados.</p>';
  }
}

// Función que redirige a la página de detalles del proyecto valorado
function verDetallesValorado(proyectoId, postId) {
  console.log("Proyecto ID:", proyectoId); // Muestra el proyectoId
  console.log("Post ID:", postId);         // Muestra el postId
  window.location.href = `../controllers/publicacion_detalle.php?proyecto_id=${proyectoId}&post_id=${postId}`;
}


// Escuchar eventos del buscador para el filtro "valorados"
searchInput.addEventListener('input', () => {
  const activeFilter = document.querySelector('.filter-buttons .btn.active').dataset.filter;
  if (activeFilter === 'valuated') {
    fetchValorados(searchInput.value);
  }
});

filterButtons.forEach(button => {
  button.addEventListener('click', () => {
    filterButtons.forEach(btn => btn.classList.remove('active'));
    button.classList.add('active');

    if (button.dataset.filter === 'valuated') {
      fetchValorados(searchInput.value);
    } else {
      resultados.innerHTML = '<p></p>';
    }
  });
});
</script>