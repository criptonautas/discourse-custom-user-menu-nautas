# Custom User Menu (Nautas)

**ENGLISH** | [ESPAÑOL](README.es.md)

Maintained by Criptonautas. Not affiliated with or endorsed by Discourse (Civilized Discourse Construction Kit, Inc.).

Theme component that adds a dropdown menu to the header avatar, giving users quick access to personal settings and pages. Fork of [manuelkostka/custom-user-menu](https://gitlab.com/manuelkostka/discourse/components/custom-user-menu) by Manuel Kostka.

## What the fork adds

Under the @username, the member's primary group (hidden when they have none) and their monthly karma from [discourse-gamification](https://github.com/discourse/discourse-gamification) (hidden when the plugin is not installed).

One plugin outlet between the user info and the profile links:

| Outlet | `@outletArgs` |
|---|---|
| `custom-user-menu-after-user-info` | `closeMenu`: closes the menu (call it when a link inside your connector is followed) |

Other components render into it with a connector at `javascripts/discourse/connectors/custom-user-menu-after-user-info/<name>.gjs`. Without this fork installed the connector simply never renders. The change is kept small so it can go upstream.

## Install

Admin → Customize → Themes → Components → Install → From a git repository, with this repo's URL. Then add the component to the themes that should use it. It replaces the upstream Custom User Menu: don't install both.

## Styling

```scss
// Button
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

## License

MIT (upstream: Manuel Kostka). Modifications © 2026 Criptonautas. See [LICENSE](LICENSE).

Text of this README under [CC BY-NC-SA 4.0](CC-BY-NC-SA-4.0.txt).
