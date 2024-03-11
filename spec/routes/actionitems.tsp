import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace RetroSpec;

@tag("Action Items")
namespace ActionItems {
  model ActionItem {
    @key @visibility("read") id: Id;
    task: string;
    completed?: boolean = false;
    assignee?: string;
  }

  @route("/teams/{teamId}/actionitems")
  namespace ByTeam {
    model Parameters {
      @path @segment("teams") teamId: Id;
    }

    @doc("List all action items belonging to the specified team")
    op list(...Parameters): ActionItem[] | UnauthorizedResponse | NotFoundResponse;

    @doc("Create a new action item belonging to the specified team")
    @post op create(...Parameters, @body actionItem: ActionItem): ActionItem | UnauthorizedResponse | NotFoundResponse;

    @doc("Retrieve a single action item belonging to the specified team")
    op read(...Parameters, @path id: Id): ActionItem | UnauthorizedResponse | NotFoundResponse;

    @doc("Update a single action item belonging to the specified team")
    @patch op update(...Parameters, @path id: Id, @body actionItem: ActionItem): ActionItem | UnauthorizedResponse | NotFoundResponse;

    @doc("Delete a single action item belonging to the specified team")
    @delete op delete(...Parameters, @path id: Id): ActionItem;
  }
}
