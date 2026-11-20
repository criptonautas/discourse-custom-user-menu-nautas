import Component from "@glimmer/component";
import { fn } from "@ember/helper";
import { on } from "@ember/modifier";
import { service } from "@ember/service";
import UserStatusBubble from "discourse/components/header/user-dropdown/user-status-bubble";
import PluginOutlet from "discourse/components/plugin-outlet";
import UserMenuProfileTabContent from "discourse/components/user-menu/profile-tab-content";
import DMenu from "discourse/float-kit/components/d-menu";
import lazyHash from "discourse/helpers/lazy-hash";
import dBoundAvatarTemplate from "discourse/ui-kit/helpers/d-bound-avatar-template";

function closeOnLinkClick(close, event) {
  if (event.target.closest("a[href]")) {
    close();
  }
}

export default class CustomUserMenu extends Component {
  @service currentUser;

  <template>
    <li class="header-dropdown-toggle custom-user-menu">
      <DMenu
        @placement="bottom-end"
        @offset="0"
        {{!-- @modalForMobile={{true}} --}}
        @identifier="custom-user-menu"
        @triggerClass="icon btn-flat"
        @groupIdentifier="custom-header"
      >
        <:trigger>
          {{dBoundAvatarTemplate this.currentUser.avatar_template "medium"}}
        </:trigger>

        <:content as |args|>

          <div class="fk-d-menu__user-info">
            {{dBoundAvatarTemplate this.currentUser.avatar_template "medium"}}
            {{#if this.currentUser.name}}
              <span class="name">{{this.currentUser.name}}</span>
            {{/if}}
            <span class="username">{{this.currentUser.username}}</span>
            <div class="fk-d-menu__user-info-extra">
              <PluginOutlet
                @name="custom-user-menu-after-username"
                @outletArgs={{lazyHash
                  user=this.currentUser
                  closeMenu=args.close
                }}
              />
            </div>
          </div>

          <PluginOutlet
            @name="custom-user-menu-after-user-info"
            @outletArgs={{lazyHash closeMenu=args.close}}
          />

          {{! Delegate clicks from the nested links, including keyboard activation. }}
          {{! eslint-disable-next-line ember/template-no-invalid-interactive }}
          <div
            {{on "click" (fn closeOnLinkClick args.close)}}
            class="fk-d-menu__profile-tab"
          >
            <UserMenuProfileTabContent @closeUserMenu={{args.close}} />
          </div>

        </:content>
      </DMenu>
      {{#if this.currentUser.status}}
        <UserStatusBubble
          @timezone={{this.currentUser.user_option.timezone}}
          @status={{this.currentUser.status}}
        />
      {{/if}}
    </li>
  </template>
}
