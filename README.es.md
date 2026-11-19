# Custom User Menu (Nautas)

[ENGLISH](README.md) | **ESPAÑOL**

Mantenido por Criptonautas. Sin afiliación ni respaldo de Discourse (Civilized Discourse Construction Kit, Inc.).

Componente de tema que añade un menú desplegable al avatar de la cabecera, con acceso rápido a los ajustes y páginas personales. Fork de [manuelkostka/custom-user-menu](https://gitlab.com/manuelkostka/discourse/components/custom-user-menu), de Manuel Kostka.

## Qué añade el fork

Bajo el @usuario, el grupo principal del miembro (oculto si no tiene) y su karma mensual de [discourse-gamification](https://github.com/discourse/discourse-gamification) (oculto si el plugin no está instalado).

Un punto de inserción (plugin outlet) entre los datos del usuario y los enlaces del perfil:

| Outlet | `@outletArgs` |
|---|---|
| `custom-user-menu-after-user-info` | `closeMenu`: cierra el menú (llámalo cuando se siga un enlace dentro de tu conector) |

Otros componentes se insertan con un conector en `javascripts/discourse/connectors/custom-user-menu-after-user-info/<nombre>.gjs`. Sin este fork instalado el conector simplemente no se muestra. El cambio es pequeño para poder proponerlo upstream.

## Instalación

Admin → Personalizar → Temas → Componentes → Instalar → Desde un repositorio git, con la URL de este repo. Luego añade el componente a los temas que deban usarlo. Sustituye al Custom User Menu original: no instales los dos.

## Estilos

```scss
// Botón
.header-dropdown-toggle.custom-user-menu {
}

// Panel
.custom-user-menu-content {
  .fk-d-menu {
    &__inner-content {
    }
    &__user-info {
    }
    &__profile-tab {
    }
  }
}
```

## Licencia

MIT (upstream: Manuel Kostka). Modificaciones © 2026 Criptonautas. Consulta [LICENSE](LICENSE).

Texto de este README bajo [CC BY-NC-SA 4.0](CC-BY-NC-SA-4.0.txt).
