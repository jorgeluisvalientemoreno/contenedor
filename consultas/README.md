 Pasos a Reproducir 📢
-------------
1. Asegúrate de que estés en **Master**.
2. Asegúrate de que el master esté actualizado con el siguiente comando:
`git pull`
3. Crear una nueva rama con el siguiente comando y estructura:
`git checkout -b OSF-XXX`
4. Crear la consulta base.
5. Si se requieren personalizaciones, se debe crear una carpeta con el nombre del caso dentro de la carpeta en donce se encuentre cada consulta involucrada.
6. Guardar los cambios realizados con `Ctrl + S`
7. Para subir los cambios al repositorio ejecuta los siguientes comandos:
- `git add copy relative path`
- `git commit -m "XXXX"`
- `git push origin OSF-XXX`

8. Una vez se tenga todas las consultas base y demás modificaciones realizadas en dicha rama, se puede hacer el merge con Master.

A Tener en Cuenta 📢
-------------
1. Todo tiene que estar en minúsculas (a excepción de cuando se crea la carpeta con el nombre de los casos, ej: OSF-XXX).
2. Todo sin espacios (los espacios se reemplazar por _).
3. Al nombre de la consulta colocarle .sql.
4. Las consultas genéricas se crean en la carpeta del proceso correspondiente.
5. Las consultas específicas deben quedar dentro de carpetas  con el nombre de la rama en la carpeta del proceso correspondiente.

