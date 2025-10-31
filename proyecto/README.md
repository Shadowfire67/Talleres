## Módulo: Consumo de API pública con http + go_router

Este módulo implementa un listado y detalle de recetas usando TheMealDB.

- API: https://www.themealdb.com/api.php
- Endpoints usados:
	- Búsqueda por nombre: `/api/json/v1/1/search.php?s=<query>`
	- Detalle por id: `/api/json/v1/1/lookup.php?i=<id>`

Ejemplo de respuesta JSON (search):

```
{
	"meals": [
		{
			"idMeal": "52772",
			"strMeal": "Teriyaki Chicken Casserole",
			"strCategory": "Chicken",
			"strArea": "Japanese",
			"strInstructions": "...",
			"strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"
		}
	]
}
```

### Arquitectura de carpetas

- `lib/models/meal.dart`: modelo de dominio con `fromJson`.
- `lib/services/meal_service.dart`: capa de servicio HTTP con manejo de errores (statusCode, excepciones).
- `lib/views/meal_list_page.dart`: pantalla de listado con estados (cargando/éxito/error) y `ListView.builder`.
- `lib/views/meal_detail_page.dart`: pantalla de detalle con información ampliada e imagen.
- `lib/config/app_router.dart`: configuración de rutas con `go_router` y rutas con nombre.

### Rutas (go_router)

- `name: mealList`, path: `/` → Listado.
- `name: mealDetail`, path: `/meal/:id` → Detalle.
	- Parámetros: `id` (path), y opcional `extra` (instancia de `Meal`).

### Estado y manejo de errores

- Se utilizan `FutureBuilder` y banderas locales para estados.
- `try/catch` con verificación de `statusCode` y `SnackBar` ante errores de red.

### Requisitos de ejecución

Dependencias principales:

- `http`
- `go_router`

### Evidencias (añadir en PDF)

- Capturas de Listado con elementos y fotos.
- Capturas de Detalle recibiendo parámetros.
- Capturas de consola mostrando estados y manejo de errores.
- En la primera página del PDF incluir URL del repositorio.

### GitFlow utilizado

1. Rama base: `dev`.
2. Nueva rama de feature: `feature/taller_http`.
3. Pull Request: `feature/taller_http` → `dev`.
4. Tras revisión, merge a `dev` y luego integrar cambios a `main`.




