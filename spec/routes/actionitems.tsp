import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace RetroSpec;

@resource("actionitems")
model ActionItem {
  @key("actionitemId") @visibility("read") id: Id;
  task: string;
  completed?: boolean = false;
  assignee?: string;
}

@tag("Action Items")
@autoRoute
interface ActionItems {
  @listsResource(ActionItem)
  @summary("List all action items belonging to the specified team")
  list(...Parameters.Team): ActionItem[] | UnauthorizedResponse | NotFoundResponse;

  @createsResource(ActionItem)
  @summary("Create a new action item belonging to the specified team")
  create(...Parameters.Team, @body actionItem: ActionItem): ActionItem | UnauthorizedResponse | NotFoundResponse;

  @readsResource(ActionItem)
  @summary("Retrieve a single action item belonging to the specified team")
  read(...Parameters.TeamActionitem): ActionItem | UnauthorizedResponse | NotFoundResponse;

  @updatesResource(ActionItem)
  @summary("Update a single action item belonging to the specified team")
  update(...Parameters.TeamActionitem, @body actionItem: ActionItem): ActionItem | UnauthorizedResponse | NotFoundResponse;

  @deletesResource(ActionItem)
  @summary("Delete a single action item belonging to the specified team")
  delete(...Parameters.TeamActionitem): ActionItem;
}
