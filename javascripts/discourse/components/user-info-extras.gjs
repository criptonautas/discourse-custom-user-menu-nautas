import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { service } from "@ember/service";
import { themePrefix } from "virtual:theme";
import { ajax } from "discourse/lib/ajax";
import { i18n } from "discourse-i18n";

// One successful request each per page load: the menu gets opened over and over.
// A failure clears the cache so the next open retries.
let groupRequest;
let karmaRequest;

function primaryGroup(username) {
  groupRequest ||= ajax(`/u/${username}/card.json`)
    .then((json) => json?.user?.primary_group_name || null)
    .catch(() => {
      groupRequest = null;
      return null;
    });
  return groupRequest;
}

// Needs discourse-gamification. A leaderboard with an empty `personal` means no
// points yet this month (0); anything without `users`, or a 404 when the plugin
// is absent, hides the row.
function monthlyKarma() {
  karmaRequest ||= ajax("/leaderboard", { data: { period: "monthly" } })
    .then((json) =>
      json?.users ? (json.personal?.user?.total_score ?? 0) : null
    )
    .catch(() => {
      karmaRequest = null;
      return null;
    });
  return karmaRequest;
}

// Primary group and monthly karma, rendered as rows of the user-info grid.
// Each row stays hidden until its data arrives, and for good when there is none.
export default class UserInfoExtras extends Component {
  @service currentUser;

  @tracked group = null;
  @tracked karma = null;

  constructor() {
    super(...arguments);
    // The menu may close before a request returns.
    primaryGroup(this.currentUser.username).then((g) => {
      if (!this.isDestroying) {
        this.group = g;
      }
    });
    monthlyKarma().then((k) => {
      if (!this.isDestroying) {
        this.karma = k?.toLocaleString() ?? null;
      }
    });
  }

  <template>
    {{#if this.group}}
      <span class="primary-group">{{this.group}}</span>
    {{/if}}
    {{#if this.karma}}
      <span class="monthly-karma">
        <strong>{{i18n (themePrefix "monthly_karma")}}</strong>
        <span>{{this.karma}}</span>
      </span>
    {{/if}}
  </template>
}
