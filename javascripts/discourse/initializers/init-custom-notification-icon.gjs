import { apiInitializer } from "discourse/lib/api";
import dIcon from "discourse/ui-kit/helpers/d-icon";

export default apiInitializer((api) => {
  api.renderInOutlet(
    "user-dropdown-notifications__before",
    <template>{{dIcon "bell"}}</template>
  );
});
