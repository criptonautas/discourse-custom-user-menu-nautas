import Component from "@glimmer/component";
import { on } from "@ember/modifier";
import { service } from "@ember/service";
import UserMenuProfileTabContent from "discourse/components/user-menu/profile-tab-content";
import avatar from "discourse/helpers/bound-avatar-template";
import DMenu from "float-kit/components/d-menu";

export default class CustomUserMenu extends Component {
  @service currentUser;

  <template>
    <li class="header-dropdown-toggle custom-user-menu">
      <DMenu
        @placement="bottom-end"
        {{!-- @modalForMobile={{true}} --}}
        @identifier="custom-user-menu"
        @triggerClass="icon btn-flat"
        @groupIdentifier="custom-header"
      >
        <:trigger>
          {{avatar this.currentUser.avatar_template "medium"}}
        </:trigger>

        <:content as |args|>

          <div class="fk-d-menu__user-info">
            {{avatar this.currentUser.avatar_template "medium"}}
            {{#if this.currentUser.name}}
              <span class="name">{{this.currentUser.name}}</span>
            {{/if}}
            <span class="username">{{this.currentUser.username}}</span>
          </div>

          <div {{on "click" args.close}} class="fk-d-menu__profile-tab">
            <UserMenuProfileTabContent @closeUserMenu={{args.close}} />
          </div>

        </:content>
      </DMenu>
    </li>
  </template>
}
