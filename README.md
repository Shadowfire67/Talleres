# Taller 2 – Navegación, Widgets y Ciclo de Vida

Este taller implementa una aplicación en Flutter que utiliza navegación con go_router, paso de parámetros entre pantallas, uso de widgets intermedios y evidencia del ciclo de vida de un StatefulWidget.

## Arquitectura y navegación

La aplicación se basa en rutas gestionadas con go_router:

/ → Pantalla principal (HomePage)

Contiene un GridView y una TabBar para organizar contenido.

Incluye un Drawer como tercer widget adicional.

/detail/:name → Pantalla de detalle (DetailPage)

Recibe parámetros desde la URL (:name).

Muestra el valor recibido en pantalla.

Tipos de navegación demostrados:

go('/detail/valor') → reemplaza toda la navegación (no se puede volver atrás).

push('/detail/valor') → apila la ruta (se puede volver con el botón “atrás”).

replace('/detail/valor') → reemplaza solo la ruta actual.

## Widgets usados y justificación

GridView → permite mostrar una lista de elementos en forma de cuadrícula.

TabBar + TabBarView → organiza el contenido en pestañas, separando la sección de la cuadrícula y la de navegación.

Drawer → implementa un menú lateral como widget adicional.

La combinación de estos widgets permite practicar la construcción de interfaces más estructuradas y con navegación fluida.

## Ciclo de vida de StatefulWidget

En la pantalla de detalle (DetailPage) se evidencian los siguientes métodos con print() en consola y comentarios en el código:

initState()

didChangeDependencies()

build()

setState()

dispose()

Esto permite observar cuándo y por qué se ejecuta cada método del ciclo de vida.

---

## Pasos para ejecutar el proyecto

Clonar el repositorio

git clone https://github.com/Shadowfire67/Talleres.git
cd Talleres


Obtener las dependencias

flutter pub get


Conectar un emulador o dispositivo físico

Abre Android Studio / Visual Studio Code y levanta un emulador.

O conecta tu celular con depuración USB habilitada.

Ejecutar la app

flutter run
